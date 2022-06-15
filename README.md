# inflation

## Feedback 15.06.

Zusammenhang zwischen (zwei) Variablen animieren, ala Gapminder, evtl. auch in Shiny
- partial least squares (Leo)
- Merkmale auswählen
- neuer Tab zwei Merkmale gegeneinander darstellen

## Datenlage (idealerweise von Weltbank)
- Inflation (sehr gut) (monatlich)
- GDP (in Arbeit) (jährlich)
- Arbeitslosigkeitsrate
- M1/M2 Geldmenge

## TODO:
- Karte (interaktiv) mit Regionen (nach Weltbank) / Weltkarte (Jan) (Bsp region ändern)
- Daten zusammenfügen (china, indien...) (Jan)
- gdp animation für (top10)/region nach gdp(Dennis)
- weitere Datenquellen finden (Leo)
- Korrelationen betrachten

## weitere Ziele:
- Regressionsmodell

## Animation in R
https://plotly.com/ggplot2/animations/

### Racing bar charts
https://www.r-bloggers.com/2020/01/how-to-create-bar-race-animation-charts-in-r/

https://github.com/amrrs/animated_bar_charts_in_R

## data sources:

### outlook worldbank
https://www.worldbank.org/en/publication/global-economic-prospects
https://thedocs.worldbank.org/en/doc/18ad707266f7740bced755498ae0307a-0350012022/related/GEP-June-2022-Chapter-1-Charts-Data.zip

### gpd until 2020

https://data.worldbank.org/indicator/NY.GDP.MKTP.CD

https://api.worldbank.org/v2/en/indicator/NY.GDP.MKTP.CD?downloadformat=excel

### Inflation
https://www.worldbank.org/en/research/brief/inflation-database#:~:text=The%20World%20Bank%27s%20Prospects%20Group,consumer%20price%20index%20(CPI)%20inflation
