{{ config(
            materialized='table',
                post_hook={
                    "sql": "create table demo_db.batchtest.newPersona(storm varchar(25))
;create table demo_db.batchtest.newPer(storm varchar(25))
;",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.batchtest.Ecommerce
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            