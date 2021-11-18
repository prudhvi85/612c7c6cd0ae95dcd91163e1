{{ config(
            materialized='table',
                post_hook={
                    "sql": "UPDATE new_table SET number=444 where number=1;",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.undefined.new_table
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            