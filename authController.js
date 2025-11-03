import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";
import dotenv from "dotenv";

dotenv.config();
const prisma = new PrismaClient();


const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: { user: process.env.EMAIL_USER, pass: process.env.EMAIL_PASS },
});


const generateOTP = () => Math.floor(100000 + Math.random() * 900000).toString();

// ---------- SIGNUP ----------
export const signup = async (req, res) => {
  const { first_name, last_name, email, password } = req.body;
  try {
    const existing = await prisma.users.findUnique({ where: { email } });
    if (existing) return res.status(400).json({ error: "Email already exists" });

    const hash = await bcrypt.hash(password, 10);
    const otp = generateOTP();

    await prisma.users.create({
      data: {
        first_name,
        last_name,
        email,
        password_hash: hash,
        otp_code: otp,
        otp_expires_at: new Date(Date.now() + 10 * 60 * 1000), 
      },
    });

    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: email,
      subject: "Muslim Ticket - Verify Your Account",
      text: `Your OTP code is ${otp}`,
    });

    res.json({ message: "User registered! Check your email for OTP." });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error during signup");
  }
};

// ---------- VERIFY OTP ----------
export const verifyOTP = async (req, res) => {
  const { email, otp } = req.body;
  try {
    const user = await prisma.users.findUnique({ where: { email } });
    if (!user) return res.status(404).json({ error: "User not found" });
    if (user.is_verified) return res.json({ message: "Already verified" });

    if (user.otp_code === otp && user.otp_expires_at > new Date()) {
      await prisma.users.update({
        where: { email },
        data: { is_verified: true, otp_code: null, otp_expires_at: null },
      });
      res.json({ message: "Email verified successfully!" });
    } else {
      res.status(400).json({ error: "Invalid or expired OTP" });
    }
  } catch (err) {
    res.status(500).send("Error verifying OTP");
  }
};

// ---------- SIGNIN ----------
export const signin = async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await prisma.users.findUnique({ where: { email } });
    if (!user) return res.status(404).json({ error: "User not found" });
    if (!user.is_verified) return res.status(400).json({ error: "Verify your email first" });

    const valid = await bcrypt.compare(password, user.password_hash);
    if (!valid) return res.status(400).json({ error: "Wrong password" });

    const accessToken = jwt.sign({ user_id: user.user_id }, process.env.JWT_SECRET, { expiresIn: "15m" });
    const refreshToken = jwt.sign({ user_id: user.user_id }, process.env.REFRESH_SECRET, { expiresIn: "7d" });

    res.json({ accessToken, refreshToken });
  } catch (err) {
    res.status(500).send("Error during signin");
  }
};

// ---------- FORGOT PASSWORD ----------
export const forgotPassword = async (req, res) => {
  const { email } = req.body;
  const otp = generateOTP();
  try {
    await prisma.users.update({
      where: { email },
      data: { otp_code: otp, otp_expires_at: new Date(Date.now() + 10 * 60 * 1000) },
    });

    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: email,
      subject: "Muslim Ticket - Password Reset OTP",
      text: `Your password reset OTP code is ${otp}`,
    });

    res.json({ message: "OTP sent for password reset" });
  } catch (err) {
    res.status(500).send("Error sending OTP");
  }
};

// ---------- RESET PASSWORD ----------
export const resetPassword = async (req, res) => {
  const { email, otp, new_password } = req.body;
  try {
    const user = await prisma.users.findUnique({ where: { email } });
    if (!user || user.otp_code !== otp || user.otp_expires_at < new Date())
      return res.status(400).json({ error: "Invalid or expired OTP" });

    const hash = await bcrypt.hash(new_password, 10);
    await prisma.users.update({
      where: { email },
      data: { password_hash: hash, otp_code: null, otp_expires_at: null },
    });

    res.json({ message: "Password reset successfully!" });
  } catch (err) {
    res.status(500).send("Error resetting password");
  }
};

// ---------- UPDATE PROFILE ----------
export const updateProfile = async (req, res) => {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) return res.status(401).json({ error: "Unauthorized" });

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const { first_name, last_name, phone } = req.body;
    const updated = await prisma.users.update({
      where: { user_id: decoded.user_id },
      data: { first_name, last_name, phone },
    });
    res.json(updated);
  } catch (err) {
    res.status(401).json({ error: "Invalid or expired token" });
  }
};
