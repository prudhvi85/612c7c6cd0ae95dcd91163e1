{{ config(
            materialized='table',
                post_hook={
                    "sql": "CREATE OR REPLACE TABLE EGGOZ.EGGOZDB.SALES_SUMMARY AS select O.id AS OrderID, Ol1.id ItemID,CONCAT(pp.name,' ',pp.description) Product ,O.date,O.status OrderStatus ,bc.city_name City ,bc2.cluster_name Cluster ,SUM(Ol1.single_sku_rate *Ol1.quantity ) Sales ,SUM(IFNULL(Orl.returns,0)) ReturnSales ,SUM(IFNULL(Orl.replacement,0)) ReplacementSales ,SUM(IFNULL(Orl.return_quantity,0)) ReturnQuantity ,SUM(IFNULL(Orl.replacement_quantity,0)) ReplacementQuantity ,SUM(Ol1.quantity) Quantity ,SUM(O.discount_amount)/SUM(Ol2.Items) Discount from EGGOZ.EGGOZDB.MYSQL_ORDER_ORDER O inner join EGGOZ.EGGOZDB.MYSQL_ORDER_ORDERLINE Ol1 ON O.id=Ol1.order_id left join EGGOZ.EGGOZDB.MYSQL_PRODUCT_PRODUCT pp ON Ol1.product_id =pp.id left join EGGOZ.EGGOZDB.MYSQL_RETAILER_RETAILER rr ON O.retailer_id =rr.retailer_id left join EGGOZ.EGGOZDB.MYSQL_BASE_CITY bc ON rr.city_id =bc.id left join EGGOZ.EGGOZDB.MYSQL_BASE_CLUSTER bc2 ON rr.cluster_id =bc2.id left join ( select orderLine_id,SUM(returns) returns,SUM(replacement) replacement ,SUM(return_quantity) return_quantity,SUM(replacement_quantity) replacement_quantity from ( select orderLine_id ,case when line_type='Return' then amount else 0 end as returns ,case when line_type='Replacement' then amount else 0 end as replacement ,case when line_type='Return' then quantity else 0 end as return_quantity ,case when line_type='Replacement' then quantity else 0 end as replacement_quantity from EGGOZ.EGGOZDB.MYSQL_ORDER_ORDERRETURNLINE where line_type IN ('Return' ,'Replacement') )temp group by orderLine_id ) Orl ON Ol1.id =Orl.orderLine_id left join (select order_id, COUNT(1) AS Items from EGGOZ.EGGOZDB.MYSQL_ORDER_ORDERLINE group by order_id) Ol2 ON O.id=Ol2.order_id WHERE O.status <> 'cancelled' group by O.id,Ol1.id,O.status, CONCAT(pp.name,' ',pp.description), O.date, O.status, bc.city_name, bc2.cluster_name",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from EGGOZ.information_schema.databases
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            