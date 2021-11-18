{{ config(
            materialized='table',
                post_hook={
                    "sql": "UPDATE DEMO_DB.mayank.new_table SET number=444 where number=5008;",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.mayank.new_table
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            