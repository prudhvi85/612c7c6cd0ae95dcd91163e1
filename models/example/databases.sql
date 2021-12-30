{{ config(
            materialized='table',
                post_hook={
                    "sql": "sdvhbas",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from EGGOZ.information_schema.databases
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            