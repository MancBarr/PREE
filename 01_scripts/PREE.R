## 2023/09/09
## Andres Mancera Barreto

## Script for the PREE assignment

library(tidyverse)
library(palmerpenguins)

## Data
view(penguins)
view(penguins_raw)

## Writing Data set
write_csv(penguins,"./00_rawdata/penguins.csv")
write_csv(penguins_raw,"./00_rawdata/penguins_raw.csv")
