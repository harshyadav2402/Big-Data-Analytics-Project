A = LOAD 'business.json' USING com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') AS (json:map []);
B = FOREACH A GENERATE FLATTEN(json#'categories') as categories, (float)json#'stars' as stars, (int)json#'review_count' as review_count, (float)json#'latitude' as latitude, (float)json#'longitude' as longitude;
C = FILTER B BY latitude<43.7889 AND latitude>43.5182 AND longitude< -79.1971 AND longitude> -79.5694;
category1 = GROUP C BY (categories);
D = FOREACH category1 GENERATE group, AVG(C.review_count), AVG(C.stars);
store D into './answer4.out';