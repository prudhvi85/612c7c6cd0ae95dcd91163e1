{{ config(
            materialized='table',
                post_hook={
                    "sql": "UPDATE DEMO_DB.mayank.new_table SET number = 1001 where number=36; ALTER TABLE DEMO_DB.mayank.new_table ADD newCol varchar(255); SELECT *, (id + number) AS Sum FROM DEMO_DB.mayank.new_table;",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from DEMO_DB.mayank.new_table
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            