{{ config(
            materialized='table',
                post_hook={
                    "sql": "Create table DEMO_DB.AKA_DB.EXPERIMENT(name varchar(30),deci float);",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.AKA_DB.TESTSEC
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            