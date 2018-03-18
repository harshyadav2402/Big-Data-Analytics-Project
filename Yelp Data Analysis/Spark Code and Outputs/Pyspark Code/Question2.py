%spark.pyspark
import pyspark
%pyspark
df=spark.read.json("/shared/d/business.json")

a = df.withColumn("category", explode(col("categories")))
a.groupBy("city").pivot("category").avg("stars").show()
