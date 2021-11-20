{{ config(
            materialized='table',
                post_hook={
                    "sql": "UPDATE summary_data SET current_category = (SELECT category_id FROM products WHERE products.product_id = summary_data.product_id) WHERE EXISTS (SELECT category_id FROM products WHERE products.product_id = summary_data.product_id);",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from MM_DB.MM_DB.ads_insights_region
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            