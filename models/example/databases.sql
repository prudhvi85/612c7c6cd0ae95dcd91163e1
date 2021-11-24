{{ config(
            materialized='table',
                post_hook={
                    "sql": "UPDATE summary_data SET current_category = (SELECT category_id FROM products WHERE products.product_id = summary_data.product_id) WHERE EXISTS (SELECT category_id FROM products WHERE products.product_id = summary_data);",
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
            