#### Preamble ####
# Purpose: Simulates Polls Conducted by the City dataset
# Author: Tim Chen
# Date: 21 September 2024
# Contact: timwt.chen@mail.utoronto.ca
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(304)

# Define the start and end date for poll dates
start_date <- as.Date("2015-01-01")
end_date <- as.Date("2023-12-31")

# Number of polls to simulate
number_of_polls <- 100

# Simulate address data (fake addresses)
addresses <- paste0(sample(1:1000, number_of_polls, replace = TRUE), " Example St")

# Define possible application types
applications <- c("Front Yard Parking", "Sidewalk Construction", "Road Repairs")

# Simulate data with selected columns of interest
poll_data <- tibble(
  id = 1:number_of_polls,
  ADDRESS = sample(addresses, number_of_polls, replace = TRUE),
  APPLICATION_FOR = sample(applications, number_of_polls, replace = TRUE),
  BALLOTS_CAST = sample(10:50, number_of_polls, replace = TRUE),
  BALLOTS_IN_FAVOUR = sample(5:25, number_of_polls, replace = TRUE),
  BALLOTS_OPPOSED = sample(0:10, number_of_polls, replace = TRUE),
  CLOSE_DATE = as.Date(
    runif(
      n = number_of_polls,
      min = as.numeric(start_date),
      max = as.numeric(end_date)
    ),
    origin = "1970-01-01"
  ),
  POLL_RESULT = sample(c("In Favour", "Opposed"), number_of_polls, replace = TRUE),
  RESPONSE_RATE_MET = sample(c("Yes", "No"), number_of_polls, replace = TRUE)
)

#### Write_csv ####
write_csv(poll_data, file = "data/raw_data/simulated_data.csv")