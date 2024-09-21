#### Preamble ####
# Purpose: Cleans the raw poll data from Polls Conducted by the City dataset
# Author: [Your Name]
# Date: [Update to current date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: Raw data should be available in 'data/raw_data/unedited_data.csv'
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
# Read in the raw poll data
raw_data <- read_csv("data/raw_data/raw_data.csv")

# Clean and select relevant columns
cleaned_data <- 
  raw_data %>%
  # Clean column names
  clean_names() %>%
  
  # Select the columns of interest for analysis
  select(
    address, 
    application_for, 
    ballots_cast, 
    ballots_in_favour, 
    ballots_opposed, 
    close_date, 
    poll_result, 
    response_rate_met
  ) %>%
  
  # Handle missing values by removing rows where address or ballots_cast are missing
  filter(!is.na(address) & !is.na(ballots_cast)) %>%
  
  # Convert data types: dates and ballots
  mutate(
    close_date = as.Date(close_date, format = "%Y-%m-%d"),
    ballots_cast = as.numeric(ballots_cast),
    ballots_in_favour = as.numeric(ballots_in_favour),
    ballots_opposed = as.numeric(ballots_opposed)
  ) %>%
  
  # Add a new column for the percentage of ballots in favour
  mutate(
    percent_in_favour = (ballots_in_favour / ballots_cast) * 100
  ) %>%
  
  # Remove any rows where percent_in_favour might be NA or invalid
  filter(!is.na(percent_in_favour) & percent_in_favour >= 0)

# View the cleaned data
head(cleaned_data)

#### Save cleaned data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
