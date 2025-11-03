import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import {
  signup,
  verifyOTP,
  signin,
  forgotPassword,
  resetPassword,
  updateProfile,
} from "./authController.js";

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => res.send("Muslim Ticket Auth API Running"));

app.post("/signup", signup);
app.post("/verify-otp", verifyOTP);
app.post("/signin", signin);
app.post("/forgot-password", forgotPassword);
app.post("/reset-password", resetPassword);
app.put("/update-profile", updateProfile);

app.listen(process.env.PORT || 4001, () =>
  console.log(`Server running on port ${process.env.PORT}`)
);
