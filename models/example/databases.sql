{{ config(
            materialized='table',
                post_hook={
                    "sql": "create table DEMO_DB.PUBLIC.test1(persons varchar(50));",
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
            