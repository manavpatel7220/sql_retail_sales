create database sql_project_p1;


-- create Table
DROP TABLE IF exists RETAI_SALES;

CREATE TABLE RETAIL_SALES
(
	transactions_id int PRIMARY KEY,
    sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(10),
	retail_salesage INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
    );
    
select * FROM RETAIL_SALES;

-- 

select * FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL;

select * FROM RETAIL_SALES
WHERE SALE_DATE IS NULL;
-- DATA CLEANING
select * FROM RETAIL_SALES
WHERE
	TRANSACTIONS_ID IS NULL
    or
    SALE_DATE IS NULL
    or
    SALE_TIME IS NULL
    or
    CUSTOMER_ID IS NULL
    OR
    GENDER IS NULL
    OR
    AGE IS NULL
    or
    CATEGORY IS NULL
    or
    QUANTIY IS NULL
    OR
    PRICE_PER_UNIT IS NULL
    or
    COGS IS NULL
    OR
    TOTAL_SALE IS NULL;
    
    
-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE?

select COUNT(*) AS TOTAL_SALE FROM retail_sales;

-- HOW MANY CUSTOMER WE HAVE??

SELECT  COUNT(DISTINCT(CUSTOMER_ID))
 AS TOTAL_SUTOMER FROM RETAIL_SALES;

-- HOW MANY CATEGORIES WE HAVE??
SELECT  DISTINCT(CATEGORY)
 AS TOTAL_CATEGORY FROM RETAIL_SALES;
 
 -- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS
 
 -- 1 .Write a SQL query to retrieve all columns for sales made on '2022-11-05:
 
 SELECT *
 FROM retail_sales
 WHERE sale_date = '2022-11-05';
 
-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
 
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4;

-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT CATEGORY,
SUM(total_sale) AS NET_SALE,
COUNT(*) AS TOTAL_ORDERS
FROM retail_sales
GROUP BY CATEGORY;

--  4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT round(avg(age),2) as average_age FROM RETAIL_SALES
WHERE CATEGORY = 'Beauty';

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales
where total_sale>1000;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
 select 
		category,
        gender,
        count(*) as total_transaction
from retail_sales
group by 
		category,
        gender
order by category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select 
	year(sale_date) as year,
    month(sale_date) as month,
    avg(total_sale) as avg_sale,
    rank() over(partition by year(sale_date) order by avg(total_sale) desc) 
    from retail_sales
 group by 1,2;
 
 -- **Write a SQL query to find the top 5 customers based on the highest total sales **:
 select 
		customer_id,
        sum(total_sale)as total_sales
 from retail_sales
 group by customer_id
 order by total_sales desc
 limit 5;
 
 -- Write a SQL query to find the number of unique customers who purchased items from each category.:
select 
		category,
        count(distinct(customer_id))  as unique_customer
from retail_sales
group by 1;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH HOURLY_SALES
AS
(
select * ,
		case
			when hour(sale_time) < 12 then 'MORNING'
			when hour(sale_time) between 12 and 17 then 'AFTERNOON'
            ELSE ' EVENING '
		end as shift
	
from retail_sales
)
select
	shift,
	count(*) as total_orders
    FROM HOURLY_SALES
GROUP BY shift

-- End of Project

