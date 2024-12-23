-- 1. I want to add columns from kf_product to kf_agg_table, the columns are product_id, product_name, price as actual_price
-- 2. I mean, I want to add that columns in kf_agg_table
WITH disc_price AS (
  SELECT 
    transaction_id,
    price,
    discount_percentage,
    price * (1 - discount_percentage) AS disc_price,
    CASE 
      WHEN price * (1 - discount_percentage) <= 50000 THEN 0.10
      WHEN price * (1 - discount_percentage) > 50000 AND price * (1 - discount_percentage) <= 100000 THEN 0.15
      WHEN price * (1 - discount_percentage) > 100000 AND price * (1 - discount_percentage) <= 300000 THEN 0.20
      WHEN price * (1 - discount_percentage) > 300000 AND price * (1 - discount_percentage) <= 500000 THEN 0.25
      WHEN price * (1 - discount_percentage) > 500000 THEN 0.30
      ELSE 0
    END AS persentase_gross_laba
  FROM 
    `third-wharf-444813-i5.Kf_data.kf_final_transaction`
)

SELECT
  kf_agg_table.transaction_id,
  kf_agg_table.date,
  kf_agg_table.branch_id,
  kf_agg_table.branch_name,
  kf_agg_table.kota,
  kf_agg_table.provinsi,
  kf_agg_table.rating_cabang,
  kf_agg_table.customer_name,
  kf_product.product_id,
  kf_product.product_name,
  kf_product.price AS actual_price,
  kf_final_transaction.discount_percentage,
  disc_price.persentase_gross_laba,

  -- Calculate nett sales
  (kf_product.price * (1 - kf_final_transaction.discount_percentage)) + 
  (kf_product.price * disc_price.persentase_gross_laba) AS nett_sales, -- Corrected formula

  -- Calculate nett profit
  ((kf_product.price * (1 - kf_final_transaction.discount_percentage)) + 
  (kf_product.price * disc_price.persentase_gross_laba)) - kf_product.price AS nett_profit, -- Adjusted based on nett_sales

  kf_final_transaction.rating AS rating_transaksi,
  EXTRACT(YEAR FROM kf_agg_table.date) AS year
FROM
  `third-wharf-444813-i5.Kf_data.kf_agg_table` AS kf_agg_table
INNER JOIN 
  `third-wharf-444813-i5.Kf_data.kf_final_transaction` AS kf_final_transaction 
ON 
  kf_agg_table.transaction_id = kf_final_transaction.transaction_id
INNER JOIN 
  `third-wharf-444813-i5.Kf_data.kf_product` AS kf_product 
ON 
  kf_final_transaction.product_id = kf_product.product_id
INNER JOIN 
  disc_price
ON 
  kf_final_transaction.transaction_id = disc_price.transaction_id;
