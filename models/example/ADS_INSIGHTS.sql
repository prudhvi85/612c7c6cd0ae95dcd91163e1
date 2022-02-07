
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table', alias= var('prefix')+ 'ADS_INSIGHTS' ) }}

with source_data as (
    select
        to_varchar(get_path(parse_json(_airbyte_data), '"cpc"')) as CPC,
        to_varchar(get_path(parse_json(_airbyte_data), '"cpm"')) as CPM,
        to_varchar(get_path(parse_json(_airbyte_data), '"cpp"')) as CPP,
        to_varchar(get_path(parse_json(_airbyte_data), '"ctr"')) as CTR,
        to_varchar(get_path(parse_json(_airbyte_data), '"ad_id"')) as AD_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"reach"')) as REACH,
        to_varchar(get_path(parse_json(_airbyte_data), '"spend"')) as SPEND,
        to_varchar(get_path(parse_json(_airbyte_data), '"clicks"')) as CLICKS,
        to_varchar(get_path(parse_json(_airbyte_data), '"labels"')) as LABELS,
        get_path(parse_json(_airbyte_data), '"actions"') as ACTIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"ad_name"')) as AD_NAME,
        to_varchar(get_path(parse_json(_airbyte_data), '"adset_id"')) as ADSET_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"location"')) as LOCATION,
        to_varchar(get_path(parse_json(_airbyte_data), '"wish_bid"')) as WISH_BID,
        to_varchar(get_path(parse_json(_airbyte_data), '"date_stop"')) as DATE_STOP,
        to_varchar(get_path(parse_json(_airbyte_data), '"frequency"')) as FREQUENCY,
        to_varchar(get_path(parse_json(_airbyte_data), '"objective"')) as OBJECTIVE,
        to_varchar(get_path(parse_json(_airbyte_data), '"account_id"')) as ACCOUNT_ID,
        to_varchar(get_path(parse_json(_airbyte_data), '"adset_name"')) as ADSET_NAME,
        to_varchar(get_path(parse_json(_airbyte_data), '"date_start"')) as DATE_START,
        to_varchar(get_path(parse_json(_airbyte_data), '"unique_ctr"')) as UNIQUE_CTR,
        to_varchar(get_path(parse_json(_airbyte_data), '"auction_bid"')) as AUCTION_BID,
        to_varchar(get_path(parse_json(_airbyte_data), '"buying_type"')) as BUYING_TYPE,
        to_varchar(get_path(parse_json(_airbyte_data), '"campaign_id"')) as CAMPAIGN_ID,
        get_path(parse_json(_airbyte_data), '"conversions"') as CONVERSIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"impressions"')) as IMPRESSIONS,
        get_path(parse_json(_airbyte_data), '"website_ctr"') as WEBSITE_CTR,
        to_varchar(get_path(parse_json(_airbyte_data), '"account_name"')) as ACCOUNT_NAME,
        to_varchar(get_path(parse_json(_airbyte_data), '"created_time"')) as CREATED_TIME,
        to_varchar(get_path(parse_json(_airbyte_data), '"social_spend"')) as SOCIAL_SPEND,
        to_varchar(get_path(parse_json(_airbyte_data), '"updated_time"')) as UPDATED_TIME,
        get_path(parse_json(_airbyte_data), '"action_values"') as ACTION_VALUES,
        to_varchar(get_path(parse_json(_airbyte_data), '"age_targeting"')) as AGE_TARGETING,
        to_varchar(get_path(parse_json(_airbyte_data), '"campaign_name"')) as CAMPAIGN_NAME,
        get_path(parse_json(_airbyte_data), '"purchase_roas"') as PURCHASE_ROAS,
        to_varchar(get_path(parse_json(_airbyte_data), '"unique_clicks"')) as UNIQUE_CLICKS,
        get_path(parse_json(_airbyte_data), '"unique_actions"') as UNIQUE_ACTIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"full_view_reach"')) as FULL_VIEW_REACH,
        get_path(parse_json(_airbyte_data), '"outbound_clicks"') as OUTBOUND_CLICKS,
        to_varchar(get_path(parse_json(_airbyte_data), '"quality_ranking"')) as QUALITY_RANKING,
        to_varchar(get_path(parse_json(_airbyte_data), '"account_currency"')) as ACCOUNT_CURRENCY,
        get_path(parse_json(_airbyte_data), '"ad_click_actions"') as AD_CLICK_ACTIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"gender_targeting"')) as GENDER_TARGETING,
        get_path(parse_json(_airbyte_data), '"conversion_values"') as CONVERSION_VALUES,
        get_path(parse_json(_airbyte_data), '"cost_per_ad_click"') as COST_PER_AD_CLICK,
        get_path(parse_json(_airbyte_data), '"cost_per_thruplay"') as COST_PER_THRUPLAY,
        to_varchar(get_path(parse_json(_airbyte_data), '"optimization_goal"')) as OPTIMIZATION_GOAL,
        to_varchar(get_path(parse_json(_airbyte_data), '"inline_link_clicks"')) as INLINE_LINK_CLICKS,
        get_path(parse_json(_airbyte_data), '"video_play_actions"') as VIDEO_PLAY_ACTIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"attribution_setting"')) as ATTRIBUTION_SETTING,
        get_path(parse_json(_airbyte_data), '"cost_per_conversion"') as COST_PER_CONVERSION,
        get_path(parse_json(_airbyte_data), '"outbound_clicks_ctr"') as OUTBOUND_CLICKS_CTR,
        to_varchar(get_path(parse_json(_airbyte_data), '"canvas_avg_view_time"')) as CANVAS_AVG_VIEW_TIME,
        get_path(parse_json(_airbyte_data), '"cost_per_action_type"') as COST_PER_ACTION_TYPE,
        get_path(parse_json(_airbyte_data), '"ad_impression_actions"') as AD_IMPRESSION_ACTIONS,
        get_path(parse_json(_airbyte_data), '"catalog_segment_value"') as CATALOG_SEGMENT_VALUE,
        to_varchar(get_path(parse_json(_airbyte_data), '"cost_per_unique_click"')) as COST_PER_UNIQUE_CLICK,
        to_varchar(get_path(parse_json(_airbyte_data), '"full_view_impressions"')) as FULL_VIEW_IMPRESSIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"inline_link_click_ctr"')) as INLINE_LINK_CLICK_CTR,
        get_path(parse_json(_airbyte_data), '"website_purchase_roas"') as WEBSITE_PURCHASE_ROAS,
        to_varchar(get_path(parse_json(_airbyte_data), '"estimated_ad_recallers"')) as ESTIMATED_AD_RECALLERS,
        to_varchar(get_path(parse_json(_airbyte_data), '"inline_post_engagement"')) as INLINE_POST_ENGAGEMENT,
        to_varchar(get_path(parse_json(_airbyte_data), '"unique_link_clicks_ctr"')) as UNIQUE_LINK_CLICKS_CTR,
        get_path(parse_json(_airbyte_data), '"unique_outbound_clicks"') as UNIQUE_OUTBOUND_CLICKS,
        to_varchar(get_path(parse_json(_airbyte_data), '"auction_competitiveness"')) as AUCTION_COMPETITIVENESS,
        to_varchar(get_path(parse_json(_airbyte_data), '"canvas_avg_view_percent"')) as CANVAS_AVG_VIEW_PERCENT,
        get_path(parse_json(_airbyte_data), '"catalog_segment_actions"') as CATALOG_SEGMENT_ACTIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"conversion_rate_ranking"')) as CONVERSION_RATE_RANKING,
        get_path(parse_json(_airbyte_data), '"converted_product_value"') as CONVERTED_PRODUCT_VALUE,
        get_path(parse_json(_airbyte_data), '"cost_per_outbound_click"') as COST_PER_OUTBOUND_CLICK,
        to_varchar(get_path(parse_json(_airbyte_data), '"engagement_rate_ranking"')) as ENGAGEMENT_RATE_RANKING,
        to_varchar(get_path(parse_json(_airbyte_data), '"estimated_ad_recall_rate"')) as ESTIMATED_AD_RECALL_RATE,
        get_path(parse_json(_airbyte_data), '"mobile_app_purchase_roas"') as MOBILE_APP_PURCHASE_ROAS,
        get_path(parse_json(_airbyte_data), '"video_play_curve_actions"') as VIDEO_PLAY_CURVE_ACTIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"unique_inline_link_clicks"')) as UNIQUE_INLINE_LINK_CLICKS,
        get_path(parse_json(_airbyte_data), '"video_p25_watched_actions"') as VIDEO_P25_WATCHED_ACTIONS,
        get_path(parse_json(_airbyte_data), '"video_p50_watched_actions"') as VIDEO_P50_WATCHED_ACTIONS,
        get_path(parse_json(_airbyte_data), '"video_p75_watched_actions"') as VIDEO_P75_WATCHED_ACTIONS,
        get_path(parse_json(_airbyte_data), '"video_p95_watched_actions"') as VIDEO_P95_WATCHED_ACTIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"auction_max_competitor_bid"')) as AUCTION_MAX_COMPETITOR_BID,
        get_path(parse_json(_airbyte_data), '"converted_product_quantity"') as CONVERTED_PRODUCT_QUANTITY,
        get_path(parse_json(_airbyte_data), '"cost_per_15_sec_video_view"') as COST_PER_15_SEC_VIDEO_VIEW,
        to_varchar(get_path(parse_json(_airbyte_data), '"cost_per_inline_link_click"')) as COST_PER_INLINE_LINK_CLICK,
        get_path(parse_json(_airbyte_data), '"unique_outbound_clicks_ctr"') as UNIQUE_OUTBOUND_CLICKS_CTR,
        get_path(parse_json(_airbyte_data), '"video_p100_watched_actions"') as VIDEO_P100_WATCHED_ACTIONS,
        get_path(parse_json(_airbyte_data), '"video_time_watched_actions"') as VIDEO_TIME_WATCHED_ACTIONS,
        get_path(parse_json(_airbyte_data), '"cost_per_unique_action_type"') as COST_PER_UNIQUE_ACTION_TYPE,
        to_varchar(get_path(parse_json(_airbyte_data), '"unique_inline_link_click_ctr"')) as UNIQUE_INLINE_LINK_CLICK_CTR,
        get_path(parse_json(_airbyte_data), '"video_15_sec_watched_actions"') as VIDEO_15_SEC_WATCHED_ACTIONS,
        get_path(parse_json(_airbyte_data), '"video_30_sec_watched_actions"') as VIDEO_30_SEC_WATCHED_ACTIONS,
        get_path(parse_json(_airbyte_data), '"cost_per_unique_outbound_click"') as COST_PER_UNIQUE_OUTBOUND_CLICK,
        get_path(parse_json(_airbyte_data), '"video_avg_time_watched_actions"') as VIDEO_AVG_TIME_WATCHED_ACTIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"cost_per_estimated_ad_recallers"')) as COST_PER_ESTIMATED_AD_RECALLERS,
        to_varchar(get_path(parse_json(_airbyte_data), '"cost_per_inline_post_engagement"')) as COST_PER_INLINE_POST_ENGAGEMENT,
        to_varchar(get_path(parse_json(_airbyte_data), '"cost_per_unique_inline_link_click"')) as COST_PER_UNIQUE_INLINE_LINK_CLICK,
        to_varchar(get_path(parse_json(_airbyte_data), '"instant_experience_clicks_to_open"')) as INSTANT_EXPERIENCE_CLICKS_TO_OPEN,
        to_varchar(get_path(parse_json(_airbyte_data), '"estimated_ad_recallers_lower_bound"')) as ESTIMATED_AD_RECALLERS_LOWER_BOUND,
        to_varchar(get_path(parse_json(_airbyte_data), '"estimated_ad_recallers_upper_bound"')) as ESTIMATED_AD_RECALLERS_UPPER_BOUND,
        to_varchar(get_path(parse_json(_airbyte_data), '"instant_experience_clicks_to_start"')) as INSTANT_EXPERIENCE_CLICKS_TO_START,
        get_path(parse_json(_airbyte_data), '"instant_experience_outbound_clicks"') as INSTANT_EXPERIENCE_OUTBOUND_CLICKS,
        get_path(parse_json(_airbyte_data), '"video_play_retention_graph_actions"') as VIDEO_PLAY_RETENTION_GRAPH_ACTIONS,
        get_path(parse_json(_airbyte_data), '"cost_per_2_sec_continuous_video_view"') as COST_PER_2_SEC_CONTINUOUS_VIDEO_VIEW,
        to_varchar(get_path(parse_json(_airbyte_data), '"estimated_ad_recall_rate_lower_bound"')) as ESTIMATED_AD_RECALL_RATE_LOWER_BOUND,
        to_varchar(get_path(parse_json(_airbyte_data), '"estimated_ad_recall_rate_upper_bound"')) as ESTIMATED_AD_RECALL_RATE_UPPER_BOUND,
        get_path(parse_json(_airbyte_data), '"video_play_retention_0_to_15s_actions"') as VIDEO_PLAY_RETENTION_0_TO_15S_ACTIONS,
        get_path(parse_json(_airbyte_data), '"video_continuous_2_sec_watched_actions"') as VIDEO_CONTINUOUS_2_SEC_WATCHED_ACTIONS,
        get_path(parse_json(_airbyte_data), '"video_play_retention_20_to_60s_actions"') as VIDEO_PLAY_RETENTION_20_TO_60S_ACTIONS,
        to_varchar(get_path(parse_json(_airbyte_data), '"qualifying_question_qualify_answer_rate"')) as QUALIFYING_QUESTION_QUALIFY_ANSWER_RATE,
        get_path(parse_json(_airbyte_data), '"catalog_segment_value_omni_purchase_roas"') as CATALOG_SEGMENT_VALUE_OMNI_PURCHASE_ROAS,
        get_path(parse_json(_airbyte_data), '"catalog_segment_value_mobile_purchase_roas"') as CATALOG_SEGMENT_VALUE_MOBILE_PURCHASE_ROAS,
        get_path(parse_json(_airbyte_data), '"catalog_segment_value_website_purchase_roas"') as CATALOG_SEGMENT_VALUE_WEBSITE_PURCHASE_ROAS,
        _AIRBYTE_AB_ID,
        _AIRBYTE_EMITTED_AT,
        convert_timezone('UTC', current_timestamp()) as _AIRBYTE_NORMALIZED_AT
    -- from "DEMO_DB".DESTSET._AIRBYTE_RAW_ADS_INSIGHTS 
    from _AIRBYTE_RAW_{{var('prefix')}}ADS_INSIGHTS 
    -- ADS_INSIGHTS
    where 1 = 1
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
