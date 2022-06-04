library(tidyr)
library(readxl)
library(readr)
library(dplyr)
library(ggplot2)
library(plotly)

deflation <- read_excel("Inflation-data.xlsx",sheet="def_a")

inflation <- read_excel("Inflation-data.xlsx",sheet="ccpi_a")

data = deflation%>%
  bind_rows(inflation)

data = data%>%
  filter(Country %in% c("Germany","China","Russian Federation","Ukraine","Republic of Korea","United States"))%>%
  mutate(`IMF Country Code` = as.character(`IMF Country Code`))

data = data%>%
  pivot_longer(!c(1:5),names_to="Year",values_to="value")%>%
  mutate(Year = as.integer(Year))%>%
  filter(Year > 2000)

g = data%>%
  ggplot()+
    geom_line(aes(Year,value,group=`Country Code`,color=Country))+
    theme(legend.position="none")+
    facet_wrap(~`Indicator Type`)

g
ggplotly(g)
