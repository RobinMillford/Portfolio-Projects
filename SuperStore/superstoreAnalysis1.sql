use SuperStore;
select * from superstore_data;

--percentage of total orders were shipped on the same date
SELECT 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM superstore_data) AS percentage
FROM 
    superstore_data
WHERE 
    Order_Date = Ship_Date;


--top 3 customers with highest total value of orders.
SELECT 
    TOP 3 
    Customer_Name, 
    SUM(Sales) AS Total_Sales
FROM 
    superstore_data
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales DESC;

--the top 5 items with the highest average sales per day.
SELECT
Top 5
    Product_Name, 
    AVG(Sales) AS Avg_Sales_Per_Day
FROM 
    superstore_data
WHERE 
    Ship_Date > Order_Date
GROUP BY 
    Product_Name
ORDER BY 
    Avg_Sales_Per_Day DESC
;

--the average order value for each customer, and rank the customers by their average order value.
SELECT 
    Customer_Name, 
    AVG(Sales) AS Avg_Order_Value
FROM 
    superstore_data
GROUP BY 
    Customer_Name
ORDER BY 
    Avg_Order_Value DESC;

--the name of customers who ordered highest and lowest orders from each city.
WITH 
    CTE AS (
        SELECT 
            *,
            ROW_NUMBER() OVER (
                PARTITION BY 
                    City
                ORDER BY 
                    Sales DESC
            ) AS Row_Num_Highest,
            ROW_NUMBER() OVER (
                PARTITION BY 
                    City
                ORDER BY 
                    Sales ASC
            ) AS Row_Num_Lowest
        FROM 
            superstore_data
    )
SELECT 
    CTE.City,
    MAX(CASE WHEN CTE.Row_Num_Highest = 1 THEN CTE.Customer_Name END) AS Customer_With_Highest_Order,
    MAX(CASE WHEN CTE.Row_Num_Lowest = 1 THEN CTE.Customer_Name END) AS Customer_With_Lowest_Order
FROM 
    CTE
GROUP BY 
    CTE.City;

--the most demanded sub-category in the west region
SELECT
Top 1
    Sub_Category,
    SUM(Sales) AS Total_Sales
FROM 
    superstore_data
WHERE 
    Region = 'West'
GROUP BY 
    Sub_Category
ORDER BY 
    Total_Sales DESC;

--the highest number of items
SELECT
Top 1
    Order_ID, 
    COUNT(Product_ID) AS Number_of_Items 
FROM 
    superstore_data 
GROUP BY 
    Order_ID 
ORDER BY 
    Number_of_Items DESC;

--the highest cumulative value
SELECT
Top 1
    Order_ID, 
    SUM(Sales) AS Cumulative_Value 
FROM 
    superstore_data 
GROUP BY 
    Order_ID 
ORDER BY 
    Cumulative_Value DESC;

--segment’s order is more likely to be shipped via first class
SELECT 
    Segment, 
    COUNT(*) AS Total_Orders, 
    SUM(CASE WHEN Ship_Mode = 'First Class' THEN 1 ELSE 0 END) AS First_Class_Orders, 
    ROUND(SUM(CASE WHEN Ship_Mode = 'First Class' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS First_Class_Percentage
FROM 
    superstore_data 
GROUP BY 
    Segment;

SELECT
TOP 1
    City, 
    SUM(Sales) AS Total_Revenue 
FROM 
    superstore_data 
GROUP BY 
    City 
ORDER BY 
    Total_Revenue ASC ;

 --the average time for orders to get shipped after order is placed
SELECT 
    AVG(DATEDIFF(day, Order_Date, Ship_Date)) AS Avg_Shipping_Time 
FROM 
    superstore_data;

--segment places the highest number of orders from each state and which segment places the largest individual orders from each state
SELECT 
    sd.State, 
    sq1.Highest_Number_Of_Orders_Segment, 
    sq2.Largest_Individual_Orders_Segment
FROM 
    superstore_data sd
JOIN 
    (SELECT 
         State, 
         Segment AS Highest_Number_Of_Orders_Segment, 
         ROW_NUMBER() OVER (PARTITION BY State ORDER BY COUNT(*) DESC) AS Row_Num 
     FROM 
         superstore_data 
     GROUP BY 
         State, Segment) sq1
ON 
    sd.State = sq1.State AND sd.Segment = sq1.Highest_Number_Of_Orders_Segment AND sq1.Row_Num = 1
JOIN 
    (SELECT 
         State, 
         Segment AS Largest_Individual_Orders_Segment, 
         ROW_NUMBER() OVER (PARTITION BY State ORDER BY SUM(Sales) DESC) AS Row_Num 
     FROM 
         superstore_data 
     GROUP BY 
         State, Segment) sq2
ON 
    sd.State = sq2.State AND sd.Segment = sq2.Largest_Individual_Orders_Segment AND sq2.Row_Num = 1


