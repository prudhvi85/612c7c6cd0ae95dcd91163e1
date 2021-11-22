{{ config(
            materialized='table',
                post_hook={
                    "sql": "alter table DEMO_DB.AKA_DB.NAVEEN_Test RENAME TO DEMO_DB.AKA_DB.NAV_HOPE_TEST;",
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
            