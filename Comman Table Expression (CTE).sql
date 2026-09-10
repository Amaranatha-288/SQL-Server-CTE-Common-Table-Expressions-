-- COMMAN TABLE EXPRESSION (CTE)
-- Non Recursive CTE
-- Standalone CTE
-- Step1: Find the total Sales Per Customer
WITH CTE_Total_Sales AS
(
   SELECT
     CustomerID,
     SUM(Sales) AS TotalSales
   FROM Sales.Orders
   GROUP BY CustomerID
 )
 --Multiple Standalone CTE
-- Step2: Find the last order date for each customer 

,CTE_Last_Order AS
(
  SELECT
     CustomerID,
     MAX(OrderDate) AS Last_Order
     FROM Sales.Orders
     GROUP BY customerID
)

-- Nested CTE
-- Step3: Rank Customers based on Total Sales Per Customer
, CTE_Customer_Rank AS
(
  SELECT
  CustomerID,
  TotalSales,
  RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
  FROM CTE_Total_Sales
)
-- Step4: segment customer based on their total sales
,CTE_Customer_Segment AS
(
 SELECT
 CustomerID,
 CASE WHEN TotalSales > 100 THEN 'High'
      WHEN TotalSales > 50 THEN 'Medium'
      ELSE 'Low'
END CustomerSegments
FROM CTE_Total_Sales
)

-- Main Query
SELECT
c.CustomerID,
C.FirstName,
c.LastName,
cts.TotalSales,
clo.Last_Order,
ccr.CustomerRank,
ccs.CustomerSegments
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
ON clo.CustomerID = c.CustomerID 
LEFT JOIN CTE_Customer_Rank ccr
ON ccr.CustomerID = c.CustomerID 
LEFT JOIN CTE_Customer_Segment ccs
ON ccs.CustomerID = c.CustomerID 



-- Recursive CTE
-- Generate a sequence of Numbers from 1 to 20
WITH Series AS(
     -- Anchor Query
     SELECT
     1 AS MyNumber
     UNION ALL
     -- Recursive Query
     SELECT
     MyNumber + 1
     FROM Series
     WHERE MyNumber < 20
)
-- Main Query
SELECT *
FROM Series
--OPTION (MAXRECURSION 5000) 

-- Task: Show the employee hierarchy by displaying each employee's level within organix=zation 
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
 INNER JOIN CTE_Emp_Hierarchy ceh
 ON e.ManagerID = ceh.EmployeeID
)
-- Main Query
SELECT
*
FROM CTE_Emp_Hierarchy








