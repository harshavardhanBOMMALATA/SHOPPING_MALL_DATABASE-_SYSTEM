# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Shopping MALL Sales Analysis  
**Level**: Beginner  
**Database**: 'SHOPPING MALL sales DATABASE'

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a sales section database**: Create and populate a shopping mall sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select *
from Sales 
where sale_date='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.**:
```sql
select *
  from Sales
  where category='Clothing' and quantity>4 and date_format(sale_date,'%Y-%M')='11-2022';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category,count(*) as total_sales,sum(total_sale) as net_sale
from Sales
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select category,round(avg(age),1) as average_age
from sales
where category='Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select transaction_id 
from sales
where total_sale>1000;
```

6. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**:
```sql
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
```

7. **Write a SQL query to find the top 5 customers based on the highest total sales.**:
```sql
select customer,gender,count(*) as number_of_times,sum(total_sale) as total_sales 
from Sales
group by customer,gender
order by total_sales desc
limit 5;
```

8. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer) as cnt_unique_cs
FROM Sales
GROUP BY category
```

9. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).**:
```sql
SELECT 
  CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS total_orders
FROM Sales
GROUP BY shift;
```

10. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `retail_sales.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - HARSHAVARDHAN BOMMALATA

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

## STAY CONNECTED

-**LinkedIn**:[Connect me professionally](https://www.linkedin.com/in/harshavardhan-bommalata-7bb9442b0/)

-**Gmail**:[Suggest me ideas](hbommalata@gmail.com)

-**instagram**:[For personal chats](https://www.instagram.com/always_harsha_royal/)

Thank you for your support, and I look forward to connecting with you!
