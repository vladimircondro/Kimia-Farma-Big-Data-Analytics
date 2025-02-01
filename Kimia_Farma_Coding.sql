CREATE TABLE kimia_farma.kf_analisa AS
SELECT
    kf_final_transaction.transaction_id,
    kf_final_transaction.date,
    kf_final_transaction.branch_id,
    kf_kantor_cabang.branch_name,
    kf_kantor_cabang.kota,
    kf_kantor_cabang.provinsi,
    kf_kantor_cabang.rating AS rating_cabang,
    kf_final_transaction.customer_name,
    kf_final_transaction.product_id,
    kf_product.product_name,
    kf_final_transaction.price AS actual_price,
    kf_final_transaction.discount_percentage,
    CASE
        WHEN kf_final_transaction.price <= 50000 THEN 0.1
        WHEN kf_final_transaction.price > 50000 AND kf_final_transaction.price <= 100000 THEN 0.15
        WHEN kf_final_transaction.price > 100000 AND kf_final_transaction.price <= 300000 THEN 0.2
        WHEN kf_final_transaction.price > 300000 AND kf_final_transaction.price <= 500000 THEN 0.25
        ELSE 0.3
    END AS persentase_gross_laba,
    kf_final_transaction.price * (
      1 - kf_final_transaction.discount_percentage
    ) AS nett_sales,
    kf_final_transaction.price * (
      1 - kf_final_transaction.discount_percentage
    ) * (
      CASE
          WHEN kf_final_transaction.price <= 50000 THEN 0.1
          WHEN kf_final_transaction.price > 50000 AND kf_final_transaction.price <= 100000 THEN 0.15
          WHEN kf_final_transaction.price > 100000 AND kf_final_transaction.price <= 300000 THEN 0.2
          WHEN kf_final_transaction.price > 300000 AND kf_final_transaction.price <= 500000 THEN 0.25
          ELSE 0.3
      END
    ) AS nett_profit,
    kf_final_transaction.rating AS rating_transaksi
  FROM
    `rakamin-123`.`kimia_farma`.`kf_final_transaction` AS kf_final_transaction
    INNER JOIN `rakamin-123`.`kimia_farma`.`kf_product` AS kf_product ON kf_final_transaction.product_id = kf_product.product_id
    INNER JOIN `rakamin-123`.`kimia_farma`.`kf_kantor_cabang` AS kf_kantor_cabang ON kf_final_transaction.branch_id = kf_kantor_cabang.branch_id;

