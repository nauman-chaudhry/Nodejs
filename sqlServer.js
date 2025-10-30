import express from "express";
import pkg from "pg";
import dotenv from "dotenv";
import cors from "cors";

dotenv.config();
const { Pool } = pkg;
const app = express();

app.use(cors());
app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false }, 
});

app.get("/", (req, res) => res.send("✅ API is running and connected to Neon!"));

// ---------- CREATE ----------
app.post("/users", async (req, res) => {
  const {
    role_id,
    first_name,
    last_name,
    email,
    password_hash,
    phone,
    is_verified,
  } = req.body;

  try {
    const result = await pool.query(
      `INSERT INTO users
       (role_id, first_name, last_name, email, password_hash, phone, is_verified, created_at, updated_at)
       VALUES ($1, $2, $3, $4, $5, $6, $7, NOW(), NOW())
       RETURNING *`,
      [role_id, first_name, last_name, email, password_hash, phone, is_verified]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error("❌ Error inserting user:", err);
    res.status(500).json({ error: err.message });
  }
});

// ---------- READ ALL ----------
app.get("/users", async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM users ORDER BY user_id DESC"
    );
    res.json(result.rows);
  } catch (err) {
    console.error("❌ Error fetching users:", err);
    res.status(500).json({ error: err.message });
  }
});

// ---------- READ SINGLE ----------
app.get("/users/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query("SELECT * FROM users WHERE user_id = $1", [
      id,
    ]);
    if (result.rows.length === 0)
      return res.status(404).json({ message: "User not found" });
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ---------- UPDATE ----------
app.put("/users/:id", async (req, res) => {
  const { id } = req.params;
  const {
    role_id,
    first_name,
    last_name,
    phone,
    is_verified,
    password_hash,
  } = req.body;

  try {
    const result = await pool.query(
      `UPDATE users
       SET role_id=$1, first_name=$2, last_name=$3, phone=$4,
           is_verified=$5, password_hash=$6, updated_at=NOW()
       WHERE user_id=$7
       RETURNING *`,
      [role_id, first_name, last_name, phone, is_verified, password_hash, id]
    );

    if (result.rows.length === 0)
      return res.status(404).json({ message: "User not found" });

    res.json(result.rows[0]);
  } catch (err) {
    console.error("❌ Error updating user:", err);
    res.status(500).json({ error: err.message });
  }
});

// ---------- DELETE ----------
app.delete("/users/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query("DELETE FROM users WHERE user_id=$1", [id]);
    if (result.rowCount === 0)
      return res.status(404).json({ message: "User not found" });
    res.json({ message: "User deleted successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(process.env.PORT || 4000, () =>
  console.log(`🚀 Server running on port ${process.env.PORT || 4000}`)
);
