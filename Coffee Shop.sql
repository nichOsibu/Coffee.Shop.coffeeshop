/*

SELECT *
FROM coffee.shop.coffeeshopsales;

-- NUMBER OF HIGHEST_PRODUCT_SOLD, LOWEST AND HIGHEST 
SELECT SUM(transaction_qty) AS number_of_units_sold
FROM    coffee.shop.coffeeshopsales;

SELECT MIN(product_category) AS lowest_product_sold  
FROM    coffee.shop.coffeeshopsales

SELECT MAX(product_category) AS lowest_product_sold  
FROM    coffee.shop.coffeeshopsales
-- MAKING THIS OUR MAIN FOCUS POINT

  
-- calculate total revenua per_transaction + total_revenue 

SELECT  transaction_qty*unit_price AS revenue_per_transaction
        FROM coffee.shop.coffeeshopsales;
        

SELECT  SUM(transaction_qty*unit_price) AS total_revenue, 
        product_category
        FROM coffee.shop.coffeeshopsales
        GROUP BY PRODUCT_CATEGORY
        ORDER BY total_revenue DESC;

-- strores over with sales revenue over 100000.
SELECT  store_location, SUM(unit_price * transaction_qty) AS total_sales
        FROM coffee.shop.coffeeshopsales 
        GROUP BY store_location
        HAVING SUM(unit_price * transaction_qty) > 100000;

-- sales trends 
SELECT  SUM(TRANSACTION_QTY * UNIT_PRICE) AS TOTAL_SALES,
        PRODUCT_TYPE
        FROM coffee.shop.coffeeshopsales 
        GROUP BY PRODUCT_TYPE
        ORDER BY TOTAL_SALES DESC;

SELECT -- Profit around all the stores
  store_location, 
  SUM(transaction_qty * unit_price) AS total_revenue, 
  SUM(transaction_qty * unit_price) AS total_cost, 
  SUM(transaction_qty * unit_price) AS total_profit
FROM 
  coffee.shop.coffeeshopsales
GROUP BY 
  store_location
ORDER BY 
  total_profit DESC;


    
-- transaction based on qty in different locations.
SELECT  transaction_id, 
        transaction_qty, 
        store_location, 
        unit_price, 
        product_type, 
        product_detail 
FROM    coffee.shop.coffeeshopsales 
ORDER BY unit_price ASC;

-- the earliest time our shops open. 
SELECT  MIN(transaction_time)
FROM    coffee.shop.coffeeshopsales


-- the time our shops closes.
SELECT MAX(transaction_time)
FROM    coffee.shop.coffeeshopsales

-- time frames

SELECT dateadd(DAY, 7, '2023-05-01') AS add_seven_days
FROM coffee.shop.coffeeshopsales;

SELECT MONTHNAME(transaction_date) AS month_name
FROM coffee.shop.coffeeshopsales;


SELECT dateadd(DAY, 7, '2023-05-01') AS add_seven_days
FROM coffee.shop.coffeeshopsales;

SELECT MONTHNAME(transaction_date) AS month_name
FROM coffee.shop.coffeeshopsales;





SELECT CURRENT_DATE()-1 -- gives me the date seven days ago .
 transaction_id, 
        transaction_qty, 
        store_location, 
        unit_price, 
        product_type, 
        product_detail 
FROM    coffee.shop.coffeeshopsales 
ORDER BY unit_price ASC;

SELECT CURRENT_DATE()-7 -- gives me the date seven days ago .
 transaction_id, 
        transaction_qty, 
        store_location, 
        unit_price, 
        product_type, 
        product_detail 
FROM    coffee.shop.coffeeshopsales 
ORDER BY unit_price ASC;

SELECT CURRENT_DATE()-30 -- gives me the date thirty one days back.
 transaction_id, 
        transaction_qty, 
        store_location, 
        unit_price, 
        product_type, 
        product_detail 
FROM    coffee.shop.coffeeshopsales 
ORDER BY unit_price ASC;

*/

-- Final query for analysis.
SELECT  
        SUM(transaction_qty * unit_price) AS total_revenue, 
        SUM(transaction_qty * unit_price) AS total_cost, 
        SUM(transaction_qty * unit_price) AS total_profit,
        
        SUM(unit_price * transaction_qty) AS total_sales,
        SUM(transaction_qty) AS number_of_units_sold,
        MIN(product_category) AS lowest_product_sold,
        MAX(product_category) AS lowest_product_sold,
        MIN(transaction_time),
        MAX(transaction_time),
        TO_CHAR(transaction_date,'YYYYMM')AS month_id,
        MONTHNAME(transaction_date) AS month_name,
        DAYNAME (transaction_date) AS day_name,

        DATEADD(DAY, 30, '2023-05-01') AS add_seven_days,
        DATEADD(DAY, 7, '2023-05-01') AS add_seven_days,
        CURRENT_DATE() ,
        CURRENT_DATE()-7,
        CURRENT_DATE()-30, 
         
        

    CASE
        WHEN transaction_time BETWEEN '06:00:00' AND '09:59:59' THEN 'morning'
        WHEN transaction_time BETWEEN '10:00:00' AND '14:59:59' THEN 'afternoon'
        WHEN transaction_time BETWEEN '15:00:00' AND '19:59:59' THEN 'evening'
        ELSE 'night'
    END AS time_bucket,

    CASE
        WHEN SUM(transaction_qty*unit_price) BETWEEN 0 AND 20 THEN 'low'
        WHEN SUM(transaction_qty*unit_price) BETWEEN 21 AND 40 THEN 'med'
        WHEN SUM(transaction_qty*unit_price) BETWEEN 41 AND 60 THEN 'high'
    ELSE 'very high'
    END AS spend_bands,
        store_location, 
        unit_price, 
        product_type, 
        product_detail,
        
        
    FROM coffee.shop.coffeeshopsales
    GROUP BY time_bucket, 
        store_location, 
        unit_price, 
        product_type, 
        product_detail,
        month_id,
        month_name,
        day_name;
        















   
