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

### Query
A new table was created using a left outer join to combine `kf_final_transaction`, `kf_kantor_cabang` and `kf_product`. Using subquery to combine and calculate `nett_profit`, `nett_sales` and also determinine the amount of `discount_precentage`.


## Dashboard
The aggregated data is visualized in a dashboard, showcasing:
- Sales performance trends over the years.
- Branch-wise comparisons.
- Key performance indicators (KPIs) such as gross profit and customer ratings.

![Alt text](/image/dashboard.png)

This is link for the dashboard [view dashboard](https://lookerstudio.google.com/s/nlZRwfy1oes)<br>

## Key Insight 
✅ Sales & Transactions Overview:
- Total net sales: 321.2B
- Total transactions: 672,458
- Total net profit: 72.6B
✅ Top Performing Provinces:
Jawa Barat leads in both total transactions and net sales
✅ Low-Performing Branches:
Some branches have high ratings but low transaction volumes, indicating strong customer satisfaction but weak traffic.
✅ Trends & Seasonality:
Revenue by quarter indicates steady growth from 2020 to 2023, with spikes in specific quarters.

## How to Use
1. Clone the repository.
2. Review the SQL scripts provided in the `/queries` directory.
3. Use the aggregated tables as input for the dashboard tool of your choice (e.g., Tableau, Power BI).

## Acknowledgments
This project was developed as part of the Kimia Farma x Rakamin Project-Based Internship Program. Special thanks to the mentors and peers for their guidance and support.