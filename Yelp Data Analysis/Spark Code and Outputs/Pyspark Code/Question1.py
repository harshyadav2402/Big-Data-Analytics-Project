%spark.pyspark
import pyspark
%pyspark
df=spark.read.json("/shared/d/business.json")

#First method, by not exploding the categories
df1 = df.groupBy("city","categories").agg(avg("review_count"), avg("stars"))
df1.show()

#Second method, by exploding categories and then grouping
a = df.withColumn("category", explode(col("categories")))
a.groupBy("city","category").agg(avg("review_count"), avg("stars")).show()
