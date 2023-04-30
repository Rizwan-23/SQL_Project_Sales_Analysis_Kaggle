-- [METADATA]:- 
Table Name:-kagglesales2
+-----------------------+--------------+
| Column Name           | Data Type    |
+-----------------------+--------------+
| ORDERNUMBER           | int          |
+-----------------------+--------------+
| QUANTITYORDERED       | int          |
+-----------------------+--------------+
| PRICEEACH             | double       |
+-----------------------+--------------+
| ORDERLINENUMBER       | int          |
+-----------------------+--------------+
| SALES                 | double       |
+-----------------------+--------------+
| ORDERDATE             | datetime     |
+-----------------------+--------------+
| STATUS                | text         |
+-----------------------+--------------+
| QTR_ID                | int          |
+-----------------------+--------------+
| MONTH_ID              | int          |
+-----------------------+--------------+
| YEAR_ID               | int          |
+-----------------------+--------------+
| PRODUCTLINE           | text         |
+-----------------------+--------------+
| MSRP                  | int          |
+-----------------------+--------------+
| PRODUCTCODE           | text         |
+-----------------------+--------------+
| CUSTOMERNAME          | text         |
+-----------------------+--------------+
| PHONE                 | text         |
+-----------------------+--------------+
| ADDRESSLINE1          | text         |
+-----------------------+--------------+
| ADDRESSLINE2          | text         |
+-----------------------+--------------+
| CITY                  | text         |
+-----------------------+--------------+
| STATE                 | text         |
+-----------------------+--------------+
| POSTALCODE            | text         |
+-----------------------+--------------+
| COUNTRY               | text         |
+-----------------------+--------------+
| TERRITORY             | text         |
+-----------------------+--------------+
| CONTACTLASTNAME       | text         |
+-----------------------+--------------+
| CONTACTFIRSTNAME      | text         |
+-----------------------+--------------+
| DEALSIZE              | text         |
+-----------------------+--------------+
-------------------------------------------------[Questions & SQL-Queries]---------------------------------------

-- [Question-1]:-Which month had the highest sales?
-- [Solution]:-In the month of November with the highest sales=2118885.67.

SELECT 
		MONTHNAME(ORDERDATE) AS month_name,
        SUM(SALES) AS total_sales
FROM kagglesales2
GROUP BY MONTHNAME(orderdate)
ORDER BY total_sales DESC 
LIMIT 1;

-- [Question-2]:-Which city sold the most products?
-- [Solution]:-Madrid city sold the most products which is 10958

SELECT CITY, SUM(QUANTITYORDER) AS TOTAL_PRODUCTS_SOLD
FROM kagglesales2
GROUP BY CITY
ORDER BY TOTAL_PRODUCTS_SOLD DESC
LIMIT 1;

-- [Question-3]:- What products are more often sold together?
-- [Solution]:- Product 'S18_2957' and 'S18_3136' both are often sold together their frequency is 26.

SELECT  t1.PRODUCTCODE, 
        t2.PRODUCTCODE, 
        COUNT(*) AS frequency
FROM kagglesales2 t1
JOIN kagglesales2 t2
ON t1.ORDERNUMBER = t2.ORDERNUMBER 
AND t1.PRODUCTCODE < t2.PRODUCTCODE
GROUP BY t1.PRODUCTCODE, t2.PRODUCTCODE
ORDER BY frequency DESC
LIMIT 1;

-- [Question-4]:-What is the most popular shipping method?
-- [Solution]:-Classic Cars is the most popular shipping method, with 967 times uses.

WITH cte AS (
  SELECT PRODUCTLINE,
         COUNT(PRODUCTLINE) AS frequency
  FROM kagglesales2
  GROUP BY PRODUCTLINE )
  SELECT PRODUCTLINE
  FROM cte
  WHERE frequency=(SELECT MAX(frequency) FROM cte);
  
  --C[Question-5]:-Which day of the week has the highest orders?
  --C[Solution]:-Friday is the day of the week which has generally high order in comparision to other days.
  
SELECT DAYNAME(ORDERDATE) AS day, 
       SUM(QUANTITYORDERED) AS total_order 
FROM kagglesales2 
GROUP BY DAYNAME(ORDERDATE) 
ORDER BY total_order DESC 
LIMIT 1;

-- [Question-6]:- What is the average order value?
-- [Solution]:- 83.69 is the average order value
  
WITH cte AS (
SELECT *, 
    QUANTITYORDERED*PRICEEACH AS correct_sales
FROM kagglesales2
  )
SELECT ROUND(SUM(correct_sales)/SUM(QUANTITYORDERED),2) AS average_order_sales
FROM cte

-- [Question-7]:-What are the top-5 best selling products?
-- [Solution]:-These are the top 5 products: 1-S18_3232, 2-S24_3856, 3-S18_4600, 4-S700_4002, 5-S12_4473

SELECT 
    PRODUCTCODE, 
    PRODUCTLINE, 
    SUM(QUANTITYORDERED) AS total_quantity_sold
FROM 
    kagglesales2
GROUP BY 
    PRODUCTCODE, 
    PRODUCTLINE
ORDER BY 
    total_quantity_sold DESC
LIMIT 5;

--C[Question-8]:-What time should we display advertisements to maximize customer engagement?
--C[Solution]:- At 00:00 hours.

SELECT HOUR(ORDERDATE) AS hour_of_day, COUNT(*) AS total_orders
FROM kagglesales2
GROUP BY hour_of_day
ORDER BY total_orders DESC
LIMIT 1;

-- [Question-9]:- How long does it take on average to ship a product?
-- [Solution]:- The data may be incomplete because there is no "shipped date" column in comparison to the "ordered date" column.

-- [Question-10]:- What is the correlation between discounts and quantity sold?

WITH cte AS (
SELECT *, MSRP-PRICEEACH AS discount
from kagglesales2
)
SELECT 
  ROUND(CORR(discount, QUANTITYORDERED,2) AS correlation
FROM 
  kagglesales2;



  
  


