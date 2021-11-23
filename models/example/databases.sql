{{ config(
            materialized='table',
                post_hook={
                    "sql": "alter table DEMO_DB.AKA_DB.NAV_HOPE_TEST RENAME TO DEMO_DB.AKA_DB.NAVEEN_Test;",
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
            