# Online Bookstore SQL Project

## Project Overview
This project analyzes an online bookstore database using SQL (PostgreSQL).
It covers customer behavior, book inventory, and order analysis through
basic and advanced SQL queries.

## Database Structure
Three tables are used:
- **Books** – Book details like title, author, genre, price, and stock
- **Customers** – Customer information including city and country
- **Orders** – Order records with quantity and total amount

## Files in this Repository
- `1_CreateDatabase.sql` – Creates the database
- `2_CreateTablesAndImportData.sql` – Creates tables, imports data, and contains all queries
- `datasets/Books.csv` – Books dataset
- `datasets/Customers.csv` – Customers dataset
- `datasets/Orders.csv` – Orders dataset

## SQL Concepts Used
- SELECT, WHERE, GROUP BY, ORDER BY
- Aggregate functions: SUM, COUNT, AVG
- JOINs (INNER JOIN, LEFT JOIN)
- HAVING, DISTINCT, LIMIT
- COALESCE for handling NULL values

## How to Run
1. Install PostgreSQL and pgAdmin4
2. Run `1_CreateDatabase.sql` to create the database
3. Update the file paths in `2_CreateTablesAndImportData.sql` to match your local system
4. Run `2_CreateTablesAndImportData.sql` to create tables and import data
5. All queries are in the same file — run them individually as needed

## Tools Used
- PostgreSQL 18
- pgAdmin4