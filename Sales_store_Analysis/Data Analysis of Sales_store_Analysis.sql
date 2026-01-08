-- DATA ANALYSIS --

-- 1. What are the top 5 most selling products by quantity?
select * from sales_store
select top 5 product_name, sum(quantity) as total_quantity_sold
from sales
where status='delivered'
group by product_name
order by total_quantity_sold DESC 
-- Business Impact: Helps prioritize stock and boost sales through targeted promotions.

--2. Which product are most frequently cancelled?
select top 5 product_name, count(*) as total_cancelled
from sales
where status='cancelled'
group by product_name
order by total_cancelled DESC
-- Business Impact: Identify poor-performing products to improve quality or revenue from catalog.

--3. What time of the day has the highest number of purchase?
select * from sales
select case 
            when datepart(hour, time_of_purchase) between 0 and 5 then 'Night'
            when datepart(hour, time_of_purchase) between 6 and 11 then 'Morning'
            when datepart(hour, time_of_purchase) between 12 and 17 then 'Afternoon'
            when datepart(hour, time_of_purchase) between 18 and 23 then 'Evening'
       end AS time_of_day,
       count(*) as total_orders
       from sales
       group by 
       case
            when datepart(hour, time_of_purchase) between 0 and 5 then 'Night'
            when datepart(hour, time_of_purchase) between 6 and 11 then 'Morning'
            when datepart(hour, time_of_purchase) between 12 and 17 then 'Afternoon'
            when datepart(hour, time_of_purchase) between 18 and 23 then 'Evening'
       end 
       order by total_orders desc
-- Business Impact: Optimize staffing, promotions and server loads.

-- 4. Who are the top 5 highest spending customers?
select top 5 customer_name, format(sum(price*quantity), 'C0','en-IN') as total_spend
from sales
--where status = 'delivered'
group by customer_name
order by sum(price*quantity) desc
-- Business Impact: Personalized offers, loyalty rewards, adn retention.

--5.  Which product category generate the highest revenue?
select * from sales 
select product_category, format(sum(quantity*price),'C0', 'en-IN') as total_revenue
from sales 
group by product_category
order by sum(quantity*price) desc
-- Business Impact: Refine Product strategy, supply chain, and promotions.
-- Allowing the business to invest more in High-margin or high-demand categories.

-- 6. What is the return\cancellation rate per product category?
-- cancellation
select product_category,
              format(count(case when status='cancelled' then 1 end)*100.0/count(*), 'N3')+ ' %' AS cancelled_percent
              from sales 
              group by product_category
              order by cancelled_percent DESC
-- return
select product_category,
              format(count(case when status='returned' then 1 end)*100.0/count(*), 'N3')+ ' %' AS return_percent
              from sales 
              group by product_category
              order by return_percent DESC

-- Business Impact: Reduce returns, improve product descriptions/expectations Helps identify and fix product or logistics issues.

--7. What is the most preferred payment mode?
select * from sales
select payment_mode, count(payment_mode) AS total_count
from sales 
group by payment_mode 
order by total_count desc
-- Business Impact: Streamline payment processing, prioritize popular modes.

--8. How does age group affect purchasing behavior?
-- select * from sales 
 --select min(customer_age), max(customer_age) from sales 
 select case 
            when customer_age between 18 and 25 then '18-25'
            when customer_age between 26 and 35 then '26-35'
            when customer_age between 36 and 50 then '36-50'
            else '51+'
            end as customer_age,
            format(SUM(price*quantity), 'C0', 'en-IN') AS total_purchase
from sales
group by case 
            when customer_age between 18 and 25 then '18-25'
            when customer_age between 26 and 35 then '26-35'
            when customer_age between 36 and 50 then '36-50'
            else '51+'
            end
order by sum(price*quantity) DESC
-- Business Impact: Targeted marketing and product recommendations by age group.

-- 9. What is the monthly sales Trend?
select * from sales 
-- Method 01
select format(purchase_date,'yyyy-MM') as Month_year,
format(SUM(price*quantity), 'c0','en-IN') as total_sales,
sum(quantity) as total_quantity
from sales group by format(purchase_date,'yyyy-MM')

-- method 02
select year(purchase_date) as years,
       month(purchase_date) as Months,
       format(sum(price*quantity), 'c0', 'en-IN') as total_sales,
       sum(quantity) as total_quantity
       from sales
       group by year(purchase_date), MONTH(purchase_date)
       order by months 
-- Business Impact: Plan inventory and marketing according to seasonal trends.

-- 10. Are certain Genders buying more specific product categories?

--Method 01
select gender, product_category, count(product_category) as total_purchase
from sales 
group by gender, product_category 
order by gender 

-- Mehtod 02
select * from (
              select gender, product_category 
              from sales 
              ) as source_table
PIVOT (
       count(gender)
       for gender in ([M],[F])
       ) AS pivot_table
order by product_category
-- Business Impact: Personalized ads, gender-focused campaigns.































































