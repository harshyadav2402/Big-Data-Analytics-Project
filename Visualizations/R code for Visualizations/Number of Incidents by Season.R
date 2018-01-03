
data1 <- read_csv("C:/Users/Harsh Yadav/Desktop/New folder/seasons_wrt_number_of_incidents_on_complete_data.csv")
library(highcharter)

data1 <- data1[with(data1, order(Number_of_Incidents)), ]

highchart() %>% 
  hc_chart(type = "column") %>% 
  hc_title(text = "Number of Incidents By Season") %>% 
  hc_xAxis(categories = data1$season) %>% 
  hc_add_series(data = data1$Number_of_Incidents,color = "#7B68EE",
                name = "Number of Incidents in Thousands")
