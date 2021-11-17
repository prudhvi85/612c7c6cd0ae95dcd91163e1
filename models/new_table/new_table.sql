{{ config(
            materialized='table',
                post_hook={
                    "sql": "UPDATE new_table SET number=1 where number=5008;",
                    "transaction": true
                }
            ) }}
            ;with sample_data as (
                select * from {{ source('maplemonk_db_ecommerce','new_table') }}
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            