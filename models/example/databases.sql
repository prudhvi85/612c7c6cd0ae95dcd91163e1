{{ config(
            materialized='table',
                post_hook={
                    "sql": "CREATE OR REPLACE TABLE rawdata.eggozdb.sales_summary AS select O.id AS OrderID, Ol1.id ItemID, Concat(pp.name, ' ',pp.description) Product ,O.date,O.delivery_date, O.status OrderStatus ,bc.city_name City ,bc2.cluster_name Cluster ,SUM(Ol1.single_sku_rate *Ol1.quantity ) Sales ,SUM(Ol1.single_sku_rate *IFNULL(Orl.return_quantity,0)) ReturnSales ,SUM(Ol1.single_sku_rate *IFNULL(Orl.replacement_quantity,0)) ReplacementSales ,SUM(Ol1.quantity) Quantity ,SUM(O.discount_amount) Discount ,return_quantity ,replacement_quantity from RAWDATA.EGGOZDB.ORDER_ORDER O inner join RAWDATA.EGGOZDB.ORDER_ORDERLINE Ol1 ON O.id=Ol1.order_id left join RAWDATA.EGGOZDB.MYSQL_PRODUCT_PRODUCT_PRODUCT pp ON Ol1.product_id =pp.id left join RAWDATA.EGGOZDB.MYSQL_RETAILER_RETAILER_RETAILER rr ON O.retailer_id =rr.retailer_id left join RAWDATA.EGGOZDB.MYSQL_BASE_CITY bc ON rr.city_id =bc.id left join RAWDATA.EGGOZDB.MYSQL_BASE_CLUSTER bc2 ON rr.cluster_id =bc2.id left join ( select orderLine_id,SUM(returns) return_quantity,SUM(replacement) replacement_quantity from ( select orderLine_id ,case when line_type='Return' then quantity else 0 end as returns ,case when line_type='Replacement' then quantity else 0 end as replacement from RAWDATA.EGGOZDB.ORDER_ORDERRETURNLINE where line_type IN ('Return' ,'Replacement') )temp group by orderLine_id ) Orl ON Ol1.id =Orl.orderLine_id left join (select order_id, COUNT(1) AS Items from RAWDATA.EGGOZDB.ORDER_ORDERLINE group by order_id) Ol2 ON O.id=Ol2.order_id WHERE O.status = 'completed' or O.status = 'delivered' group by O.id,Ol1.id,O.status, CONCAT(pp.name,' ',pp.description), O.date, O.delivery_date, bc.city_name, bc2.cluster_name",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from RAWDATA.information_schema.databases
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            