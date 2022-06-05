library(tidyr)
library(readxl)
library(readr)
library(dplyr)
library(ggplot2)
library(plotly)
library(countrycode)
library(ggthemes)
#library(dtwclust)

#data("uciCT")


#deflation <- read_excel("Inflation-data.xlsx",sheet="def_a")

inflation <- read_excel("Inflation-data.xlsx",sheet="ccpi_a")

data = inflation%>%
  pivot_longer(!c(1:5),names_to="Year",values_to="value")

data$region=countrycode(sourcevar = data$`Country Code`,
            origin = "wb",
            destination = "region")

data = data%>%
  mutate(`IMF Country Code` = as.character(`IMF Country Code`))%>%
  group_by(region,Year,`Indicator Type`)%>%
  summarise(value = median(value,na.rm=T))

data = data%>%
  mutate(Year = as.integer(Year))%>%
  filter(Year > 2000)

max(data$value,na.rm=T)
g = data%>%
  ggplot()+
    geom_rect(xmin=2007,xmax=2009,ymin=0,ymax=max(data$value,na.rm=T),fill="grey")+
    geom_rect(xmin=2010,xmax=2014,ymin=0,ymax=max(data$value,na.rm=T),fill="grey")+
    geom_rect(xmin=2020,xmax=2022,ymin=0,ymax=max(data$value,na.rm=T),fill="grey")+
    geom_hline(yintercept = 2,color="red",size=2)+
    geom_line(aes(Year,value,group=region,color=region),size=1)+
    annotate("rect",xmin=min(data$Year,na.rm=T),xmax=max(data$Year,na.rm=T),ymin=0,ymax=2,fill="grey",alpha=0.6)+
    scale_color_tableau()+
    theme_igray()


g
ggplotly(g)
