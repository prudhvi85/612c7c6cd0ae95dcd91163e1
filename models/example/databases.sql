{{ config(
            materialized='table',
                post_hook={
                    "sql": "CREATE OR REPLACE TABLE anveshan_db.public.FACT_ITEMS AS SELECT Cast(o.id AS VARCHAR(16777216)) AS order_id, o.CUSTOMER:id::int customer_id, ol1.id AS item_id, cast(ol1.sku AS varchar(16777216)) product_id, CASE WHEN p.title IS NULL THEN 'NA' ELSE p.title END AS product_name, CASE WHEN cd.city IS NULL OR cd.city = '' THEN 'NA' ELSE cd.city END AS city, CASE WHEN cd.province IS NULL OR cd.province = '' THEN 'NA' ELSE cd.province END AS state, CASE WHEN p.product_type = '' THEN 'NA' ELSE p.product_type END AS category, CASE WHEN o.cancelled_at IS NOT NULL THEN 'CANCELLED' ELSE CASE WHEN orl.line_item_id IS NOT NULL THEN 'RETURNED' ELSE 'Shopify_Processed' END END AS order_status, cast(o.created_at AS datetime) order_timestamp, sum(ol1.price * ol1.quantity) AS sales, sum(o.total_tax) / sum(ol2.items) AS tax, sum(o.total_discounts) / sum(ol2.items) AS discount, sum(ol1.quantity) quantity, 'Shopify' AS source FROM anveshan_db.PUBLIC.orders o LEFT JOIN anveshan_db.PUBLIC.orders_line_items ol1 ON o._airbyte_orders_hashid = ol1._airbyte_orders_hashid LEFT JOIN ( SELECT _airbyte_orders_hashid, count(1) AS items FROM anveshan_db.PUBLIC.orders_line_items GROUP BY _airbyte_orders_hashid) ol2 ON o._airbyte_orders_hashid = ol2._airbyte_orders_hashid LEFT JOIN anveshan_db.PUBLIC.orders_refunds_refund_line_items orl ON ol1.id = orl.line_item_id LEFT JOIN anveshan_db.PUBLIC.products p ON ol1.product_id = p.id LEFT JOIN ( SELECT customer_id, city, province, row_number() OVER ( partition BY customer_id ORDER BY id DESC) rowid FROM anveshan_db.PUBLIC.customers_addresses) AS cd ON o.CUSTOMER:id::int = cd.customer_id AND cd.rowid = 1 GROUP BY cast(o.id AS varchar(16777216)), o.CUSTOMER:id::int, ol1.id, cast(ol1.sku AS varchar(16777216)), CASE WHEN p.title IS NULL THEN 'NA' ELSE p.title END, CASE WHEN cd.city IS NULL OR cd.city = '' THEN 'NA' ELSE cd.city END, CASE WHEN cd.province IS NULL OR cd.province = '' THEN 'NA' ELSE cd.province END, CASE WHEN p.product_type = '' THEN 'NA' ELSE p.product_type END, CASE WHEN o.cancelled_at IS NOT NULL THEN 'CANCELLED' ELSE CASE WHEN orl.line_item_id IS NOT NULL THEN 'RETURNED' ELSE 'Shopify_Processed' END END, cast(o.created_at AS datetime) UNION SELECT co.id order_id, co.customer_id, coi.id item_id, coi.product_sku_id AS product_id, CASE WHEN ca.NAME IS NULL THEN 'NA' ELSE ca.NAME END AS product_name, cc.city, cc.address_state AS state, 'NA' AS category, co.order_status AS order_status, cast(co.order_date_time AS datetime) AS order_timestamp, sum(coi.price_without_tax * coi.quantity) sales, NULL AS tax, sum(coi.discount) discount, sum(coi.quantity) quantity, co.channel AS source FROM anveshan_db.PUBLIC.core_order co INNER JOIN anveshan_db.PUBLIC.core_orderitems coi ON co.id = coi.order_id LEFT JOIN anveshan_db.PUBLIC.core_customer cc ON co.customer_id = cc.id LEFT JOIN anveshan_db.PUBLIC.core_anveshanproductsku ca ON coi.product_sku_id = ca.sku_code WHERE co.channel <> 'SHOPIFY' GROUP BY co.id, co.customer_id, coi.id, coi.product_sku_id, CASE WHEN ca.NAME IS NULL THEN 'NA' ELSE ca.NAME END, cc.city, cc.address_state, co.order_status, cast(co.order_date_time AS datetime), co.channel ; UPDATE anveshan_db.PUBLIC.fact_items AS A SET A.city=case when B.MappedCity is null then INITCAP(A.city) else INITCAP(B.MappedCity) end FROM anveshan_db.public.cities_mapping B WHERE UPPER(A.city)=UPPER(B.city); ALTER TABLE anveshan_db.PUBLIC.fact_items ADD COLUMN customer_flag varchar(50); ALTER TABLE anveshan_db.PUBLIC.fact_items ADD COLUMN new_customer_flag varchar(50); ALTER TABLE anveshan_db.PUBLIC.fact_items ADD COLUMN acquisition_channel varchar(16777216); ALTER TABLE anveshan_db.PUBLIC.fact_items ADD COLUMN acquisition_product varchar(16777216); UPDATE anveshan_db.PUBLIC.fact_items AS A SET A.customer_flag = B.flag FROM ( SELECT DISTINCT order_id, customer_id, order_timestamp, CASE WHEN order_timestamp <> Min(order_timestamp) OVER ( partition BY customer_id) THEN 'Repeated' ELSE 'New' END AS Flag FROM anveshan_db.PUBLIC.fact_items)AS B WHERE A.order_id = B.order_id AND A.customer_id = B.customer_id; UPDATE anveshan_db.PUBLIC.fact_items SET customer_flag = CASE WHEN customer_flag IS NULL THEN 'New' ELSE customer_flag END; UPDATE anveshan_db.PUBLIC.fact_items AS A SET A.new_customer_flag = B.flag FROM ( SELECT DISTINCT order_id, customer_id, order_timestamp, CASE WHEN Last_day(order_timestamp, 'month') <> Last_day(Min(order_timestamp) OVER ( partition BY customer_id)) THEN 'Repeated' ELSE 'New' END AS Flag FROM anveshan_db.PUBLIC.fact_items)AS B WHERE A.order_id = B.order_id AND A.customer_id = B.customer_id; UPDATE anveshan_db.PUBLIC.fact_items SET new_customer_flag = CASE WHEN new_customer_flag IS NULL THEN 'New' ELSE new_customer_flag END; CREATE OR replace temporary TABLE anveshan_db.PUBLIC.temp_source AS SELECT DISTINCT customer_id, source FROM ( SELECT DISTINCT customer_id, order_timestamp, source, Min(order_timestamp) OVER ( partition BY customer_id) firstOrderdate FROM anveshan_db.PUBLIC.fact_items)res WHERE order_timestamp=firstorderdate; UPDATE anveshan_db.PUBLIC.fact_items AS a SET a.acquisition_channel=b.source FROM anveshan_db.PUBLIC.temp_source b WHERE a.customer_id = b.customer_id; CREATE OR replace temporary TABLE anveshan_db.PUBLIC.temp_product AS SELECT DISTINCT customer_id, product_name, Row_number() OVER (partition BY customer_id ORDER BY sales DESC) rowid FROM ( SELECT DISTINCT customer_id, order_timestamp, product_name, sales , Min(order_timestamp) OVER (partition BY customer_id) firstOrderdate FROM anveshan_db.PUBLIC.fact_items )res WHERE order_timestamp=firstorderdate; UPDATE anveshan_db.PUBLIC.fact_items AS A SET A.acquisition_product=B.product_name FROM ( SELECT * FROM anveshan_db.PUBLIC.temp_product WHERE rowid=1)B WHERE A.customer_id = B.customer_id;",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from MapleMonk.information_schema.databases
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            