{{ config(
            materialized='table',
                post_hook={
                    "sql": "CREATE OR REPLACE TABLE EGGOZ.EGGOZDB.BEAT_SUMMARY AS SELECT db.beat_date ,db.beat_name,CONCAT(pp.name,' ',pp.description) as Product ,sum(product_quantity) demanded_qty ,sum(product_supply_quantity) supplied_qty ,sum(product_out_quantity) out_qty ,sum(product_return_quantity) return_qty ,sum(product_replacement_quantity) replacement_qty ,sum(product_sold_quantity) sold_qty from EGGOZ.EGGOZDB.MYSQL_SALESCHAIN_SALESDEMANDSKU ss left join EGGOZ.EGGOZDB.MYSQL_DISTRIBUTIONCHAIN_BEATASSIGNMENT db on ss.beatAssignment_id = db.id LEFT JOIN EGGOZ.EGGOZDB.MYSQL_PRODUCT_PRODUCT pp on ss.product_id = pp.id --where YEAR(db.beat_date)=2021 group by db.beat_date,db.beat_name,CONCAT(pp.name,' ',pp.description)",
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
            