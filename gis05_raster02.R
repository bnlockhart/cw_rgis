if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               terra,
               tidyterra,
               mapview,
               stars)

# erase existig objects
rm(list = ls())



# precipitation example ---------------------------------------------------

(spr_prec <- rast("data/spr_prec_us.tif"))

ext(spr_prec)

ggplot() +
  geom_spatraster(data = spr_prec)

spr_prec_crop <- crop(x = spr_prec,
                      y = c(-80, -75, 34, 37))
     
##map of 
ggplot() +
  geom_spatraster(data = spr_prec_crop)

## get county polygon data
sf_nc_county <- readRDS("data/sf_nc_county.rds")

ggplot() +
  geom_spatraster(data = spr_prec_crop) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

## use polygon layer to crop raster
spr_prec_nc <- crop(x = spr_prec,
                    y = sf_nc_county)

##map spr_prec_nc with sf_nc_county
ggplot() +
  geom_spatraster(data = spr_prec_crop)+
  geom_sf(data = sf_nc_county,
          alpha = 0.25)


# merge -------------------------------------------------------------------

spr_nw <- rast("data/spr_prec_ncnw.tif") 
spr_ne <- rast("data/spr_prec_ncne.tif") 
spr_sw <- rast("data/spr_prec_ncsw.tif") 
spr_se <- rast("data/spr_prec_ncse.tif") 

ggplot() +
  geom_spatraster(data = spr_nw) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

## south west 
ggplot() +
  geom_spatraster(data = spr_sw) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

## merge() function to combin two panels, then map
spr_n <- merge(spr_nw, spr_ne)

ggplot() +
  geom_spatraster(data = spr_n) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25 )

## merge mre than two panels into one
list_spr <- list(spr_ne,
             spr_sw,
              spr_se,
              spr_nw)
## convert from list to spatraster collection
spr_col <- sprc(list_spr)

##merge more than two panels
spr_merge <- merge(spr_col)

ggplot() +
  geom_spatraster(data = spr_merge) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25,
          fill = "orange")

#export raster
writeRaster(spr_merge,
            "data/Spr_prec_nc.tif",
            overwrite = TRUE)

# stack -------------------------------------------------------------------

spr_prec_nc <- rast("data/spr_prec_nc.tif")
spr_tmp_nc <- rast("data/spr_tmp_nc.tif")

ggplot() +
  geom_spatraster(data = spr_tmp_nc) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)
##create a multi_layered raster ("stack")
spr_pt_nc <- c(spr_prec_nc,
               spr_tmp_nc)

##access one layer
## - precipitation
spr_pt_nc$precipitation 

##- temprature 
spr_pt_nc$temperature

##try to stack spr_ne and spr_tmp_nc
# c(spr_ne, spr_tmp_nc)
# this would not work because of spatial extent mismatch


# reprojection ------------------------------------------------------------

#reprojection - transform CRS from one to another
# most cases, from geodetic to projected CRS

spr_prec_nc_proj <- project(x = spr_prec_nc,
        y = "EPSG:32617") # 32617 UTM zone 17N



# Exercise ----------------------------------------------------------------

#1 

Northwest <- rast("data/spr_tmp_ncnw.tif")
Northeast <- rast("data/spr_tmp_ncne.tif")
Southwest <- rast("data/spr_tmp_ncsw.tif")
southeast <- rast("data/spr_tmp_ncse.tif")

List_DI <- list(Northwest,
                Northeast,
                Southwest,
                southeast)
compass <- sprc(List_DI)

spr_merge <- merge(compass)

ggplot() +
  geom_spatraster(data = spr_merge) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25,
          fill = "purple")

#2
sf_camden <- sf_nc_county %>% 
  filter(county == "camden")

ext(sf_camden)

spr_tmp_camden <- crop(x = spr_merge,
                      y = sf_camden)

ggplot() +
  geom_spatraster(data = spr_tmp_camden) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)
#3

print(spr_tmp_camden)

spr_tmp_camden_proj <- project(x = spr_tmp_camden,
                             y = "EPSG:32618",
                             method = "bilinear")
