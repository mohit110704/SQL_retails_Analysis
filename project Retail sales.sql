-- SQL Retail Sales Analysis -Project 1


use sql_project_1

select top 10 * from retail_sales_analysis order by transactions_id 

select count(*) as Total_rows from retail_sales_analysis  

select * from retail_sales_analysis
where 
      transactions_id is null
	  or 
	  sale_date is null
	  or 
	  sale_time is null
	  or 
	  customer_id is null
	  or 
	  gender is null
	  or 
	  age is null
	  or 
	  category is null
	  or 
	  quantiy is null
	  or 
	  price_per_unit is null
	  or
	  cogs is null
	  or 
	  total_sale is null

delete from Retail_Sales_Analysis
where 
     transactions_id is null
	  or 
	  sale_date is null
	  or 
	  sale_time is null
	  or 
	  customer_id is null
	  or 
	  gender is null
	  or 
	  age is null
	  or 
	  category is null
	  or 
	  quantiy is null
	  or 
	  price_per_unit is null
	  or
	  cogs is null
	  or 
	  total_sale is null

select COUNT(*) from Retail_Sales_Analysis

-- Data exploration 

-- How many records we have 
select COUNT(*)  as Total_Records from Retail_Sales_Analysis

-- How many customers we have 
select  count(Distinct customer_id) as unique_customer  from Retail_Sales_Analysis 

-- How many categories we have 

select distinct category from Retail_Sales_Analysis

--



-- Data Analysis & Buisness Key Problem  & Answers 

--1.Write a SQL query to retrieve all columns for sales
--made on '2022-11-05:

select * from Retail_Sales_Analysis
where sale_date='2022-11-05'

--Write a SQL query to retrieve all transactions where 
--the category is 'Clothing' and the quantity sold is 
--more than 4 in the month of Nov-2022:

select * from Retail_Sales_Analysis
where category='clothing' and 
quantiy>4 and FORMAT(sale_date,'yyyy-mm')='2022-11'

--Write a SQL query to calculate the total sales (total_sale) for each category.:

select Category ,sum(total_sale) as Total_sales, COUNT(*) as 
Total_orders
from Retail_Sales_Analysis
group by category

--Write a SQL query to find the average age of customers who 
--purchased items from the 'Beauty' category.:

select round(avg(age)*1.0,2) as average_age from Retail_Sales_Analysis
where category ='Beauty'

--Write a SQL query to find all transactions where 
--the total_sale is greater than 1000.:
select * from Retail_Sales_Analysis
where total_sale>1000

--Write a SQL query to find the total number of transactions 
--(transaction_id) made by each gender in each category.:

select category,gender,COUNT(transactions_id) 
from Retail_Sales_Analysis
group by gender,category
order by category,gender

--Write a SQL query to calculate the average sale for 

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

--Write a SQL query to find the top 5 customers based on the 
--highest total sales :

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
------------------------------- OR ---------------
select top 5 customer_id,SUM(total_sale)as Total_sales from Retail_Sales_Analysis
group by customer_id
order by Total_sales DESC

--Write a SQL query to find the number of unique customers 
--who purchased items from each category.:

SELECT category,COUNT(distinct customer_id) as unique_customers
FROM Retail_Sales_Analysis
group by category

--Write a SQL query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17):
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