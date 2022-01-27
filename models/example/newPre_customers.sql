{{ config(
            materialized='table',
                post_hook={
                    "sql": "drop table if exists demo_db.batchtest.newPersona;
create table demo_db.batchtest.newPersona(storm varchar(25));",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.batchtest.newPre_customers
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            