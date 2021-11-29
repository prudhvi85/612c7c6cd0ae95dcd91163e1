{{ config(
            materialized='table',
                post_hook={
                    "sql": "lsf;sHFBAS;DSFG",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.maplemonk.BigEcom
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            