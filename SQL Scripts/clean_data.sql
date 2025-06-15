-- Create a different table to work over that one
CREATE TABLE sales_data2
LIKE sales_data;
INSERT sales_data2
SELECT *
FROM sales_data;
SELECT *
FROM sales_data2;

# 1.Check duplicates
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Transaction_ID, `Date`, Country, Product_ID, Product_Name, Category, Price_per_Unit, Quantity_Purchased, Cost_Price, Discount_Applied, Payment_Method, Customer_Age_Group, Customer_Gender, Store_Location, Sales_Rep) AS row_num
FROM sales_data2
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

# 2.Check the spelling
SELECT DISTINCT(Country)
FROM sales_data2
ORDER BY 1;
SELECT DISTINCT(Category)
FROM sales_data2
ORDER BY 1;
SELECT DISTINCT(Payment_Method)
FROM sales_data2
ORDER BY 1;
SELECT DISTINCT(Customer_Age_Group)
FROM sales_data2
ORDER BY 1;
SELECT DISTINCT(Customer_Gender)
FROM sales_data2
ORDER BY 1;
SELECT DISTINCT(Store_Location)
FROM sales_data2
ORDER BY 1;

# 3.Check null or empty values
# First, to make it easier, we concat all the column names with IS NULL and = '' and copy those cells in the WHERE from the next statement
SELECT 
  GROUP_CONCAT(CONCAT(column_name, ' IS NULL') SEPARATOR ' OR ')
FROM information_schema.columns
WHERE table_name = 'sales_data2';
SELECT 
  GROUP_CONCAT(CONCAT(column_name, "= '' ") SEPARATOR ' OR ')
FROM information_schema.columns
WHERE table_name = 'sales_data2';

SELECT * 
FROM sales_data2
WHERE Transaction_ID IS NULL OR `Date` IS NULL OR Country IS NULL OR Product_ID IS NULL OR Product_Name IS NULL OR Category IS NULL OR Price_per_Unit IS NULL OR Quantity_Purchased IS NULL OR Cost_Price IS NULL OR Discount_Applied IS NULL OR Payment_Method IS NULL OR Customer_Age_Group IS NULL OR Customer_Gender IS NULL OR Store_Location IS NULL OR Sales_Rep IS NULL
OR Transaction_ID= '' OR Country= ''  OR Product_ID= ''  OR Product_Name= ''  OR Category= ''  OR Price_per_Unit= ''  OR Quantity_Purchased= ''  OR Cost_Price= ''  OR Discount_Applied= ''  OR Payment_Method= ''  OR Customer_Age_Group= ''  OR Customer_Gender= ''  OR Store_Location= ''  OR Sales_Rep= '' ;