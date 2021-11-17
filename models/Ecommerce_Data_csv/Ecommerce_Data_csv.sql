{{ config(
            materialized='table',
                post_hook={
                    "sql": "[object Promise]",
                    "transaction": true
                }
            ) }}
            ;with sample_data as (
                select * from {{ source('maplemonk_db_ecommerce','Ecommerce_Data_csv') }}
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            