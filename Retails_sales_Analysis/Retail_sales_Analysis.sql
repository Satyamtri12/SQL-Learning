-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;


-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
SELECT 
    *
FROM
    retail_sales;
SELECT 
    COUNT(*)
FROM
    retail_sales
    -- Data Cleaning
    
SELECT 
    *
FROM
    retail_sales
WHERE
    transaction_id IS NULL;
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date IS NULL;
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_time IS NULL;  
select * from retail_sales where transaction_id is null
or sale_date is null
or sale_time is null
or gender is null
or category is null
or quantity is null
or cogs is null
or total_sale is null

-- Data Exploration
-- How many Sales we have?

select count(*) as total_sale from retail_sales

-- How many unique customers we have ?
select count( distinct customer_id) as total_sale from retail_sales
select distinct category from retail_sales

-- Data Analysis & Business Key Problems and Answer
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in month of Nov-2022?
SELECT 
    category, SUM(quantity) AS total_quantity
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantity > 10
        AND sale_date >= '2022-11-01'
        AND sale_date < '2022-12-01'
GROUP BY category;

-- Q.3 Write a SQL query to calculate the total_sale for each category.
select 
category, sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. 
SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM
    retail_sales
WHERE
    category = 'Beauty';

-- Q.5 Write a SQl query to find all transactions where the total_sale is greater than 1000. 
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transaction_id made by each gender in each category. 
SELECT 
    category, gender, COUNT(*) AS total_trans
FROM
    retail_sales
GROUP BY category , gender
ORDER BY 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year. 
SELECT 
    YEAR(sale_date),
    MONTH(sale_date),
    AVG(total_sale) AS avg_sale
FROM
    retail_sales
GROUP BY 1 , 2
ORDER BY 1 , 3 DESC;
     
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales. 
SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
       
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category. 
SELECT 
    category, COUNT(DISTINCT customer_id) AS unique_customer
FROM
    retail_sales
GROUP BY category   
       
-- Q.10 Write a SQL query to create each shift and number of orders ( Example Morning <=12, Afternoon Between 12 & 17, Evening>17). 
with hourly_sale
as (
SELECT *,
    CASE
        WHEN HOUR(sale_time) <= 12 THEN 'Morning'
        WHEN HOUR(sale_time) > 12 AND HOUR(sale_time) <= 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift from retail_sales
    )
    select shift, count(*) as total_orders
    from hourly_sale
    group by shift





