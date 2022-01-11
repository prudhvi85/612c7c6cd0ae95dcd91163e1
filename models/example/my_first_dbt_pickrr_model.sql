
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

    select
    to_varchar(get_path(parse_json(_airbyte_data), '"err"')) as ERR,
    to_varchar(get_path(parse_json(_airbyte_data), '"sku"')) as SKU,

        get_path(parse_json(table_alias._airbyte_data), '"info"')
     as INFO,
    to_varchar(get_path(parse_json(_airbyte_data), '"logo"')) as LOGO,
    to_varchar(get_path(parse_json(_airbyte_data), '"height"')) as HEIGHT,
    to_varchar(get_path(parse_json(_airbyte_data), '"is_cod"')) as IS_COD,
    to_varchar(get_path(parse_json(_airbyte_data), '"length"')) as LENGTH,

        get_path(parse_json(table_alias._airbyte_data), '"status"')
     as STATUS,
    to_varchar(get_path(parse_json(_airbyte_data), '"weight"')) as WEIGHT,
    to_varchar(get_path(parse_json(_airbyte_data), '"breadth"')) as BREADTH,
    to_varchar(get_path(parse_json(_airbyte_data), '"hsn_code"')) as HSN_CODE,
    to_varchar(get_path(parse_json(_airbyte_data), '"quantity"')) as QUANTITY,
    to_varchar(get_path(parse_json(_airbyte_data), '"edd_stamp"')) as EDD_STAMP,
    get_path(parse_json(_airbyte_data), '"item_list"') as ITEM_LIST,
    get_path(parse_json(_airbyte_data), '"track_arr"') as TRACK_ARR,
    to_varchar(get_path(parse_json(_airbyte_data), '"auth_token"')) as AUTH_TOKEN,
    to_varchar(get_path(parse_json(_airbyte_data), '"created_at"')) as CREATED_AT,
    to_varchar(get_path(parse_json(_airbyte_data), '"is_reverse"')) as IS_REVERSE,
    to_varchar(get_path(parse_json(_airbyte_data), '"order_type"')) as ORDER_TYPE,
    to_varchar(get_path(parse_json(_airbyte_data), '"tracking_id"')) as TRACKING_ID,
    to_varchar(get_path(parse_json(_airbyte_data), '"web_address"')) as WEB_ADDRESS,
    to_varchar(get_path(parse_json(_airbyte_data), '"billing_zone"')) as BILLING_ZONE,
    to_varchar(get_path(parse_json(_airbyte_data), '"company_name"')) as COMPANY_NAME,
    to_varchar(get_path(parse_json(_airbyte_data), '"courier_used"')) as COURIER_USED,
    to_varchar(get_path(parse_json(_airbyte_data), '"product_name"')) as PRODUCT_NAME,
    to_varchar(get_path(parse_json(_airbyte_data), '"show_details"')) as SHOW_DETAILS,
    to_varchar(get_path(parse_json(_airbyte_data), '"dispatch_mode"')) as DISPATCH_MODE,
    to_varchar(get_path(parse_json(_airbyte_data), '"client_order_id"')) as CLIENT_ORDER_ID,
    to_varchar(get_path(parse_json(_airbyte_data), '"pickrr_order_id"')) as PICKRR_ORDER_ID,
    to_varchar(get_path(parse_json(_airbyte_data), '"client_extra_var"')) as CLIENT_EXTRA_VAR,
    to_varchar(get_path(parse_json(_airbyte_data), '"order_created_at"')) as ORDER_CREATED_AT,
    to_varchar(get_path(parse_json(_airbyte_data), '"courier_parent_name"')) as COURIER_PARENT_NAME,
    to_varchar(get_path(parse_json(_airbyte_data), '"courier_tracking_id"')) as COURIER_TRACKING_ID,
    to_varchar(get_path(parse_json(_airbyte_data), '"item_tax_percentage"')) as ITEM_TAX_PERCENTAGE,
    to_varchar(get_path(parse_json(_airbyte_data), '"courier_input_weight"')) as COURIER_INPUT_WEIGHT,
    _AIRBYTE_AB_ID,
    _AIRBYTE_EMITTED_AT,
    convert_timezone('UTC', current_timestamp()) as _AIRBYTE_NORMALIZED_AT
from "DEMO_DB".NONORM._AIRBYTE_RAW_TESTPICKRR3GET_ORDERS_BY_IDS as table_alias
-- TESTPICKRR2GET_ORDERS_BY_IDS
where 1 = 1

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
