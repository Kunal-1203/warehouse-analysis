# warehouse-analysis
SQL analysis of 9,999 warehouse orders across 6 US fulfillment centers using Google BigQuery
# Warehouse Operations Analysis — BigQuery SQL Project

## About
End-to-end SQL analysis of 9,999 warehouse orders across 6 fulfillment 
centers in the US (Michigan, Kentucky, Tennessee) using Google BigQuery.

## Tools Used
- Google BigQuery (SQL)
- Microsoft Excel (charts & visualization)

## Dataset
- Table 1: orders (order_id, customer_id, warehouse_id, order_date, shipper_date)
- Table 2: warehouse (warehouse_id, warehouse_alias, maximum_capacity, employee_total, state)
- Total records: 9,999 orders | 6,065 unique customers | 6 warehouses | Year: 2019

## SQL Concepts Used
- JOIN (across two tables using warehouse_id)
- GROUP BY, ORDER BY, HAVING
- Aggregate functions: COUNT, AVG, MIN, MAX
- DATE_DIFF for shipping time calculation
- Subqueries
- CASE WHEN for bucketing
- FORMAT_DATE for time series analysis
- Capacity utilization as a calculated metric

## Key Findings
1. Lansing Fulfillment Center (MI) handled the most orders (3,178) 
   and is operating at 1,096% capacity — critically overloaded
2. Knoxville Fulfillment Center (TN) is the most underutilized 
   at 159% with only 343 orders despite 215 unit capacity
3. All warehouses maintain a consistent 3-day shipping time 
   regardless of order volume — strong operational consistency
4. Michigan warehouses (Ann Arbor + Lansing) together handle 
   62% of all orders (6,205 out of 9,999)
5. Frankfort Fulfillment Center has only 5 employees handling 
   500 orders — highest orders-per-employee ratio among KY warehouses

## Recommendations
- Redistribute orders from Lansing to Knoxville to balance load
- Hire additional staff at Frankfort given its low headcount
- Investigate why Knoxville is severely underutilized despite 
  similar capacity to other centers

## Files
- warehouse_analysis.sql — all 10 BigQuery queries
- charts/ — Excel visualizations (orders by warehouse, 
  monthly trend, regional analysis, shipping performance)

## How to Run
1. Open Google BigQuery
2. Create dataset named warehouse_orders
3. Import orders and warehouse CSV files
4. Run queries from warehouse_analysis.sql
