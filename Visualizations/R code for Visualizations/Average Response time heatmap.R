data1 <- read_csv("C:/Users/Harsh Yadav/Desktop/New folder/Avg_RT_wrt_Zipcodes_2016.csv")

data(zipcode)
data1$ZIPCODE<- clean.zipcodes(data1$ZIPCODE)
data1<- merge(data1, zipcode, by.x='ZIPCODE', by.y='zip')


library(ggmap)

# load the data
#tartu_housing <- read.csv("data/tartu_housing_xy_wgs84_a.csv", sep = ";")

# Download the base map
tartu_map_g_str <- get_map(location = "new york city", zoom = 10.5)
# Draw the heat map
ggmap(tartu_map_g_str, extent = "device") + geom_density2d(data = data1, aes(x = longitude, y = latitude, group = avg_response_time), size = 0.3) + 
  stat_density2d(data = data1, 
                 aes(x = longitude, y = latitude, fill = avg_response_time, alpha = 0.5), size = 0.01, 
                 bins = 16, geom = "polygon") + scale_alpha(range = c(0, 0.3), guide = FALSE)