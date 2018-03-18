A = LOAD 'business.json' USING com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') AS (json:map []);

B = FOREACH A GENERATE FLATTEN(json#'categories') as categories, json#'attributes'#'RestaurantsTakeOut' as attribute, (float)json#'stars' as stars;
C = FILTER B BY attribute matches '.*true.*';
D = FILTER C BY categories matches 'Mexican';
E = GROUP D BY (categories);
F = FOREACH E GENERATE group, AVG(D.stars) as avg_stars;
store F into './answer3.out';