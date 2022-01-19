{{ config(
            materialized='table',
                post_hook={
                    "sql": "CREATE TABLE DEMO_DB.DESTSET.Persons(PersonID int,LastName varchar(255));",
                    "transaction": true
                }
            ) }}