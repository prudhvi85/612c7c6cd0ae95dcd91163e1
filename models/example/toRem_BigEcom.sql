{{ config(
            materialized='table',
                post_hook={
                    "sql": "create table demo_db.batchtest.newQ(storm varchar(25));",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.batchtest.toRem_BigEcom
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            