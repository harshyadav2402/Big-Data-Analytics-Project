%spark.pyspark
import pyspark
%pyspark
df=spark.read.json("/shared/d/business.json")

from pyspark.sql.functions import split, explode

b=df.select(df.attributes['RestaurantsTakeOut'].alias("Takeout"), df.business_id, explode(df.categories).alias("category"), df.stars)
b.createOrReplaceTempView("table2")

c=spark.sql("select avg(stars) from table2 where Takeout=true and category='Mexican'")
c.show()
