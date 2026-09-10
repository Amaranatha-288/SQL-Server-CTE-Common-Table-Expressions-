# SQL-Server-CTE-Common-Table-Expressions


## 📌 About the Project

This project contains my hands-on practice with **Common Table Expressions (CTEs) in SQL Server**.

The goal of this practice is to understand how CTEs can be used to break complex SQL queries into smaller, readable, and reusable steps.

I practiced both **Non-Recursive CTEs** and **Recursive CTEs** using customer sales and employee hierarchy examples.

---

## 🛠️ Tools & Technologies

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* T-SQL

---

## 📚 Topics Covered

### 1. Non-Recursive CTE

Used a CTE to calculate the total sales for each customer.

```sql
WITH CTE_Total_Sales AS
(
    SELECT
        CustomerID,
        SUM(Sales) AS TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID
)
```

---

### 2. Multiple CTEs

Created multiple CTEs within a single query to perform different calculations.

The practice includes:

* Total sales per customer
* Last order date
* Customer ranking
* Customer segmentation

---

### 3. Customer Sales Analysis

Calculated the total sales for each customer using `SUM()` and `GROUP BY`.

This result was then reused by other CTEs.

---

### 4. Last Order Date

Used a CTE to find the most recent order date for each customer.

```sql
MAX(OrderDate) AS Last_Order
```

---

### 5. Customer Ranking

Used the `RANK()` window function to rank customers according to their total sales.

```sql
RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
```

This helps identify customers with the highest sales.

---

### 6. Customer Segmentation

Created customer segments based on total sales using a `CASE` expression.

The customers were categorized as:

* **High**
* **Medium**
* **Low**

Example logic:

```sql
CASE
    WHEN TotalSales > 100 THEN 'High'
    WHEN TotalSales > 50 THEN 'Medium'
    ELSE 'Low'
END AS CustomerSegments
```

---

### 7. Combining Multiple CTEs

The different CTE results were combined with the `Sales.Customers` table using `LEFT JOIN`.

The final result contains:

* Customer ID
* First Name
* Last Name
* Total Sales
* Last Order Date
* Customer Rank
* Customer Segment

This creates a detailed customer analysis report.

---

## 🔄 Recursive CTE

I also practiced **Recursive CTEs**, which are useful when a query needs to repeatedly process rows based on a previous result.

A recursive CTE contains:

1. **Anchor Query**
2. **Recursive Query**
3. **Main Query**

---

### 8. Generating a Number Sequence

Created a recursive CTE to generate numbers from **1 to 20**.

```sql
WITH Series AS
(
    SELECT 1 AS MyNumber

    UNION ALL

    SELECT MyNumber + 1
    FROM Series
    WHERE MyNumber < 20
)
SELECT *
FROM Series;
```

This demonstrates how recursive CTEs can generate sequential data.

---

### 9. Employee Hierarchy

Created a recursive CTE to display an employee hierarchy.

The query starts with employees who do not have a manager and then recursively finds employees reporting to them.

The hierarchy includes an employee's:

* Employee ID
* First Name
* Manager ID
* Organizational Level

Example:

```sql
WITH CTE_Emp_Hierarchy AS
(
    -- Anchor Query
    SELECT
        EmployeeID,
        FirstName,
        ManagerID,
        1 AS Level
    FROM Sales.Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Recursive Query
    SELECT
        e.EmployeeID,
        e.FirstName,
        e.ManagerID,
        Level + 1
    FROM Sales.Employees AS e
    INNER JOIN CTE_Emp_Hierarchy AS ceh
        ON e.ManagerID = ceh.EmployeeID
)
SELECT *
FROM CTE_Emp_Hierarchy;
```

---

## 💡 Real-World Applications

CTEs are commonly useful for:

* Customer sales analysis
* Customer segmentation
* Ranking and reporting
* Business intelligence
* Data transformation
* Data cleaning workflows
* Hierarchical data analysis
* Employee organizational structures
* Parent-child relationships
* Sequential data generation
* Complex reporting queries
* Data engineering workflows

---

## 🎯 Key Learning

Through this practice, I learned that **CTEs make complex SQL queries easier to understand by dividing them into logical steps**.

I also learned how recursive CTEs can be used to solve problems involving **hierarchical and sequential data**.

This practice strengthened my understanding of **Advanced SQL** and will help me work with more complex data-analysis and data-engineering problems.

---

## 📂 Project Structure

```text
SQL-Server-CTE/
│
├── CTE.sql
└── README.md
```

---

## 🚀 Skills Practiced

* SQL
* T-SQL
* Common Table Expressions
* Non-Recursive CTE
* Recursive CTE
* Multiple CTEs
* Aggregations
* GROUP BY
* CASE Statements
* Window Functions
* RANK()
* JOINs
* Hierarchical Data
* Data Analysis

---

## 👨‍💻 Author

**Amaranatha H**

Aspiring Data Professional | SQL | Python | Data Analytics | ETL

---

⭐ This repository is part of my continuous SQL learning and hands-on practice journey.
