%spark.pyspark
import pyspark
%pyspark
df=spark.read.json("/shared/d/business.json")
from pyspark.sql.functions import split, explode, col
d = df.withColumn("category", explode(col("categories")))
d.createOrReplaceTempView("table4")
aa=spark.sql("select business_id,latitude, longitude, category, stars, review_count from table4")

from pyspark.sql.functions import *
import math
from math import radians, cos, sin, asin, sqrt, atan2, pi
from pyspark.sql.types import *

aa2=aa.withColumn('latitude_r', (aa.latitude*pi)/180)
aa3=aa2.withColumn('longitude_r', (aa.longitude*pi)/180)

lat_tor=((43.6532)*pi/180)
lon_tor=((-79.3832)*pi/180)

aa3.createOrReplaceTempView("table111")
aa4=spark.sql("SELECT * FROM table111 WHERE acos(sin(0.7618921) * sin(latitude_r) + cos(0.7618921) * cos(latitude_r) * cos(longitude_r - (-1.3855))) * 6371 <= 15")

aa4.createOrReplaceTempView("table5")
aa5=spark.sql("select * from table5 where category=='Food'")

aa5.createOrReplaceTempView("table7")
df4=spark.sql("select * from table7 order by stars asc limit 10")
df5=spark.sql("select * from table7 order by stars desc limit 10")
df1=spark.read.json("/shared/d/review.json")

df1 = df1.alias('df1')
df2 = df4.alias('df2')
df3 = df5.alias('df3')

dff1=df1.join(df2, "business_id")
dff2=df1.join(df3, "business_id")

dfff1=dff1.withColumn('month', concat(dff1.date.substr(6,2)))
dfff2=dff2.withColumn('month', concat(dff2.date.substr(6,2)))

dfff1=dfff1.withColumn("month", dfff1["month"].cast(IntegerType()))
dfff2=dfff2.withColumn("month", dfff2["month"].cast(IntegerType()))

dfff1.createOrReplaceTempView("table8")
#Top 10 businesses
dfff3=spark.sql("select * from table8 where month<=6")
dfff3.show()

dfff2.createOrReplaceTempView("table9")
dfff4=spark.sql("select * from table9 where month<=6")
#For bottom 10 businesses
dfff4.show()
