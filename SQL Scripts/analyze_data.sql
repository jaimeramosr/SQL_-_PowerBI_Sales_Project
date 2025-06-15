SELECT *
FROM sales_data2;

-- Add two new columns: Revenue & profit
ALTER TABLE sales_data2
ADD COLUMN Total_Revenue DOUBLE;
UPDATE sales_data2
SET Total_Revenue = (Price_Per_Unit * Quantity_Purchased) - Discount_Applied;

ALTER TABLE sales_data2
ADD COLUMN Profit DOUBLE;
UPDATE sales_data2
SET Profit = Total_Revenue - (Cost_Price *Quantity_Purchased);

-- Analyze the Sales revenue & profit by Country
SELECT Country, ROUND(SUM(Total_Revenue),2) AS Total_Revenue, ROUND(SUM(Profit),2) As Total_Profit
FROM sales_data2
GROUP BY Country
ORDER BY Total_Revenue desc;

-- Analyze the top 5 best-selling products
SELECT Product_Name, SUM(Quantity_Purchased) AS Total_Units_Sold
FROM sales_data2
GROUP BY Product_Name
ORDER BY Total_Units_Sold desc
LIMIT 5;

-- Analyze the best 5 representatives
SELECT Sales_Rep, ROUND(SUM(Total_Revenue),2) AS Total_Revenue
FROM sales_data2
GROUP BY Sales_Rep
ORDER BY Total_Revenue desc
LIMIT 5;

-- Analyze the 5 store locations with highest sales from the last stored week
SELECT Store_Location, ROUND(SUM(Total_Revenue),2) AS Total_Revenue, ROUND(SUM(Profit),2) AS Total_Profit
FROM sales_data2
WHERE `Date` >= (
  SELECT MAX(`Date`) - INTERVAL 6 DAY
  FROM sales_data2
)
GROUP BY Store_Location
ORDER BY Total_Revenue desc
LIMIT 5;