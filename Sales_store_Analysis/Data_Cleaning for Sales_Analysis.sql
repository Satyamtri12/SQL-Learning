create table sales_store(
transaction_id varchar(15),
customer_id varchar(15),
customer_name varchar(30),
customer_age int,
gender varchar(15),
product_id varchar(15),
product_name varchar(15),
product_category varchar(15),
quantiy int,
prce float,
payment_mode varchar(15),
purchase_date DATE,
time_of_purchase time,
status varchar (15)
);

select * from sales_store

set dateformat dmy
bulk insert sales_store
from 'C:\Users\satyam tripathi\Downloads\sales_store_updated_allign_with_video.csv'
  with (
  firstrow = 2,
  fieldterminator = ',',
  rowterminator = '\n'
);

-- Data Cleaning.

select * from sales_store

select * into sales from sales_store

select * from sales
select * from sales_store

-- To check for duplicate 

select transaction_id, count(*)
from sales 
group by transaction_id
having count(transaction_id)>1

with CTE as (
select *,
     Row_number() over (partition by transaction_id order by transaction_id) AS Row_Num
     from sales
)
select * from CTE
where transaction_id IN ('TXN240646',
'TXN342128','TXN855235','TXN981773')

-- we have to delete 4 rows that are duplicated.
with CTE as (
select *,
     Row_number() over (partition by transaction_id order by transaction_id) AS Row_Num
     from sales
)
DELETE FROM CTE
WHERE Row_num=2

-- Correction of Headers
EXEC sp_rename 'sales.quantiy','quantity','column'

select * from sales
EXEC sp_rename 'sales.prce','price','column'

-- To check Datatype

select column_name, data_type
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='sales'

-- To check for null count

DECLARE @SQL NVARCHAR(MAX) = '';

SELECT @SQL = STRING_AGG(
    'SELECT ''' + COLUMN_NAME + ''' AS ColumnName,
            COUNT(*) AS NullCount
     FROM ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + '
     WHERE ' + QUOTENAME(COLUMN_NAME) + ' IS NULL',
    ' UNION ALL '
)
WITHIN GROUP (ORDER BY COLUMN_NAME)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales';

-- Optional: see generated SQL for debugging
PRINT @SQL;

-- Execute the dynamic SQL
EXEC sp_executesql @SQL;

-- Treating null values
select * from sales where
transaction_id is null
or customer_id is null
or customer_age is null
or customer_name is null
or product_id is null
or product_name is null
or product_category is null
or quantity is null
or price is null
or payment_mode is null
or purchase_date is null
or time_of_purchase is null
or status is null

-- Deleting the first row of the Table.
DELETE FROM sales WHERE transaction_id is null

-- Now check for others
select * from sales
where Customer_name = 'Ehsaan Ram'

update sales
set customer_id='CUST9494'
where transaction_id='TXN977900'

select * from sales
where Customer_name = 'Damini Raju'

update sales
set customer_id='CUST1401'
where transaction_id='TXN985663

select * from sales where customer_id='CUST1003'
update sales
set customer_name='Mahika Saini',
customer_age='35',
gender='Male'
where transaction_id='TXN432798'

select * from sales

select distinct gender from sales

update sales
set gender = 'M'
where gender = 'Male'

update sales
set gender = 'F'
where gender = 'Female'

select distinct payment_mode
from sales
update sales
set payment_mode = 'Credit Card'
where payment_mode = 'CC'







