
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table', alias= var('prefix')+ 'Orders' ) }}

with source_data as (

    select
        to_varchar(get_path(parse_json(_airbyte_data), '"id"')) as ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"name"')) as NAME,
        to_varchar(get_path(parse_json(_airbyte_data), '"note"')) as NOTE,
        to_varchar(get_path(parse_json(_airbyte_data), '"tags"')) as TAGS,
        to_varchar(get_path(parse_json(_airbyte_data), '"test"')) as TEST,
        to_varchar(get_path(parse_json(_airbyte_data), '"email"')) as EMAIL,
        to_varchar(get_path(parse_json(_airbyte_data), '"phone"')) as PHONE,
        to_varchar(get_path(parse_json(_airbyte_data), '"token"')) as TOKEN,
        to_varchar(get_path(parse_json(_airbyte_data), '"app_id"')) as APP_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"number"')) as NUMBER,
        to_varchar(get_path(parse_json(_airbyte_data), '"gateway"')) as GATEWAY,
        get_path(parse_json(_airbyte_data), '"refunds"') as REFUNDS,
        to_varchar(get_path(parse_json(_airbyte_data), '"user_id"')) as USER_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"currency"')) as CURRENCY,

            get_path(parse_json(table_alias._airbyte_data), '"customer"')
        as CUSTOMER,
        to_varchar(get_path(parse_json(_airbyte_data), '"closed_at"')) as CLOSED_AT,
        to_varchar(get_path(parse_json(_airbyte_data), '"confirmed"')) as CONFIRMED,
        to_varchar(get_path(parse_json(_airbyte_data), '"device_id"')) as DEVICE_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"reference"')) as REFERENCE,
        get_path(parse_json(_airbyte_data), '"tax_lines"') as TAX_LINES,
        to_varchar(get_path(parse_json(_airbyte_data), '"total_tax"')) as TOTAL_TAX,
        to_varchar(get_path(parse_json(_airbyte_data), '"browser_ip"')) as BROWSER_IP,
        to_varchar(get_path(parse_json(_airbyte_data), '"cart_token"')) as CART_TOKEN,
        to_varchar(get_path(parse_json(_airbyte_data), '"created_at"')) as CREATED_AT,
        get_path(parse_json(_airbyte_data), '"line_items"') as LINE_ITEMS,
        to_varchar(get_path(parse_json(_airbyte_data), '"source_url"')) as SOURCE_URL,
        to_varchar(get_path(parse_json(_airbyte_data), '"updated_at"')) as UPDATED_AT,
        to_varchar(get_path(parse_json(_airbyte_data), '"checkout_id"')) as CHECKOUT_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"location_id"')) as LOCATION_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"source_name"')) as SOURCE_NAME,
        to_varchar(get_path(parse_json(_airbyte_data), '"total_price"')) as TOTAL_PRICE,
        to_varchar(get_path(parse_json(_airbyte_data), '"cancelled_at"')) as CANCELLED_AT,
        get_path(parse_json(_airbyte_data), '"fulfillments"') as FULFILLMENTS,
        to_varchar(get_path(parse_json(_airbyte_data), '"landing_site"')) as LANDING_SITE,
        to_varchar(get_path(parse_json(_airbyte_data), '"order_number"')) as ORDER_NUMBER,
        to_varchar(get_path(parse_json(_airbyte_data), '"processed_at"')) as PROCESSED_AT,
        to_varchar(get_path(parse_json(_airbyte_data), '"total_weight"')) as TOTAL_WEIGHT,
        to_varchar(get_path(parse_json(_airbyte_data), '"cancel_reason"')) as CANCEL_REASON,
        to_varchar(get_path(parse_json(_airbyte_data), '"contact_email"')) as CONTACT_EMAIL,

            get_path(parse_json(table_alias._airbyte_data), '"total_tax_set"')
        as TOTAL_TAX_SET,
        to_varchar(get_path(parse_json(_airbyte_data), '"checkout_token"')) as CHECKOUT_TOKEN,

            get_path(parse_json(table_alias._airbyte_data), '"client_details"')
        as CLIENT_DETAILS,
        get_path(parse_json(_airbyte_data), '"discount_codes"') as DISCOUNT_CODES,
        to_varchar(get_path(parse_json(_airbyte_data), '"referring_site"')) as REFERRING_SITE,
        get_path(parse_json(_airbyte_data), '"shipping_lines"') as SHIPPING_LINES,
        to_varchar(get_path(parse_json(_airbyte_data), '"subtotal_price"')) as SUBTOTAL_PRICE,
        to_varchar(get_path(parse_json(_airbyte_data), '"taxes_included"')) as TAXES_INCLUDED,

            get_path(parse_json(table_alias._airbyte_data), '"billing_address"')
        as BILLING_ADDRESS,
        to_varchar(get_path(parse_json(_airbyte_data), '"customer_locale"')) as CUSTOMER_LOCALE,
        get_path(parse_json(_airbyte_data), '"note_attributes"') as NOTE_ATTRIBUTES,

                get_path(parse_json(table_alias._airbyte_data), '"payment_details"')
        as PAYMENT_DETAILS,
        to_varchar(get_path(parse_json(_airbyte_data), '"total_discounts"')) as TOTAL_DISCOUNTS,

            get_path(parse_json(table_alias._airbyte_data), '"total_price_set"')
        as TOTAL_PRICE_SET,
        to_varchar(get_path(parse_json(_airbyte_data), '"total_price_usd"')) as TOTAL_PRICE_USD,
        to_varchar(get_path(parse_json(_airbyte_data), '"financial_status"')) as FINANCIAL_STATUS,
        to_varchar(get_path(parse_json(_airbyte_data), '"landing_site_ref"')) as LANDING_SITE_REF,
        to_varchar(get_path(parse_json(_airbyte_data), '"order_status_url"')) as ORDER_STATUS_URL,

            get_path(parse_json(table_alias._airbyte_data), '"shipping_address"')
        as SHIPPING_ADDRESS,
        to_varchar(get_path(parse_json(_airbyte_data), '"current_total_tax"')) as CURRENT_TOTAL_TAX,
        to_varchar(get_path(parse_json(_airbyte_data), '"processing_method"')) as PROCESSING_METHOD,
        to_varchar(get_path(parse_json(_airbyte_data), '"source_identifier"')) as SOURCE_IDENTIFIER,
        to_varchar(get_path(parse_json(_airbyte_data), '"total_outstanding"')) as TOTAL_OUTSTANDING,
        to_varchar(get_path(parse_json(_airbyte_data), '"fulfillment_status"')) as FULFILLMENT_STATUS,

            get_path(parse_json(table_alias._airbyte_data), '"subtotal_price_set"')
        as SUBTOTAL_PRICE_SET,
        to_varchar(get_path(parse_json(_airbyte_data), '"total_tip_received"')) as TOTAL_TIP_RECEIVED,
        to_varchar(get_path(parse_json(_airbyte_data), '"current_total_price"')) as CURRENT_TOTAL_PRICE,

            get_path(parse_json(table_alias._airbyte_data), '"total_discounts_set"')
        as TOTAL_DISCOUNTS_SET,
        to_varchar(get_path(parse_json(_airbyte_data), '"admin_graphql_api_id"')) as ADMIN_GRAPHQL_API_ID,
        get_path(parse_json(_airbyte_data), '"discount_allocations"') as DISCOUNT_ALLOCATIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"presentment_currency"')) as PRESENTMENT_CURRENCY,

            get_path(parse_json(table_alias._airbyte_data), '"current_total_tax_set"')
        as CURRENT_TOTAL_TAX_SET,
        get_path(parse_json(_airbyte_data), '"payment_gateway_names"') as PAYMENT_GATEWAY_NAMES,
        to_varchar(get_path(parse_json(_airbyte_data), '"current_subtotal_price"')) as CURRENT_SUBTOTAL_PRICE,
        to_varchar(get_path(parse_json(_airbyte_data), '"total_line_items_price"')) as TOTAL_LINE_ITEMS_PRICE,
        to_varchar(get_path(parse_json(_airbyte_data), '"buyer_accepts_marketing"')) as BUYER_ACCEPTS_MARKETING,
        to_varchar(get_path(parse_json(_airbyte_data), '"current_total_discounts"')) as CURRENT_TOTAL_DISCOUNTS,

            get_path(parse_json(table_alias._airbyte_data), '"current_total_price_set"')
        as CURRENT_TOTAL_PRICE_SET,
        to_varchar(get_path(parse_json(_airbyte_data), '"current_total_duties_set"')) as CURRENT_TOTAL_DUTIES_SET,

            get_path(parse_json(table_alias._airbyte_data), '"total_shipping_price_set"')
        as TOTAL_SHIPPING_PRICE_SET,
        to_varchar(get_path(parse_json(_airbyte_data), '"original_total_duties_set"')) as ORIGINAL_TOTAL_DUTIES_SET,

            get_path(parse_json(table_alias._airbyte_data), '"current_subtotal_price_set"')
        as CURRENT_SUBTOTAL_PRICE_SET,

            get_path(parse_json(table_alias._airbyte_data), '"total_line_items_price_set"')
        as TOTAL_LINE_ITEMS_PRICE_SET,

            get_path(parse_json(table_alias._airbyte_data), '"current_total_discounts_set"')
        as CURRENT_TOTAL_DISCOUNTS_SET,
        _AIRBYTE_AB_ID,
        _AIRBYTE_EMITTED_AT,
        convert_timezone('UTC', current_timestamp()) as _AIRBYTE_NORMALIZED_AT
    -- from "DEMO_DB".NONORM._AIRBYTE_RAW_ORDERS as table_alias
        from {{var('prefix')}}_AIRBYTE_RAW_ORDERS as table_alias
    -- ORDERS
    where 1 = 1
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
