# KF_BranchAnalytics
This is a final project for Kimia Farma x Rakamin Project Based Intern. In this project, we evaluate performance sales from Kimia Farma in the periode 2020 - 2023. We made a dashboard to analyst the performance sales. 

## Data Set

In this data set, we given four data sets 
* kf_final_transaction
 this table consists of details columns of each transactions such as transaction_id, product_id, branch_id, customer_name, date, price, discount_persentage, rating.
* kf_inventory 
this table consists of inventory details such as inventory_id, branch_id, product_id, product_name, opname_stock.
* kf_kantor_cabang
this table consists of branch details such as branch_id, branch_category, branch_name, kota, provinsi, rating.

* kf_product
this table consists of product details such as product_id, product_name, product_category, price

To make agregate table not too large and running time, I break into a few parts of query. The first query, I make a new table using left outer join to agregate kf_final_transaction and kf_kantor_cabang

```
CREATE TABLE `third-wharf-444813-i5.Kf_data.kf_agg_table` AS 
SELECT kf_final_transaction.transaction_id, kf_final_transaction.date, kf_final_transaction.branch_id, kf_kantor_cabang.branch_name, kf_kantor_cabang.kota, kf_kantor_cabang.provinsi, kf_kantor_cabang.rating AS rating_cabang, kf_final_transaction.customer_name 
FROM `third-wharf-444813-i5`.`Kf_data`.`kf_final_transaction` AS kf_final_transaction 
LEFT OUTER JOIN `third-wharf-444813-i5`.`Kf_data`.`kf_kantor_cabang` AS kf_kantor_cabang ON kf_final_transaction.branch_id = kf_kantor_cabang.branch_id;
```
## New Agregate Table 
The second part of the query, I use query in file **final query agregate.sql**. 
in this file sql, I made cte to calculate the discounted price to decide the gross laba percentage. 