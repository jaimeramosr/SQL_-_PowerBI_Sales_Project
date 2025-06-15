# Check the import
SELECT *
FROM sales_canada;

# Combine all tables
CREATE TABLE world_layoffs.sales_data as
SELECT * FROM sales_canada
UNION ALL
SELECT * FROM sales_china
UNION ALL
SELECT * FROM sales_india
UNION ALL
SELECT * FROM sales_nigeria
UNION ALL
SELECT * FROM sales_uk
UNION ALL
SELECT * FROM sales_us;

# Check the union
SELECT *
FROM sales_data;