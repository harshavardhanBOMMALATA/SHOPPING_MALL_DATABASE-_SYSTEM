-- SQL Retail Sales Analysis

create database if not exists 
Retail_sales;
use Retail_sales;

-- creating table
CREATE TABLE Sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    category VARCHAR(100),
    quantity INT,
    price_per DECIMAL(10,2),
    cogs DECIMAL(10,2),
    total_sale DECIMAL(10,2)
);

-- Sales table structure
desc Sales;

-- View  your data in table
delete from Sales where 
transaction_id>200;

select *from 
Sales;

select count(*) 
from Sales;

-- data exploration
select distinct customer from Sales;
select distinct category from Sales;

-- Some SQL questions and Queries 

-- 1.Write a SQL query to retrieve all columns for sales made on 2022-11-05.
select *
from Sales 
where sale_date='2022-11-05';

-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
select *
from Sales
where category='Clothing' and quantity>4 and date_format(sale_date,'%Y-%M')='11-2022';

-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.
select category,count(*) as total_sales,sum(total_sale) as net_sale
from Sales
group by category;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category,round(avg(age),1) as average_age
from sales
where category='Beauty';

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
select transaction_id 
from sales
where total_sale>1000;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(*) as total_transactions,gender,category 
from Sales 
group by gender,category 
order by total_transactions;

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
WITH MonthlySales AS (
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS average_monthly_sale
    FROM Sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT *
FROM MonthlySales m
WHERE average_monthly_sale = (
    SELECT MAX(average_monthly_sale)
    FROM MonthlySales
    WHERE sale_year = m.sale_year
);

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales.
select customer,gender,count(*) as number_of_times,sum(total_sale) as total_sales 
from Sales
group by customer,gender
order by total_sales desc
limit 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer) as cnt_unique_cs
FROM Sales
GROUP BY category

-- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
SELECT 
  CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS total_orders
FROM Sales
GROUP BY shift;

-- END --