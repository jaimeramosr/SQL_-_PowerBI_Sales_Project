# SQL & PowerBi Project.

<h1>📊 Executive Sales Dashboard with SQL & Power BI </h1>
<p>
	This project focuses on preparing, cleaning, and analyzing sales data using SQL and building a real-time, executive-oriented dashboard using Microsoft Power BI. Key business insights are also highlighted.
    <p align="center">
  <img src="Images/Sales_Dashboard.png" alt="Sales Dashboard" width="700">
</p>

---
<h2>🛠️ Data preparation with SQL</h2>
<i>1. Importing data </i> <br>
The original dataset was reviewed in Excel to understand its structure, identify irrelevant columns, and check for data types.
<p>
The data was then imported into **MySQL**, ensuring the correct formats were applied—especially for dates (e.g., `%m/%d/%Y`).
</p>
<p align="center">
<img src="Images/Import_window.png" alt="SQL Import Window" width="250">
</p>

<i>2. Data Cleaning</i> <br>

All cleaning steps were performed using SQL. The full script is available in the project files.

**Steps included:**

1. **Removing duplicates**
- No duplicates were found. If needed:
```sql
DELETE FROM sales_data2_copy WHERE row_num > 1;
```
2. **Standardizing data**
- No spelling issues, extra spaces, symbols, etc. If any, we could proceed as follows:
- Spaces before words:
```sql
SET Country = TRIM(Country);
```
- Similar words:
```sql
SET Country = ‘Canada' WHERE Country LIKE ‘Canad';
```
- Symbols or dots at the end:
```sql
TRIM(TRAILING '.' FROM Country) WHERE Country LIKE 'Canada%';
```
3. **Handling Null or missing values**
- No null values were found in the dataset. If any had been present, they would have been addressed using context-appropriate methods such as imputation or row removal. For example, missing product prices could be filled using the average price of the same item in the same store, or across other stores. Similarly, missing categories could be inferred based on similar products.
4. **Removing rellevant Columns/Rows**
- Example:
```sql
ALTER TABLE sales_data2 DROP COLUMN row_num;
DELETE FROM sales_data2 WHERE product IS NULL;
```
<i>3. Analyzing data </i> <br>
Before moving to Power BI, we ran exploratory analysis via SQL. The script calculates key metrics like **Total Revenue** and **Profit**:
```sql
ALTER TABLE sales_data2 ADD COLUMN Total_Revenue DOUBLE;
UPDATE sales_data2 SET Total_Revenue = (Price_Per_Unit * Quantity_Purchased) - Discount_Applied;

ALTER TABLE sales_data2 ADD COLUMN Profit DOUBLE;
UPDATE sales_data2 SET Profit = Total_Revenue - (Cost_Price * Quantity_Purchased);
```
As seen in the script, The analysis focuses on 4 aspects:
- Total revenue & profit by country.
- Top 5 best-selling products.
- Top 5 representatives.
- Best-performing store locations from the last stored week.
<img src="Images/SQL_Analysis_Results.png" alt="SQL Analysis Results" width="700">

---
<h2>📈 Power BI Dashboard Development</h2>
<i>1. Importing Cleaned Data </i> <br>
<p>
Cleaned data was imported into Power BI as .csv or directly from the MySQL database. 
</p>
<i>2. data Transformation with DAX </i> <br>
<p>
New measures created:<strong>Total Revenue, Total Profit, Total Discounts Given, and Average Order Revenue</strong>.
</p>
<p>
Additional columns: <strong>Month Name, Month Number, Day Name, Day Number</strong> — useful for chronological charts and trend lines.
</p>
<i>3. Dashboard Design </i> <br>
Design principles:

- Focused on executive-level KPIs.
- Key metrics displayed using value cards: Total Revenue, Total Profit, Total Orders, etc.

Visuals include:

- Bar charts (e.g., daily revenue, revenue by category)
- Line charts (e.g., monthly trends)	
- Map charts and scatter plots
- Filters for dynamic analysis (e.g., by country or store)
<p align="center">
<img src="Images/Sales_Dashboard.png" alt="Sales Dashboard" width="700">
</p>

---
<h2>✅ Key Insights from the Sales Dashboard</h2>

- December stands out as the month with highest revenue (~0.52M) — likely influenced by seasonal/holiday shopping patterns.
- Tuesdays and Fridays underperform compared to other days — ideal for scheduling non-sales activities like inventory audits or staff training.
- Discounts correlate with profit — suggesting discounts may be used strategically rather than harming margins.
- Payment method usage is balanced — Cash, Credit Card, and Mobile Payments each contribute ~33%, indicating no dominant preference across users.
- Top revenue categories are Home & Kitchen, Clothing, and Electronics — potential areas for promotion and cross-selling.
- Geographic revenue differences are significant — London, Birmingham, New York and Montreal generate higher profits and/or discounts.
- Nigeria, India, and China show cluster patterns with lower discounts but decent profits — possible candidates for margin optimization.

Further insights can be uncovered using Power BI filters to segment by country, store, or product category.