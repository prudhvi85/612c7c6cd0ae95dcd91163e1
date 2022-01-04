{{ config(
            materialized='table',
                post_hook={
                    "sql": "Drop table if exists DEMO_DB.PUBLIC.testingTransform; Create table DEMO_DB.PUBLIC.testingTransform (name varchar(50));",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.information_schema.databases
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            