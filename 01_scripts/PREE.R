## 2023/09/09
## Andres Mancera Barreto

## Script for the PREE assignment

## Mainly focused in moving the data from one of the packages available in R. We will be using 
## the 'palmerpenguins' package.

## To do the data movement we will need the following packages:

library(tidyverse)
library(palmerpenguins)
library(tidyverse)
library(skimr)
library(knitr)
library(janitor)

## First we will see the data available in the 'palmerpenguins' package

view(penguins)
view(penguins_raw)

## Now we'll wite the dataset and added it to the environment:

write_csv(penguins,"./00_rawdata/penguins.csv")
write_csv(penguins_raw,"./00_rawdata/penguins_raw.csv")

## We will now call the data so that we are able to work with it

pinwings <- read_csv("./00_rawdata/penguins.csv")

## We will also create a table of frequencies and stored in the tidy data
## directory

spp.table <- pinwings %>%   #Creates the table base on the df
  count(species, sort = TRUE) %>%    #counting the frequency of a spp.
  mutate(relative_frequency = n / sum(n)) %>%   #calculating the frequency.
  adorn_totals()

write_csv(spp.table,"./02_tidydata/spp.table.csv")

## Let's create a bar graph to see the frequency at which each spp. is present 
## in the dataset. 

ggplot(data = spp.table,    #Using ggplot we will use the data in spp.table
       aes(x = reorder(species, n),  #to see the number of counts per 
           y = n)) +                 #species
  geom_bar(stat = "identity") +    #in a barplot that use the counts
  ylab("Frequency") +     #and labeling the plots accordingly
  xlab("species") +
  theme_classic()

## Now, I am not very smart, so I save the plot in the directory labelled 
## "03_figures" using the "Export" option in the "Plots" viewer and saving it 
## as an image named "frequency_bar"

## Now we will clean the data to include the information about the islands

pinwing.tidy <- pinwings %>%  #We'll create a new df based on the info from pinwings
  group_by(island) %>%  #grouped by the islands surveyed
  count(species)  #summarizing by the species

## and we will stored in the tidydata directory

write_csv(pinwing.tidy,"./02_tidydata/pinwing.tidy.csv")

## Now we will plot the relationship between both categories

ggplot(data = pinwing.tidy,    #uses the tidy data created above
       aes(x = island, y = n,  #orders the axis.
           fill = species)) +  #colors the bars based on the spp.
  geom_bar(stat = "identity",  #creates the bar plot.
           position = position_dodge()) +   #creates an space betwwen island bars
  ylab("Frequency") +   #name x axis
  xlab("Species") +     #name y axis
  theme_classic()       #plot style

## Now, I am still not very smart, so I save the plot in the directory labelled 
## "03_figures" using the "Export" option in the "Plots" viewer and saving it 
## as an image named "island-penguin"

## On to the analyses

## Table time

wing.table <- pinwings %>%
  tabyl(island, species) %>%
  adorn_totals(where = c("row", "col"))
wing.table

## We will save this table in the "figures" directory as it is part of the results

write_csv(wing.table,"./03_figures/wing.table.csv")

## and we will visualize it better:

kable(wing.table) #We will copy and paste this into the manuscript as a result.

## Table should look something like this: 

##  |island    | Adelie| Chinstrap| Gentoo| Total|
##  |:---------|------:|---------:|------:|-----:|
##  |Biscoe    |     44|         0|    124|   168|
##  |Dream     |     56|        68|      0|   124|
##  |Torgersen |     52|         0|      0|    52|
## |Total     |    152|        68|    124|   344|

## Conducting a chi squared test for the hypothesis:

wings.chisq.results <- pinwings %>%  #We'll stored the results in an object
  tabyl(island, species) %>%   #and make a table using island and spp. 
                                #as row and column names
  janitor::chisq.test()        #and run the chi squared test

wings.chisq.results  #and see the results

kable(wings.chisq.results$expected) #lastly calling the table to ensure we have                                     #not violated assumptions which we did not.

## Table should look like this:

##  |          |island    |   Adelie| Chinstrap|   Gentoo|
##  |:---------|:---------|--------:|---------:|--------:|
##  |Biscoe    |Biscoe    | 74.23256|  33.20930| 60.55814|
##  |Dream     |Dream     | 54.79070|  24.51163| 44.69767|
##  |Torgersen |Torgersen | 22.97674|  10.27907| 18.74419|
  
## So assumptions not violated

## FIN

