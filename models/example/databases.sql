{{ config(
            materialized='table',
                post_hook={
                    "sql": "CREATE OR REPLACE TABLE EGGOZ.EGGOZDB.BEAT_SALES_DETAILS AS select O.id AS OrderID,O.name AS OrderName, Ol1.id OrderLineID,CONCAT(pp.name,' ',pp.description) Product ,cast(O.date as date) AS OrderDate ,cast(O.delivery_date as date) AS DeliveryDate ,O.status OrderStatus ,cast(db.beat_date as date) as BeatDate ,db.beat_name ,sum(ss.product_quantity) demanded_qty ,sum(ss.product_supply_quantity) supplied_qty ,sum(ss.product_out_quantity) out_qty ,sum(ss.product_sold_quantity) sold_qty ,sum(ss.product_return_quantity) return_qty ,sum(product_replacement_quantity) replacement_qty ,SUM(Ol1.single_sku_rate *Ol1.quantity ) Sales ,SUM(IFNULL(Orl.returns,0)) ReturnSales ,SUM(IFNULL(Orl.replacement,0)) ReplacementSales ,SUM(IFNULL(Orl.return_quantity,0)) ReturnQuantity ,SUM(IFNULL(Orl.replacement_quantity,0)) ReplacementQuantity ,SUM(Ol1.quantity) Quantity ,SUM(O.discount_amount)/SUM(Ol2.Items) Discount from EGGOZ.EGGOZDB.MYSQL_ORDER_ORDER O inner join EGGOZ.EGGOZDB.MYSQL_ORDER_ORDERLINE Ol1 ON O.id=Ol1.order_id left join EGGOZ.EGGOZDB.MYSQL_PRODUCT_PRODUCT pp ON Ol1.product_id =pp.id left join ( select orderLine_id,SUM(returns) returns,SUM(replacement) replacement ,SUM(return_quantity) return_quantity,SUM(replacement_quantity) replacement_quantity from ( select orderLine_id ,case when line_type='Return' then amount else 0 end as returns ,case when line_type='Replacement' then amount else 0 end as replacement ,case when line_type='Return' then quantity else 0 end as return_quantity ,case when line_type='Replacement' then quantity else 0 end as replacement_quantity from EGGOZ.EGGOZDB.MYSQL_ORDER_ORDERRETURNLINE where line_type IN ('Return' ,'Replacement') )temp group by orderLine_id ) Orl ON Ol1.id =Orl.orderLine_id left join EGGOZ.EGGOZDB.MYSQL_SALESCHAIN_SALESDEMANDSKU ss ON O.beat_assignment_id = ss.beatAssignment_id AND Ol1.product_id =ss.product_id left join EGGOZ.EGGOZDB.MYSQL_DISTRIBUTIONCHAIN_BEATASSIGNMENT db on ss.beatAssignment_id = db.id left join (select order_id, COUNT(1) AS Items from EGGOZ.EGGOZDB.MYSQL_ORDER_ORDERLINE group by order_id) Ol2 ON O.id=Ol2.order_id WHERE O.status <> 'cancelled' group by O.id,O.name, Ol1.id,CONCAT(pp.name,' ',pp.description) ,O.date,O.delivery_date,O.status ,db.beat_date ,db.beat_name",
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
            