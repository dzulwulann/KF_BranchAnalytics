# KF_BranchAnalytics
This repository contains the final project for the Kimia Farma x Rakamin Project-Based Internship. The project involves evaluating sales performance for Kimia Farma branches from 2020 to 2023. A dashboard was created to analyze the sales performance.

## Project Overview
The main objective of this project is to analyze sales data, identify trends, and provide actionable insights using a dashboard. The analysis includes:
- Aggregating sales transaction data.
- Integrating inventory and branch information.
- Calculating performance metrics such as gross profit percentage.

## Data Sets
The project utilizes the following four datasets:

1. **kf_final_transaction**
   - Contains detailed information about transactions.
   - Key columns: `transaction_id`, `product_id`, `branch_id`, `customer_name`, `date`, `price`, `discount_percentage`, `rating`.

2. **kf_inventory**
   - Includes inventory details.
   - Key columns: `inventory_id`, `branch_id`, `product_id`, `product_name`, `opname_stock`.

3. **kf_kantor_cabang**
   - Provides branch details.
   - Key columns: `branch_id`, `branch_category`, `branch_name`, `kota`, `provinsi`, `rating`.

4. **kf_product**
   - Contains product details.
   - Key columns: `product_id`, `product_name`, `product_category`, `price`.

## Aggregating Data
To streamline the analysis and reduce query execution time, the data was aggregated in stages. Below are the steps:

### Step 1: Initial Aggregation
A new table was created using a left outer join to combine `kf_final_transaction` with `kf_kantor_cabang`. This step enriched the transaction data with branch details.

```sql
CREATE TABLE `third-wharf-444813-i5.Kf_data.kf_agg_table` AS 
SELECT 
  kf_final_transaction.transaction_id, 
  kf_final_transaction.date, 
  kf_final_transaction.branch_id, 
  kf_kantor_cabang.branch_name, 
  kf_kantor_cabang.kota, 
  kf_kantor_cabang.provinsi, 
  kf_kantor_cabang.rating AS rating_cabang, 
  kf_final_transaction.customer_name 
FROM `third-wharf-444813-i5`.`Kf_data`.`kf_final_transaction` AS kf_final_transaction 
LEFT OUTER JOIN `third-wharf-444813-i5`.`Kf_data`.`kf_kantor_cabang` AS kf_kantor_cabang 
ON kf_final_transaction.branch_id = kf_kantor_cabang.branch_id;
```

### Step 2: Final Aggregation
Further aggregation was performed using SQL queries stored in the file **`final_query_aggregate.sql`**. This step involved:
- Creating a Common Table Expression (CTE) to calculate discounted prices.
- Determining the gross profit percentage.

## Dashboard
The aggregated data is visualized in a dashboard, showcasing:
- Sales performance trends over the years.
- Branch-wise comparisons.
- Key performance indicators (KPIs) such as gross profit and customer ratings.

## How to Use
1. Clone the repository.
2. Review the SQL scripts provided in the `/queries` directory.
3. Use the aggregated tables as input for the dashboard tool of your choice (e.g., Tableau, Power BI).

## Acknowledgments
This project was developed as part of the Kimia Farma x Rakamin Project-Based Internship Program. Special thanks to the mentors and peers for their guidance and support.
