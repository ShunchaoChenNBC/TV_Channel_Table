
create or replace table `nbcu-ds-sandbox-a-001.Shunchao_Sandbox.TV_Channels` as

select 
a.adobe_date,
a.Hour,
a.adobe_tracking_id,
lower(a.Channels) as Channels,
round(sum(a.num_seconds_played_no_ads)/3600,2) as Watch_Hours, -- 0.01 intervel
round(sum(a.num_seconds_played_no_ads)/60,2) as Watch_Minutes -- add minute column for 5 minute cutoff
from
(SELECT 
adobe_date,
EXTRACT(HOUR FROM adobe_timestamp) as Hour,
adobe_tracking_id,
case when consumption_type = 'Virtual Channel' then display_name
	         else playlist_name end as Channels,
num_seconds_played_no_ads 
FROM `nbcu-ds-prod-001.PeacockDataMartSilver.SILVER_VIDEO` 
WHERE adobe_date between "2022-11-01" and "2023-03-08"
and num_seconds_played_no_ads > 0) a
where 1=1
and (lower(Channels) LIKE "%-tv%" or Channels like "% | %" or length(Channels) = 4 or (regexp_contains(Channels, r"\w{4}-\w{2}") and length(Channels) <= 7)) 
and lower(Channels) not in ("kane","edge","omos","otis","cnbc","news","imsa","bige","golf")
group by 1,2,3,4



