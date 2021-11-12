{{ config(
            materialized='table',
                post_hook={
                    "sql": "omg salary",
                    "transaction": true
                }
            ) }}
            ;with sample_data as (
                select * from {{ source('maplemonk_db_ecommerce','salaries_data_csv') }}
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            