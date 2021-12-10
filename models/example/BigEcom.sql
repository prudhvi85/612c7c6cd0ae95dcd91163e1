{{ config(
            materialized='table',
                post_hook={
                    "sql": "ALTER TABLE DEMO_DB.PUBLIC.BigEcom ADD Email varchar(255);",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.maplemonk.BigEcom
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            