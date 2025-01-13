CREATE TABLE `Kf_data.final_task_dataset` AS 
SELECT 
  x.transaction_id, 
  x.date, 
  x.branch_id, 
  x.branch_name, 
  x.kota, 
  x.provinsi, 
  x.rating_cabang, 
  x.customer_name,
  x.product_id, 
  x.product_name, 
  x.actual_price, 
  x.discount_percentage, 
  x.persentase_gross_laba, 
  (x.actual_price * x.persentase_gross_laba) - (x.actual_price - x.nett_sales) AS nett_profit, 
  x.rating_transaksi
FROM (
  SELECT 
    a.transaction_id, 
    a.date, 
    a.branch_id, 
    b.branch_name, 
    b.kota, 
    b.provinsi, 
    b.rating AS rating_cabang,
    a.customer_name, 
    a.product_id, 
    c.product_name, 
    c.price AS actual_price, 
    a.discount_percentage,
    CASE 
      WHEN c.price <= 50000 THEN 0.10
      WHEN c.price > 50000 AND c.price <= 100000 THEN 0.15
      WHEN c.price > 100000 AND c.price <= 300000 THEN 0.20
      WHEN c.price > 300000 AND c.price <= 500000 THEN 0.25
      WHEN c.price > 500000 THEN 0.30 
    END AS persentase_gross_laba,
    (c.price - (c.price * a.discount_percentage)) AS nett_sales,
    a.rating AS rating_transaksi
  FROM `Kf_data.kf_final_transaction` a
  LEFT JOIN `Kf_data.kf_kantor_cabang` b
    ON a.branch_id = b.branch_id
  LEFT JOIN `Kf_data.kf_product` c
    ON a.product_id = c.product_id
) x;
