{{ config(
            materialized='table',
                post_hook={
                    "sql": "upate * from select;",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.information_schema.databases
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            