#' vector 1

if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               sf,
               mapview)
rm(list = ls())

#read and export---------------------------------------
## how to read vector data

sf_nc_county <- st_read(ds = "data/nc.shp",
        quiet = TRUE)
## how to export 
st_write(sf_nc_county,
         dsn = "data/sf_nc_county.shp",
         append = FALSE)
## RDS format
saveRDS(sf_nc_county,
        file = "data/sf_nc_county.rds")

sf_nc_county <- readRDS(file = "data/sf_nc_county.rds")

# point -----------------------------------------------

#read point vector data 
sf_site <- readRDS("data/sf_finsync_nc.rds")

#visualize
mapview(
  sf_site,
  col.regions = "black", #points fill color
  lengend = FALSE
)

#select the first 10 sites
sf_site_f10 <- sf_site %>% 
  slice(1:10)

mapview(
  sf_site_f10,
  col.regions = "blue",
  legend = FALSE)

#line---------------------------------------------------

sf_str <- readRDS("data/sf_stream_gi.rds")
sf_str


mapview(
  sf_str,
  color = "steelblue",
  legend = FALSE
)

#polygon-------------------------------------------------

sf_nc_county <- readRDS("data/sf_nc_county.rds")
sf_nc_county

mapview(
  sf_nc_county,
  col.regions = "green",
  legend = FALSE
)

## select "guilford" county, then map

sf_nc_gi <- sf_nc_county %>% 
  filter(county == "guilford")

mapview(
  sf_nc_gi,
  col.regions = "orange",
  legend = FALSE
)


#static --------------------------------------------------

# section label is crtl+shift+R -------------------------------------------


ggplot() +
  geom_sf(data = sf_nc_county)

ggplot() +
  geom_sf(data = sf_nc_county) +
  geom_sf(data = sf_str)

ggplot() +
  geom_sf(data = sf_nc_county) +
  geom_sf(data = sf_str) +
  geom_sf(data = sf_site)


# Exercise 3.2.7 ----------------------------------------------------------

#Q1
sf_str_as <- readRDS(file = "data/sf_stream_as.rds")

#Q2
sf_str_as
sf_nc_county

#does have the same CRS

#Q3

ggplot() +
  geom_sf(data = sf_nc_county) +
  geom_sf(data = sf_str_as)

#Q4

sf_nc_as <- sf_nc_county %>% 
  filter(county == "ashe")
  
ggplot() +
  geom_sf(data = sf_nc_as) +
  geom_sf(data = sf_str_as)