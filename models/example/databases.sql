{{ config(
            materialized='table',
                post_hook={
                    "sql": "drop table if exists rawdata.eggozdb.fact_items; create table rawdata.eggozdb.fact_items as select O.id AS OrderID, Ol1.id ItemID, O.status OrderStatus ,SUM(Ol1.single_sku_rate *Ol1.quantity ) Sales ,IFNULL(SUM(Orl.return_sales),0) ReturnSales ,SUM(Ol1.single_sku_rate *Ol1.quantity )-IFNULL(SUM(Orl.return_sales),0) GrossSales ,SUM(Ol1.quantity) Quantity ,SUM(O.discount_amount)/SUM(Ol2.Items) Discount from rawdata.eggozdb.order_order O inner join rawdata.eggozdb.order_orderline Ol1 ON O.id=Ol1.order_id left join ( select orderLine_id,SUM(amount) return_sales from ( select distinct orderLine_id,amount from rawdata.eggozdb.order_orderreturnline where line_type ='Return' )temp group by orderLine_id ) Orl ON Ol1.id =Orl.orderLine_id left join (select order_id, COUNT(1) AS Items from rawdata.eggozdb.order_orderline group by order_id) Ol2 ON O.id=Ol2.order_id WHERE O.status <> 'cancelled' group by O.id,Ol1.id,O.status",
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
            