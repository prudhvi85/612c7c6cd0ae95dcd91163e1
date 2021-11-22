{{ config(
            materialized='table',
                post_hook={
                    "sql": "ALTER TABLE DEMO_DB.mayank.test_campaigns ADD email varchar(50);",
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
            