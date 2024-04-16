---
title: "Untitled"
author: "Juliano Palacios Abrantes"
date: "2024-04-09"
output: 
  pdf_document: 
    toc: yes
    keep_md: yes
---

# Script objective

This script extract the different data sources for straddling stocks identification and shifts for the West Africa region. In short this script follows these 4 steps:

1.- Define spatial boundaries for "West Africa"

2.- Extract transboundary species for the region from [Palacios-Abrantes et al., (2020)](https://www.nature.com/articles/s41598-020-74644-2)

3.- Extract shifts in these species' transboundary stocks according to [Palacios-Abrantes et al., 2022](https://onlinelibrary.wiley.com/doi/10.1111/gcb.16058)

4.- Extract shifts in these species' straddling stocks according to [Palacios-Abrantes et al., in prep]()




# 1.- Set spatial boundaries

## NOTES

- Western Sahara region is allocated to Morocco's as "South EEZ"
- Do we include the Canary Islands (Spain), Madeira Isl. (Portugal), and Cape Verde?


```
## Reading layer `SAUEEZ_July2015' from data source 
##   `/Users/jepa88/Library/CloudStorage/OneDrive-UBC/Data/Spatial/SAU/SAU_Shapefile/SAUEEZ_July2015.shp' 
##   using driver `ESRI Shapefile'
## Simple feature collection with 280 features and 7 fields
## Geometry type: MULTIPOLYGON
## Dimension:     XY
## Bounding box:  xmin: -180 ymin: -63.66443 xmax: 180 ymax: 87.02394
## Geodetic CRS:  WGS 84
```

![](transboundary_data_extraction_files/figure-latex/spatial_boundaries-1.pdf)<!-- --> 


## 2.- Extract transboundary species for the region



### Summary of results

There are 149 species identified as transboundary in the region: 


Table: Transboundary species identified for the region. n = the number of times the species is shared (i.e., a proxy of stock)

|common_name             |taxon_name               |  n|
|:-----------------------|:------------------------|--:|
|African moonfish        |Selene dorsalis          |  5|
|Albacore                |Thunnus alalunga         | 14|
|Alexandria pompano      |Alectis alexandrina      |  3|
|Atlantic bluefin tuna   |Thunnus thynnus          | 15|
|Atlantic bonito         |Sarda sarda              | 19|
|Atlantic bumper         |Chloroscombrus chrysurus |  5|
|Atlantic emperor        |Lethrinus atlanticus     |  3|
|Atlantic horse mackerel |Trachurus trachurus      | 11|
|Atlantic pomfret        |Brama brama              | 14|
|Atlantic sailfish       |Istiophorus albicans     | 18|

## 3.- Extract shifts in these species' transboundary stocks



### Summary of results

![Stock Share Ratio (SSR) in percentage (left) between each EEZ of all stocks by time frame (bottom). reading  top to right, for example, Cape Verte has 75% of the SSR of one stock shared with Mauritania who has the 25% (100-75) in the historical time period.](transboundary_data_extraction_files/figure-latex/summary_trans_ssr-1.pdf) 

## 3.- Extract shifts in these species' straddling stocks



### Summary of results


![Number of stocks shifting their Stock Share Ratio (SSR) in percentage (left) between EEZs (grouped by realm) and ICCAT by time period (bottom). Colors represent the direction of change. For example, in all cases most stocks wont shift, but when they do they will likeley go to the high seas. Note that the varioation is given because there are two realms in the region](transboundary_data_extraction_files/figure-latex/summary_stradd_ssr-1.pdf) 

