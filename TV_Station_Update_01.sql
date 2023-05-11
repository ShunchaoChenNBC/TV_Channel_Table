-- replace kntv by kntv(kicu)
-- replace kxas by kxas-tv
--replace wbts by wbts-ld
--replace wmaq by wmaq-tv
--remove reba

create or replace table `nbcu-ds-sandbox-a-001.Shunchao_Sandbox.TV_Channels` as

with cte as (select adobe_date,
Start_Hour,
adobe_tracking_id,
REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(lower(Channels), r"^kntv.*","__TEMP1__"),r"^kxas.*","__TEMP2__"),r"^wbts.*","__TEMP3__"),r"^wmaq.*","__TEMP4__") as Channels
from `nbcu-ds-sandbox-a-001.Shunchao_Sandbox.TV_Channels`)


select adobe_date,
Start_Hour,
adobe_tracking_id,
REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(Channels, r"__TEMP1__","kntv (kicu)"),r"__TEMP2__","kxas-tv"),r"__TEMP3__","wbts-ld"),r"__TEMP4__","wmaq-tv") as Channels
from cte
where lower(Channels) not like "%reba%"
