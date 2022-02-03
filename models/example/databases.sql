{{ config(
            materialized='table',
                post_hook={
                    "sql": "Create or replace TABLE SUPERBOTTOMS_DB.PUBLIC.Marketing_Consolidated as select "ad_group.name" as "Ad_Group_Name","ad_group_ad.ad.id" as "AD_ID","ad_group_ad.ad.final_urls" as "Ad_URLs", "campaign.name" as "Campaign_Name", "campaign.id" as "Campaign_ID","segments.date" as "Date", "campaign.status" as "Campaign_Status", "ad_group_ad.ad.type" as "Ad_Type", "ad_group_ad.ad_strength" as "Ad_Strength", "segments.ad_network_type" as "Ad_Network_Type" ,Year("segments.date") as "Year" ,Month("segments.date") as "Month" ,"segments.day_of_week" as "Day of Week" ,SUM("metrics.clicks") as Clicks ,SUM("metrics.cost_micros")/1000000 Spend,SUM("metrics.impressions") as Impressions ,SUM("metrics.conversions") Conversions,SUM("metrics.conversions_value") as Conversion_Value ,'Google Ads' as Channel from SUPERBOTTOMS_DB.PUBLIC.GADS_SB_AD_GROUP_AD_REPORT group by "ad_group.name","ad_group_ad.ad.id", "ad_group_ad.ad.final_urls" ,"segments.date","campaign.name", "campaign.id", "segments.day_of_week", "campaign.status", "ad_group_ad.ad.type", "ad_group_ad.ad_strength", "segments.ad_network_type"",
                    "transaction": true
                }
            ) }}
            with sample_data as (

                select * from superbottoms_db.information_schema.databases
            ),
            
            final as (
                select * from sample_data
            )
            select * from final
            