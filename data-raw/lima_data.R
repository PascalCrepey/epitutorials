## code to prepare `lima_data` dataset goes here
library(sf)
library(tidyverse)

lima_covid <- read_csv(url("https://zenodo.org/record/4915889/files/covid19data.csv?download=1"))


peru <- geodata::gadm("peru", path = ".", level = 3) 

lima_sf <- peru |>
  st_as_sf() |>
  # Nous filtrons les données spatiales uniquement de la métropole de Lima
  filter(NAME_2 == "Lima") 

usethis::use_data(lima_covid, overwrite = TRUE)
usethis::use_data(lima_sf, overwrite = TRUE)
