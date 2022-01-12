{{ config(
            materialized='table',
                post_hook={
                    "sql": ";ecomm;paymentBal",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.maplemonk.Ecommerce
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            