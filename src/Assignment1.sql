--1.create database

create database ecommerce;

--select the database

use ecommerce;

--2. create the tables

CREATE TABLE gold_member_users (
    userid VARCHAR(30),
    signup_date DATE
);




CREATE TABLE users (
    userid VARCHAR(30),
    signup_date DATE
);

CREATE TABLE sales (
    userid VARCHAR(30),
    created_date DATE,
    product_id INT
);

CREATE TABLE product (
    product_id INT,
    product_name VARCHAR(50),
    price INT
);

--check the column name after rename the column

SELECT * FROM product;

--3. Insert the values provided above with respective datatypes

INSERT INTO gold_member_users (userid, signup_date) VALUES
('John','09-22-2017'),
('Mary','04-21-2017');

INSERT INTO users (userid, signup_date) VALUES
('John','09-02-2014'),
('Michel','01-15-2015'),
('Mary','04-11-2014');

INSERT INTO sales (userid, created_date, product_id) VALUES
('John','04-19-2017',2), ('Mary','12-18-2019',1), ('Michel','07-20-2020',3), ('John','10-23-2019',2),
('John','03-19-2018',3), ('Mary','12-20-2016',2), ('John','11-09-2016',1), ('John','05-20-2016',3),
('Michel','09-24-2017',1), ('John','03-11-2017',2), ('John','03-11-2016',1), ('Mary','11-10-2016',1),
('Mary','12-07-2017',2);

INSERT INTO product (product_id,product_name,price) VALUES
(1,'Mobile',980), (2,'Ipad',870), (3,'Laptop',330);

--4. all the tables in the same database(ecommerce)

SELECT * FROM INFORMATION_SCHEMA.tables;
select name from sys.tables;

--5. Count all the records of all four tables using single query

SELECT
    (SELECT COUNT(*) FROM gold_member_users) AS gold_member_users_count,
    (SELECT COUNT(*) FROM users) AS users_count,
    (SELECT COUNT(*) FROM sales) AS sales_count,
    (SELECT COUNT(*) FROM product) AS product_count;

--6.What is the total amount each customer spent on ecommerce company

SELECT sales.userid,SUM(product.price) AS total_spent
FROM sales
JOIN product ON sales.product_id = product.product_id
GROUP BY sales.userid;

--7.Find the distinct dates of each customer visited the website

select distinct created_date,userid from sales;

--8.Find the first product purchased by each customer using 3 tables(users, sales, product)

SELECT sales.userid, MIN(created_date) AS first_purchase_date, product_name
FROM users
JOIN sales ON users.userid = sales.userid
JOIN product ON sales.product_id = product.product_id
GROUP BY sales.userid, product_name;

--9. What is the most purchased item of each customer and how many times the customer has purchased it

SELECT userid, Count(product.product_name) AS item_count
FROM sales
JOIN product ON sales.product_id = product.product_id
GROUP BY userid
ORDER BY item_count DESC;

--10. Find out the customer who is not the gold_member_user

select userid from users where userid not in(select userid from gold_member_users);

--11 .What is the amount spent by each customer when he was the gold_member user

SELECT g.userid, SUM(p.price) AS total_amount_spent
FROM gold_member_users g
JOIN sales s ON g.userid = s.userid
JOIN product p ON s.product_id = p.product_id
GROUP BY g.userid;

--12 Find the Customers names whose name starts with M
-- using wildcards

select userid as customer_name from users where userid like 'M%';

--13 .Find the Distinct customer Id of each customer

select distinct userid from users;

--14 .Change the Column name from product table as price_value from price

exec sp_rename 'product.price', 'price_value', 'column';

-- 15.Change the Column value product_name – Ipad to Iphone from product table

update product set product_name='Iphone' where product_name='Ipad';

--16.Change the table name of gold_member_users to gold_membership_users

exec sp_rename 'gold_member_users' ,'gold_membership_users';

--see the tables after changing the table name

select name from sys.tables;

--17. Create a new column  as Status in the table crate above gold_membership_users  the Status values should be 2 Yes and No if the user is gold member, then status should be Yes else No

ALTER TABLE gold_membership_users
ADD Status VARCHAR(3);

UPDATE gold_membership_users
SET Status = 'Yes';

--18.Delete the users_ids 1,2 from users table and roll the back changes once both the rows are deleted one by one mention the result when performed roll back.

-- start a transaction
BEGIN TRANSACTION;

-- delete first record
delete from users where userid='John';

-- rollback the transaction
ROLLBACK TRANSACTION;

-- Check if the first record is still there
SELECT * FROM users;

BEGIN TRANSACTION;

-- Delete second record
DELETE FROM users WHERE userid = 'Michel';

ROLLBACK TRANSACTION;

-- Check the record
SELECT * FROM users;

--19.Insert one more record as same (3,'Laptop',330) as product table

INSERT INTO product (product_id, product_name, price_value) VALUES
(3, 'Laptop', 330);

select * from product;

--20. Write a query to find the duplicates in product table

SELECT product_id, product_name, price_value, COUNT(*)
FROM product
GROUP BY product_id, product_name, price_value
HAVING COUNT(*) > 1;

