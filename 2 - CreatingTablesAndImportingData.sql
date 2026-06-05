-- Create Tables

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;

CREATE TABLE Books(
  Book_ID SERIAL PRIMARY KEY,
  Title VARCHAR(100),
  Author VARCHAR(100),
  Genre VARCHAR(50),
  Published_Year INT,
  Price NUMERIC(10,2),
  Stock INT
);

CREATE TABLE Customers(
  Customer_ID SERIAL PRIMARY KEY,
  Name VARCHAR(100),
  Email VARCHAR(100),
  Phone VARCHAR(15),
  City VARCHAR(80),
  Country VARCHAR(150)
);

CREATE TABLE Orders(
  Order_ID SERIAL PRIMARY KEY,
  Customer_ID INT REFERENCES Customers(Customer_ID),
  Book_ID INT REFERENCES Books(Book_ID),
  Order_Date DATE,
  Quantity INT,
  Total_Amount NUMERIC(10,2)
);


-- Note: Update the file path below to match your local system before running.
-- Example: FROM 'C:/your_folder/datasets/Books.csv'
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'D:/Analysis/Projects/Online-Bookstore-SQL/datasets/Books.csv'
DELIMITER ','
CSV HEADER;

-- Note: Update the file path below to match your local system before running.
-- Example: FROM 'C:/your_folder/datasets/Customers.csv'
COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'D:/Analysis/Projects/Online-Bookstore-SQL/datasets/Customers.csv'
DELIMITER ','
CSV HEADER;

-- Note: Update the file path below to match your local system before running.
-- Example: FROM 'C:/your_folder/datasets/Orders.csv'
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'D:/Analysis/Projects/Online-Bookstore-SQL/datasets/Orders.csv'
DELIMITER ','
CSV HEADER;

----------

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


---BASIC QUERIES:

--1) Retrieve all Books in the "Fiction" Genre.
SELECT * FROM Books
WHERE genre = 'Fiction';

--2) Find books published after the year 1950.
SELECT * FROM Books
WHERE published_year > 1950;

--3) List all customers from Canada.
SELECT * FROM Customers
WHERE country = 'Canada';

--4) Show orders placed in November 2023.
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--5) Retrieve the total stock of books available.
SELECT SUM(stock) AS Total_Stock
FROM Books;

--6) Find the details of the most expensive book.
SELECT * FROM Books
ORDER BY price DESC
LIMIT 1;

--7) Show all customers who ordered more than 1 quantity of a book.
SELECT * FROM Orders
WHERE quantity > 1;

--8) Retrieve all orders where the total amount exceeds $20.
SELECT * FROM Orders
WHERE total_amount > 20;

--9) List all genres available in the Books table.
SELECT DISTINCT genre
FROM Books;

--10) Find the book with the lowest stock.
SELECT * FROM Books
ORDER BY stock ASC
LIMIT 1;

--11) Calculate the total revenue generated from all orders.
SELECT SUM(total_amount) AS total_revenue
FROM Orders;


---ADVANCE QUERIES:

--1) Retrieve the total number of books sold for each genre.
SELECT b.genre, SUM(o.quantity) AS Total_Books_Sold
FROM Orders AS o
JOIN Books AS b ON o.book_id = b.book_id
GROUP BY b.genre;

--2) Find the average price of books in the "Fantasy" genre.
SELECT AVG(price) AS Avg_Price
FROM Books
WHERE genre = 'Fantasy';

--3) List customers who have placed at least 2 orders.
SELECT c.customer_id, c.name, COUNT(o.order_id) AS Order_Count
FROM Orders AS o
JOIN Customers AS c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2;

--4) Find the most frequently ordered book.
SELECT o.book_id, b.title, COUNT(o.order_id) AS Order_Count
FROM Orders AS o
JOIN Books AS b ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY Order_Count DESC
LIMIT 1;

--5) Show the top 3 most expensive books of 'Fantasy' Genre.
SELECT book_id, title, price
FROM Books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

--6) Retrieve the total quantity of books sold by each author.
SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM Orders AS o
JOIN Books AS b ON o.book_id = b.book_id
GROUP BY b.author;

--7) List the cities where customers have placed at least one order of over $30.
SELECT DISTINCT c.city
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
WHERE o.total_amount > 30;

--8) List the cities where customers whose total spending exceeds $30 are located.
SELECT DISTINCT c.city
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 30;

--9) Find the customer who spent the most on orders.
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM Orders AS o
JOIN Customers AS c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_Spent DESC
LIMIT 1;

--10) Calculate the stock remaining after fulfilling all orders.
SELECT b.book_id, b.title, b.stock,
       COALESCE(SUM(o.quantity), 0) AS Total_Ordered,
       b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Stock
FROM Books AS b
LEFT JOIN Orders AS o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id ASC;