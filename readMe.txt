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