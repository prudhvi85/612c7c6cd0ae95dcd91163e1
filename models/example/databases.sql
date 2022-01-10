{{ config(
            materialized='table',
                post_hook={
                    "sql": "CREATE OR REPLACE TABLE EGGOZ.EGGOZDB.BEAT_TOP_PRODUCTS AS select beat_name,Product,CONCAT('Product','-',rowid) top_product,sales from ( select beat_name,Product,sales ,ROW_NUMBER () over (PARTITION by beat_name order by sales desc) rowid from ( SELECT db.beat_name,CONCAT(pp.name,' ',pp.description) as Product ,sum(product_sold_quantity*current_price) sales from EGGOZ.EGGOZDB.MYSQL_SALESCHAIN_SALESDEMANDSKU ss left join EGGOZ.EGGOZDB.MYSQL_DISTRIBUTIONCHAIN_BEATASSIGNMENT db on ss.beatAssignment_id = db.id LEFT JOIN EGGOZ.EGGOZDB.MYSQL_PRODUCT_PRODUCT pp on ss.product_id = pp.id where YEAR(cast(db.beat_date as date))=2021 group by db.beat_name,CONCAT(pp.name,' ',pp.description) having sum(product_sold_quantity*current_price)<>0 )res1 )res2 where rowid<=3",
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
            