A = LOAD 'business.json' USING com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') AS (json1:map []);

B = FOREACH A GENERATE json1#'business_id' as businessid, FLATTEN(json1#'categories') as categories, (float)json1#'stars' as stars, (int)json1#'review_count' as review_count, (float)json1#'latitude' as latitude, (float)json1#'longitude' as longitude;

C = FILTER B BY latitude<43.7889 AND latitude>43.5182 AND longitude< -79.1971 AND longitude> -79.5694;

D = FILTER C BY categories matches 'Food';

E = ORDER D BY stars DESC;

TOP = LIMIT E 10;

F = ORDER D BY stars ASC;

BOTTOM = LIMIT F 10;

G = LOAD 'review.json' USING com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') AS (json2:map []);

H = FOREACH G GENERATE json2#'business_id' as businessid, (float)json2#'stars' as stars, json2#'date' as date;

TOP_REVIEW = JOIN H BY businessid, TOP BY businessid;

data1 = FOREACH TOP_REVIEW GENERATE (INT)SUBSTRING (H::date, 5,7) as dateint, H::businessid as businessid, H::stars as stars;

TOP_MONTH = FILTER data1 BY dateint >= 1 AND  dateint < 6;

store TOP_MONTH into './answer5_top.out';

BOTTOM_REVIEW = JOIN H BY businessid, BOTTOM BY businessid;

data2 = FOREACH BOTTOM_REVIEW GENERATE (INT)SUBSTRING (H::date, 5,7) as dateint, H::businessid as businessid, H::stars as stars;

BOTTOM_MONTH = FILTER data2 BY dateint < 6;

store BOTTOM_MONTH into './answer5_bottom.out';