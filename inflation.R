library(tidyr)
library(readxl)
library(readr)
library(dplyr)
library(ggplot2)
library(plotly)
library(countrycode)
library(ggthemes)
#library(dtwclust)
library(zoo)
library(purrr)
library(broom)


#data("uciCT")

#deflation <- read_excel("Inflation-data.xlsx",sheet="def_a")

inflation <- read_excel("Inflation-data.xlsx",sheet="ccpi_a")

gdp = read_csv("gdp.csv")%>%
  mutate(region = countrycode(sourcevar = .$LOCATION,
              origin = "iso3c",
              destination = "region"))%>%
  filter(FREQUENCY=="Q")%>%
  mutate(date = as.yearqtr(TIME,format = "%Y-Q%q"))%>%
  group_by(region,date)%>%
  summarise(value=median(Value,na.rm=T))%>%
  filter(date > as.yearqtr("2006-Q1",format = "%Y-Q%q"))%>%
  group_by(region)%>%
  mutate(rez = value<0)%>%
  mutate(recession = rez+lag(rez,1) > 1 )

loess = gdp %>% 
  nest(data = -region) %>% 
  mutate(
    test = map(data, ~ loess(.$value~as.numeric(.$date), span = 0.2)), # S3 list-col
    tidied = map(test, augment,se.fit=T
    )
  ) %>% 
  unnest(tidied,data)

g = ggplot()+
  geom_line(loess,mapping=aes(date,`.fitted`,group=region,colour=recession),size=1)+
  #geom_smooth(gdp,mapping=aes(date,value,group=region,colour=recession),span=.2)+
  scale_color_tableau()+
  theme_igray()+
  facet_wrap(~region)
g

ggsave("gdp.png",width=12,height=12)
ggplotly(g)

inflation <- read_excel("Inflation-data.xlsx",sheet="ccpi_m")

data = inflation%>%
  pivot_longer(!c(1:5),names_to="Year",values_to="value")

data = data%>%
  group_by(Country)%>%
  mutate(date = as.Date(Year, format = "%Y%M"))%>%
  mutate(value = (value/lag(value,12)-1)*100)%>%
  ungroup()

data$region=countrycode(sourcevar = data$`Country Code`,
            origin = "wb",
            destination = "region")

data = data%>%
  mutate(`IMF Country Code` = as.character(`IMF Country Code`))%>%
  group_by(region,date,`Indicator Type`)%>%
  summarise(value = median(value,na.rm=T))

data = data%>%
  #mutate(Year = as.integer(Year))%>%
  filter(date > as.Date("2005",format="%Y"))
  # rowwise()%>%
  # mutate(value = pmin(value,10))

max(data$value,na.rm=T)

g = data%>%
  ggplot()+
    geom_rect(xmin=as.Date("2007",format="%Y"),xmax=as.Date("2009",format="%Y"),ymin=0,ymax=max(data$value,na.rm=T),fill="grey")+
    geom_rect(xmin=as.Date("2010",format="%Y"),xmax=as.Date("2014",format="%Y"),ymin=0,ymax=max(data$value,na.rm=T),fill="grey")+
    geom_rect(xmin=as.Date("2020",format="%Y"),xmax=as.Date("2022",format="%Y"),ymin=0,ymax=max(data$value,na.rm=T),fill="grey")+
    geom_label(x= as.Date("2008",format="%Y"), y = 10,label="financial crisis")+
    geom_label(x= as.Date("2012",format="%Y"), y = 10,label="European debt crisic")+
    geom_label(x= as.Date("2021",format="%Y"), y = 10,label="Covid-19")+
    geom_hline(yintercept = 2,color="red",size=2)+
    geom_smooth(aes(date,value,group=region,color=region),size=1,span=.3)+
    #annotate("rect",xmin=min(data$Year,na.rm=T),xmax=max(data$Year,na.rm=T),ymin=0,ymax=2,fill="grey",alpha=0.6)+
    scale_color_tableau()+
    theme_igray()

g

ggsave("inflation.png",height=12,width=12)
ggplotly(g)
