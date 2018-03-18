register elephant-bird-hadoop-compat-4.1.jar
register elephant-bird-pig-4.1.jar
register json-simple-1.1.1.jar


A = LOAD 'business.json' USING com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') AS (json:map []);

B = FOREACH A GENERATE (int)json#'review_count' AS review_count, (float)json#'stars' AS stars, json#'city' as city, FLATTEN(json#'categories') AS categories;

C = GROUP B BY (city,categories); 

D = FOREACH C GENERATE group.city as city, group.categories as category,AVG(B.review_count) AS reviewCount, AVG(B.stars) AS stars;

STORE D INTO './answer1.out';