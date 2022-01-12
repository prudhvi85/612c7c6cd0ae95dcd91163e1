
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table', alias= var('prefix')+ 'Customers') }}

with source_data as (
    select
        to_varchar(get_path(parse_json(_airbyte_data), '"id"')) as ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"note"')) as NOTE,
        to_varchar(get_path(parse_json(_airbyte_data), '"tags"')) as TAGS,
        to_varchar(get_path(parse_json(_airbyte_data), '"email"')) as EMAIL,
        to_varchar(get_path(parse_json(_airbyte_data), '"phone"')) as PHONE,
        to_varchar(get_path(parse_json(_airbyte_data), '"state"')) as STATE,
        to_varchar(get_path(parse_json(_airbyte_data), '"currency"')) as CURRENCY,
        get_path(parse_json(_airbyte_data), '"addresses"') as ADDRESSES,
        to_varchar(get_path(parse_json(_airbyte_data), '"last_name"')) as LAST_NAME,
        to_varchar(get_path(parse_json(_airbyte_data), '"created_at"')) as CREATED_AT,
        to_varchar(get_path(parse_json(_airbyte_data), '"first_name"')) as FIRST_NAME,
        to_varchar(get_path(parse_json(_airbyte_data), '"tax_exempt"')) as TAX_EXEMPT,
        to_varchar(get_path(parse_json(_airbyte_data), '"updated_at"')) as UPDATED_AT,
        to_varchar(get_path(parse_json(_airbyte_data), '"total_spent"')) as TOTAL_SPENT,
        to_varchar(get_path(parse_json(_airbyte_data), '"orders_count"')) as ORDERS_COUNT,
        to_varchar(get_path(parse_json(_airbyte_data), '"last_order_id"')) as LAST_ORDER_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"verified_email"')) as VERIFIED_EMAIL,

            get_path(parse_json(table_alias._airbyte_data), '"default_address"')
        as DEFAULT_ADDRESS,
        to_varchar(get_path(parse_json(_airbyte_data), '"last_order_name"')) as LAST_ORDER_NAME,
        to_varchar(get_path(parse_json(_airbyte_data), '"accepts_marketing"')) as ACCEPTS_MARKETING,
        to_varchar(get_path(parse_json(_airbyte_data), '"admin_graphql_api_id"')) as ADMIN_GRAPHQL_API_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"multipass_identifier"')) as MULTIPASS_IDENTIFIER,

            get_path(parse_json(table_alias._airbyte_data), '"accepts_marketing_updated_at"')
        as ACCEPTS_MARKETING_UPDATED_AT,
        _AIRBYTE_AB_ID,
        _AIRBYTE_EMITTED_AT,
        convert_timezone('UTC', current_timestamp()) as _AIRBYTE_NORMALIZED_AT
    from _AIRBYTE_RAW_{{var('prefix')}}CUSTOMERS as table_alias
    -- CUSTOMERS
    where 1 = 1
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
