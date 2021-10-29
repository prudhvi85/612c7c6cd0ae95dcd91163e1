{{ config(
            materialized='table',
                post_hook={
                    "sql": "",
                    "transaction": true
                }
            ) }}
            ;with sample_data as (
                select * from {{ source('maplemonk_db_ecommerce','BigEcom') }}
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            