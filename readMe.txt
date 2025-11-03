The Muslim Ticket App Backend

This folder contains the main files for The Muslim Ticket App Backend. It includes the database design, SQL version, and Prisma version of the code.



ERD Diagram

The image inside this folder is the ERD (Entity Relationship Diagram).
It visually explains how the app’s data is connected.



SQL File

This file contains the database structure written in SQL.
It has all the tables used in the app, such as:

Users
Roles and more

This version can be used directly in a database like PostgreSQL or Neon.



Express Server with SQL (sqlServer.js)

This JavaScript file shows how to connect the database using raw SQL queries.
It includes:

POST → to add new users

GET → to fetch all users

PUT → to update user data

DELETE → to remove users



Express Server with Prisma (prismaServer.js)

This is another version of the same API — but it uses Prisma, a modern database tool that makes queries easier to write and manage.
It performs the same actions (POST, GET, PUT, DELETE) but through Prisma’s syntax instead of manual SQL.



authController.js

Handles all authentication logic such as Signup, OTP Verification, Login, Forgot Password, Reset Password, and Profile Update.
It uses Prisma ORM to connect with the PostgreSQL database and also sends OTP emails using Nodemailer.
All major actions like creating a user, verifying OTP, or updating a password are handled inside this file.

prismaServer2.js

It connects the backend routes (like /signup, /verify-otp, /signin, etc.) to the functions written in authController.js.
It also starts the server and listens for API requests.