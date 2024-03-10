## code to prepare `lima_data` dataset goes here
library(sf)
library(tidyverse)

lima_covid_orig <- read_csv(url("https://zenodo.org/record/4915889/files/covid19data.csv?download=1"))

# on peut enlever "FECHA_CORTE", et "UUID", PROVINCIA, DEPARTAMENTO, METODODX
# et transforme en facteur les variables SEXO, 
# et ne garder que les données de la première année
lima_covid <- lima_covid_orig |>
  select(-c(FECHA_CORTE, UUID, PROVINCIA, DEPARTAMENTO, METODODX, rango_edad)) |>
  filter(FECHA_RESULTADO <= "2020-12-31") 
lima_covid$SEXO <- factor(lima_covid$SEXO, levels = c("MASCULINO", "FEMENINO"), labels = c("Homme", "Femme"))
lima_covid$DISTRITO <- as.factor(lima_covid$DISTRITO)
#lima_covid$rango_edad <- as.factor(lima_covid$rango_edad)
colnames(lima_covid) = c("DISTRICT", "AGE", "SEXE", "DATE_RESULTAT", "lon", "lat")
# library(data.table)
# lima_covid_orig_dt = fread("https://zenodo.org/record/4915889/files/covid19data.csv?download=1")
# 
# lima_covid = lima_covid_orig_dt[FECHA_RESULTADO <= "2020-12-31",]
# 
# lima_covid[, ':='(FECHA_CORTE=NULL, 
#                    SEXO = factor(SEXO, levels = c("MASCULINO", "FEMENINO"), labels = c("M", "F")), 
#                    rango_edad = as.factor(rango_edad),
#                    DISTRITO = as.factor(DISTRITO), 
#                    METODODX=NULL, 
#                    DEPARTAMENTO=NULL, 
#                    PROVINCIA=NULL, 
#                    UUID=NULL)]

peru <- geodata::gadm("peru", path = ".", level = 3) 

lima_sf <- peru |>
  st_as_sf() |>
  # Nous filtrons les données spatiales uniquement de la métropole de Lima
  filter(NAME_2 == "Lima") 

usethis::use_data(lima_covid, overwrite = TRUE)
usethis::use_data(lima_sf, overwrite = TRUE)
