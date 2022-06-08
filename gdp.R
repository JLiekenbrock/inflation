library(countrycode)
library(readxl)


gdp_b419 <- read_excel("API_NY.GDP.MKTP.CD_DS2_en_excel_v2_4150762.xls",sheet="Data",skip=2)

gdp_b419 = gdp_b419%>%
  pivot_longer(
    !c(1:4),names_to="Year"
  )

meta_2019 <- read_excel("API_NY.GDP.MKTP.CD_DS2_en_excel_v2_4150762.xls",sheet="Metadata - Countries")

gdp_after19 = read_excel("GEP-June-2022-Table-1-1.xlsx",skip=3)

colnames(gdp_after19[1:5]) = c("World","Group","Region","Countries","")

names(gdp_after19[1:5]) 

gdp = read.csv("DP_LIVE_08062022130756606.csv")

gdp = gdp%>%
  mutate(country = countrycode(sourcevar = .$LOCATION,
                              origin = "iso3c",
                              destination = "iso3c"))%>%
  filter(!is.na(country))
  
countrylist = gdp%>%filter(TIME == max(TIME,na.rm=T))%>%
  slice_max(n=10,order_by=Value)%>%
  pull(LOCATION)

gdp%>%
  filter LOCATION %in% 
      filter(
        TIME == max(TIME,na.rm=T))%>%
        slice_max(n=10,order_by=Value)%>%
        pull(LOCATION)
    )
  )


gdp%>%
  filter()


