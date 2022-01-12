
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table', alias= var('prefix')+ 'Products')}}

with source_data as (

select
    to_varchar(get_path(parse_json(_airbyte_data), '"id"')) as ID,
    to_varchar(get_path(parse_json(_airbyte_data), '"tags"')) as TAGS,

        get_path(parse_json(table_alias._airbyte_data), '"image"')
     as IMAGE,
    to_varchar(get_path(parse_json(_airbyte_data), '"title"')) as TITLE,
    to_varchar(get_path(parse_json(_airbyte_data), '"handle"')) as HANDLE,
    get_path(parse_json(_airbyte_data), '"images"') as IMAGES,
    to_varchar(get_path(parse_json(_airbyte_data), '"status"')) as STATUS,
    to_varchar(get_path(parse_json(_airbyte_data), '"vendor"')) as VENDOR,
    get_path(parse_json(_airbyte_data), '"options"') as OPTIONS,
    get_path(parse_json(_airbyte_data), '"variants"') as VARIANTS,
    to_varchar(get_path(parse_json(_airbyte_data), '"body_html"')) as BODY_HTML,
    to_varchar(get_path(parse_json(_airbyte_data), '"created_at"')) as CREATED_AT,
    to_varchar(get_path(parse_json(_airbyte_data), '"updated_at"')) as UPDATED_AT,
    to_varchar(get_path(parse_json(_airbyte_data), '"product_type"')) as PRODUCT_TYPE,
    to_varchar(get_path(parse_json(_airbyte_data), '"published_at"')) as PUBLISHED_AT,
    to_varchar(get_path(parse_json(_airbyte_data), '"published_scope"')) as PUBLISHED_SCOPE,
    to_varchar(get_path(parse_json(_airbyte_data), '"template_suffix"')) as TEMPLATE_SUFFIX,
    to_varchar(get_path(parse_json(_airbyte_data), '"admin_graphql_api_id"')) as ADMIN_GRAPHQL_API_ID,
    _AIRBYTE_AB_ID,
    _AIRBYTE_EMITTED_AT,
    convert_timezone('UTC', current_timestamp()) as _AIRBYTE_NORMALIZED_AT
from {{var('prefix')}}_AIRBYTE_RAW_PRODUCTS as table_alias
-- PRODUCTS
where 1 = 1


)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
