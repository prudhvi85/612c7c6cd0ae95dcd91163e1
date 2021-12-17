{{ config(
            materialized='table',
                post_hook={
                    "sql": "CREATE OR REPLACE TABLE Vahdam_db.maplemonk.Shopify_All_customers AS select *,'Shopify_India' AS Shop_Name from Vahdam_db.maplemonk.shopifyindia_customers UNION ALL select *,'Shopify_USA' AS Shop_Name from Vahdam_db.maplemonk.shopifyUSA_customers UNION ALL select *,'Shopify_Global' AS Shop_Name from Vahdam_db.maplemonk.shopifyGlobal_customers UNION ALL select *,'Shopify_Germany' AS Shop_Name from Vahdam_db.maplemonk.shopifyGermany_customers UNION ALL select *,'Shopify_Italy' AS Shop_Name from Vahdam_db.maplemonk.shopifyItaly_customers UNION ALL select *,'Shopify_USA_Wholesale' AS Shop_Name from Vahdam_db.maplemonk.shopifyUSAWHOLESALE_customers",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from VAHDAM_DB.information_schema.databases
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            