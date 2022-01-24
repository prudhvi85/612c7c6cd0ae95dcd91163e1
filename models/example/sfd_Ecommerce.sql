{{ config(
            materialized='table',
                post_hook={
                    "sql": " create table demo_db.batchtest.new(storm varchar(25)); create table demo_db.batchtest.neww(storm varchar(25));",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.batchtest.sfd_Ecommerce
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            