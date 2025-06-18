#### Preamble ####
# Purpose: Downloads and saves the data from Toronto Open Data (Daily Shelter Overnight Service Occupancy and Capacity)
# Author: Tim Chen
# Date: 26 September 2024
# Contact: timwt.chen@mail.utoronto.ca
# Pre-requisites: Install opendatatoronto and tidyverse packages; access to the Toronto Open Data portal
# Any other information needed? The data will be saved in CSV format for future use



#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####
# get package
package <- show_package("21c83b32-d5a8-4106-a54f-010dbe49f6f2")
package
 
# get all resources for this package
resources <- list_package_resources("21c83b32-d5a8-4106-a54f-010dbe49f6f2")
 
# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))
 
# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data



#### Save data ####
# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(data, "data/raw_data/daily-shelter-overnight-service-occupancy-capacity-2024.csvv") 

         
