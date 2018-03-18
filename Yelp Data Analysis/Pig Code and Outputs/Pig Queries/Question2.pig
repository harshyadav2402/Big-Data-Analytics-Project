A = LOAD 'business.json' USING com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') AS (json:map []);

B = FOREACH A GENERATE (int)json#'review_count' AS review_count, (float)json#'stars' AS stars, json#'city' as city, FLATTEN(json#'categories') AS categories;

C = GROUP B BY city;

D = FOREACH C GENERATE group, (B.categories) AS categories, AVG(B.stars) AS stars;
store D into './answer2.out';