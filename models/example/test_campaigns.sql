{{ config(
            materialized='table',
                post_hook={
                    "sql": "UPDATE DEMO_DB.MAYANK.test_campaigns SET account_id=540514437231736 where account_id=540514437231734;",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.mayank.test_campaigns
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            