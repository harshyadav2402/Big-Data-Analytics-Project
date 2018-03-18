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

aa5=spark.sql("select category, avg(stars), avg(review_count) from table5 group by category")
aa5.show()