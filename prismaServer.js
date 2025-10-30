import express from "express";
import { PrismaClient } from "@prisma/client";
import dotenv from "dotenv";

dotenv.config();
const app = express();
const prisma = new PrismaClient();

app.use(express.json());

app.get("/", (req, res) => {
  res.send("✅ Prisma server is running");
});


// CREATE
app.post("/users", async (req, res) => {
  const user = await prisma.users.create({ data: req.body });
  res.json(user);
});

// READ
app.get("/users", async (req, res) => {
  const users = await prisma.users.findMany();
  res.json(users);
});

// UPDATE
app.put("/users/:id", async (req, res) => {
  const { id } = req.params;
  const user = await prisma.users.update({
    where: { user_id: Number(id) },
    data: req.body,
  });
  res.json(user);
});

// DELETE
app.delete("/users/:id", async (req, res) => {
  const { id } = req.params;
  await prisma.users.delete({ where: { user_id: Number(id) } });
  res.send("User deleted");
});

app.listen(4001, () => console.log("✅ Prisma server on port 4001"));
