data1 <- read_csv("C:/Users/Harsh Yadav/Desktop/New folder/months_wrt_number_of_incidents.csv")

library(plyr)
data1$month1 <- mapvalues(data1$month,
                          from = c(1,2,3,4,5,6,7,8,9,10,11,12),
                          to = c("January", "February", "March", "April", "May", "June", "July", "August", 
                                 "September", "October", "November", "December"))


data1 <- data1[with(data1, order(month)), ]

library(highcharter)

highchart() %>% 
  hc_chart(type = "column") %>% 
  hc_title(text = "Number of Incidents by Months") %>% 
  hc_xAxis(categories = data1$month1) %>% 
  hc_add_series(data = data1$Number_of_Incidents,color = "#B71C1C",
                name = "Number of Incidents in Thousands")