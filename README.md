# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_1`

This project demonstrates core data analysis skills using SQL to analyze retail sales data. It covers the entire workflow from database setup and data cleaning to exploratory data analysis(EDA) and answering key business questions. This is a practical, hands-on project for aspiring data analysts to build their portfolio and resume.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_1`.
- **Data Import and Table Creation**: The sales data was directly imported into the Microsoft SQL Server database from a CSV file named SQL - Retail Sales Analysis_utf. This process automatically created a table named retail_sales_analysis within the database. The resulting table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_1;
use sql_project_1
select top 10 * from retail_sales_analysis order by transactions_id 

```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales_analysis;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales_analysis;
SELECT DISTINCT category FROM retail_sales_analysis;

SELECT * FROM retail_sales_analysis
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales_analysis
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales_analysis
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select * from Retail_Sales_Analysis
where category='clothing' and 
quantiy>4 and FORMAT(sale_date,'yyyy-mm')='2022-11'
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select Category ,sum(total_sale) as Total_sales, COUNT(*) as 
Total_orders
from Retail_Sales_Analysis
group by category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select round(avg(age)*1.0,2) as average_age from Retail_Sales_Analysis
where category ='Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from Retail_Sales_Analysis
where total_sale>1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category,gender,COUNT(transactions_id) 
from Retail_Sales_Analysis
group by gender,category
order by category,gender
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
select * from (
SELECT  
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS avg_sale,
		DENSE_RANK() over(PARTITION by YEAR(sale_date) order by AVG(total_sale) DESC ) as 'rank'
    FROM Retail_Sales_Analysis
	group by YEAR(sale_date),MONTH(sale_date)
    )k
	where RANK =1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT TOP 5 customer_id, total_sales
FROM (
    SELECT 
        customer_id,
        SUM(total_sale) AS total_sales,
        DENSE_RANK() OVER (ORDER BY SUM(total_sale) DESC) AS rank
    FROM Retail_Sales_Analysis
    GROUP BY customer_id
) AS ranked_customers
ORDER BY total_sales DESC;
------------------------------- OR ----------------------------------------------------
select top 5 customer_id,SUM(total_sale)as Total_sales from Retail_Sales_Analysis
group by customer_id
order by Total_sales DESC
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql

SELECT category,COUNT(distinct customer_id) as unique_customers
FROM Retail_Sales_Analysis
group by category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
with hourly_sale 
as
(
select * ,
     case 
	     when datepart(hour,sale_time )<12 then 'Morning'
		 when datepart(hour,sale_time ) between 12 and 17 then 'Afternoon'
		 when datepart(hour,sale_time )>17 then 'Evening'
		end as shift
from Retail_Sales_Analysis
)
select shift,COUNT(*) as total_orders from hourly_sale 
group by shift
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

## Author - Mohit Rathore

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

Thank you for your support, and I look forward to connecting with you!
