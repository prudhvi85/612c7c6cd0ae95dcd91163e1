{{ config(
            materialized='table',
                post_hook={
                    "sql": "ecommm;",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.PUBLIC.Ecommerce
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            