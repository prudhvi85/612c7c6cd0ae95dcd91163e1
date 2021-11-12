{{ config(
            materialized='table',
                post_hook={
                    "sql": "even this",
                    "transaction": true
                }
            ) }}
            ;with sample_data as (
                select * from {{ source('maplemonk_db_ecommerce','HR_Data_csv') }}
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            