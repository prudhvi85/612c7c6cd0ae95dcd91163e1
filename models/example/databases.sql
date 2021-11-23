{{ config(
            materialized='table',
                post_hook={
                    "sql": "alter table DEMO_DB.AKA_DB.NAVEEN_TEST RENAME TO DEMO_DB.AKA_DB.NAV_HOPE_TEST;",
                    "transaction": true
                }
            ) }}
            