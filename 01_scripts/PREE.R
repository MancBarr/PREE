## 2023/09/09
## Andres Mancera Barreto

## Script for the PREE assignment

## Mainly focused in moving the data from one of the packages available in R. We will be using 
## the 'palmerpenguins' package.

## To do the data movement we will need the following packages:

library(tidyverse)
library(palmerpenguins)

## First we will see the data available in the 'palmerpenguins' package

view(penguins)
view(penguins_raw)

## Now we'll wite the dataset and added it to the environment:

penguins <- write_csv(penguins,"./00_rawdata/penguins.csv")
write_csv(penguins_raw,"./00_rawdata/penguins_raw.csv")

