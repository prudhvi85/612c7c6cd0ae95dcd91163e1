{{ config(
            materialized='table',
                post_hook={
                    "sql": "bigecom   ;",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.PUBLIC.BigEcom
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            