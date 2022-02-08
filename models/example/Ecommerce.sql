{{ config(
                        materialized='table',
                            post_hook={
                                "sql": "Drop table if exists DEMO_DB.BATCHTEST.NEWPERSONA;
create table DEMO_DB.BATCHTEST.NEWPERSONA (name varchar(25));",
                                "transaction": true
                            }
                        ) }}
                        with sample_data as (

                            select * from MM_TEST.TEST.Ecommerce
                        ),
                        
                        final as (
                            select * from sample_data
                        )
                        select * from final
                        