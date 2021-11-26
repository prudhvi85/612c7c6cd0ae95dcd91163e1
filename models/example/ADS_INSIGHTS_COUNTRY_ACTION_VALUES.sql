{{ config(
            materialized='table',
                post_hook={
                    "sql": "ALTER table "MM_DB_PUBLIC_ADS INSIGHTS COUNTRY ACTION VALUES" ADD Test_New as ("28d_click"/1000)",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from MM_DB.MM_DB.ADS_INSIGHTS_COUNTRY_ACTION_VALUES
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            