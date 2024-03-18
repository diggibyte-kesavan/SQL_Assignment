use ecommerce;

-- create table product_details and insert data
CREATE TABLE product_details (
    sell_date DATE,
    product VARCHAR(50)
);

--see the product_details table

select * from product_details;


-- insert data into product_details
INSERT INTO product_details (sell_date, product) VALUES
('2020-05-30', 'Headphones'),('2020-06-01', 'Pencil'),('2020-06-02', 'Mask'),
('2020-05-30', 'Basketball'),('2020-06-01', 'Book'),('2020-06-02', 'Mask'),('2020-05-30', 'T-Shirt');

-- Query to find the number of different products sold and their names for each date

SELECT
    sell_date,
    COUNT(distinct product) AS num_sold,
    STRING_AGG(product,', ') AS product_list
FROM
    product_details
GROUP BY
    sell_date;