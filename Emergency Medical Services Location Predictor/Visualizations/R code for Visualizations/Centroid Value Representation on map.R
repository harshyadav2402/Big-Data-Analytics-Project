data1 <- read_csv("C:/Users/Harsh Yadav/Desktop/New folder/10003_Fire_Incident_Dispatch_Data_2016_with_coordinates.csv")

library(tigris)
library(dplyr)
library(leaflet)
library(sp)
library(ggmap)
library(maptools)
library(broom)
library(httr)
library(rgdal)


r <- GET('http://data.beta.nyc//dataset/0ff93d2d-90ba-457c-9f7e-39e47bf2ac5f/resource/35dd04fb-81b3-479b-a074-a27a37888ce7/download/d085e2f8d0b54d4590b1e7d1f35594c1pediacitiesnycneighborhoods.geojson')
nyc_neighborhoods <- readOGR(content(r,'text'), 'OGRGeoJSON', verbose = F)


leaflet() %>%
  addTiles() %>% 
  #addPolygons(popup = ~neighborhood) %>% 
  addCircleMarkers(~LONGITUDE, ~LATITUDE,radius = 5, color = 'red', data = data1) %>%
  addMarkers(lng=-73.98648355, lat=40.73275403) %>%
  addMarkers(lng=-73.99254326, lat=40.73149193) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(-73.99, 40.733, zoom = 15)
