create or replace table `nbcu-ds-sandbox-a-001.Shunchao_Sandbox.TV_Channels` as

SELECT 
adobe_date,
EXTRACT(HOUR FROM adobe_timestamp) as Hours,
adobe_tracking_id,
regexp_replace(lower(content_channel), r"[:,.&'!]", '') as Channels,
round(avg(num_seconds_played_no_ads)/3600,2) as AVG_Watch_Hours
FROM `nbcu-ds-prod-001.PeacockDataMartSilver.SILVER_VIDEO` 
WHERE 1=1
and adobe_date between "2023-02-01" and "2023-02-16"
and content_channel != "N/A"
and num_seconds_played_no_ads > 0 
and regexp_replace(lower(content_channel), r"[:,.&'!]", '') not like "%channel%"
and regexp_replace(lower(content_channel), r"[:,.&'!]", '') not like "%premium%"
and content_channel like "% | %" or length(content_channel) = 4 or (regexp_contains(content_channel, r"\w{4}-\w{2}") and length(content_channel) <= 7)
group by 1,2,3,4
order by 1 desc,2

