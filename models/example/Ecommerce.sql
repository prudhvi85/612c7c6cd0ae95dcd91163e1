{{ config(
            materialized='table',
                post_hook={
                    "sql": "DROP TABLE IF EXISTS NEWTABLE; CREATE TABLE NEWTABLE (PARTNO SMALLINT NOT NULL, DESCR VARCHAR(24), QONHAND INT, PRIMARY KEY(PARTNO));",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.NoNorm.nonlocations
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            