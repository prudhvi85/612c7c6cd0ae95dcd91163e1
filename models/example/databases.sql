{{ config(
            materialized='table',
                post_hook={
                    "sql": "CREATE OR REPLACE TABLE maplemonk.public.Customer_Master AS select fi.customer_id,concat(c.first_name,' ',c.last_name) name,c.email,c.phone,fi.source ,datediff(day,min(order_timestamp),current_date) days_since_first_purchase ,sum(sales) total_spend ,count(distinct order_id) total_orders ,count(distinct item_id) total_items ,max(case when fi.order_timestamp=fi1.max_order_date then order_id end) last_order_id ,datediff(day,max(order_timestamp),current_date) days_since_last_purchase ,case when count(distinct order_id)=0 then null else datediff(day,max(order_timestamp),min(order_timestamp))/count(distinct order_id) end Avg_days_between_purchases ,sum(fi.discount) discount ,case when sum(fi.sales)=0 then null else sum(fi.discount)/sum(fi.sales) end discount_percent from maplemonk.public.FACT_ITEMS fi left join maplemonk.PUBLIC.shopifyindia_customers c on fi.customer_id = c.id and fi.source='Shopify' left join (select customer_id,max(order_timestamp) max_order_date from maplemonk.public.FACT_ITEMS where source='Shopify' group by customer_id)fi1 on fi.customer_id=fi1.customer_id where fi.customer_id is not null and order_timestamp is not null and source='Shopify' group by fi.customer_id,concat(c.first_name,' ',c.last_name),c.email,c.phone,fi.source",
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
            