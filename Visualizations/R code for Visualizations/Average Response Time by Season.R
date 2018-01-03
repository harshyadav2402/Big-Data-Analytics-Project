data1 <- read_csv("C:/Users/Harsh Yadav/Desktop/New folder/seasons_wrt_avg_response_time_on_complete_data.csv")
library(highcharter)

data1 <- data1[with(data1, order(Resp_Time)), ]

highchart() %>% 
  hc_chart(type = "column") %>% 
  hc_title(text = "Average Response Time By Season") %>% 
  hc_xAxis(categories = data1$season) %>% 
  hc_add_series(data = data1$Resp_Time,color = "#ADFF2F",
                name = "Response Time in Seconds")
