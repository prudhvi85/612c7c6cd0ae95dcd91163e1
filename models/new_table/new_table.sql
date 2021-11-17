{{ config(
            materialized='table',
                post_hook={
                    "sql": "UPDATE {{ ref('new_table') }} SET number=1 where number=5008;",
                    "transaction": true
                }
            ) }}
            ;with sample_data as (
                select * from {{ source('89cb16d2-107c-4028-aa65-fee518edbf73_gitJamnew_table','new_table') }}
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            