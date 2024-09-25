#### Preamble ####
# Purpose: Cleans the raw poll data from Polls Conducted by the City dataset
# Author: [Your Name]
# Date: [Update to current date]
#### Workspace setup ####
# Contact: [Your Email]
# License: MIT
# Pre-requisites: Raw data should be available in 'data/raw_data/unedited_data.csv'
# Any other information needed? None

#### Workspace setup ###
# Load necessary libraries
library(readr)

library(lubridate)
library(tidyr)
library(dplyr)
library(janitor)

# Read the CSV file
df2021 <- read.csv("data/raw_data/daily-shelter-overnight-service-occupancy-capacity-2021.csv")
df2022 <- read.csv("data/raw_data/daily-shelter-overnight-service-occupancy-capacity-2022.csv")
df2023 <- read.csv("data/raw_data/daily-shelter-overnight-service-occupancy-capacity-2023.csv")
df2024 <- read.csv("data/raw_data/daily-shelter-overnight-service-occupancy-capacity-2024.csv")

# Convert the OCCUPANCY_DATE column to the desired date format
df2021$OCCUPANCY_DATE <- as.Date(df2021$OCCUPANCY_DATE, format = "%y-%m-%d")
df2022$OCCUPANCY_DATE <- as.Date(df2022$OCCUPANCY_DATE, format = "%y-%m-%d")
df2023$OCCUPANCY_DATE <- as.Date(df2023$OCCUPANCY_DATE, format="%Y-%m-%dT%H:%M:%S")

# Verify the changes
head(df2021$OCCUPANCY_DATE)
head(df2022$OCCUPANCY_DATE)

# Save the updated dataframe back to CSV files
write.csv(df2021, file = "data/raw_data/raw_data_2021.csv", row.names = FALSE)
write.csv(df2022, file = "data/raw_data/raw_data_2022.csv", row.names = FALSE)
write.csv(df2023, file = "data/raw_data/raw_data_2023.csv", row.names = FALSE)

# Read the saved files
file1 <- read.csv("data/raw_data/raw_data_2021.csv")
file2 <- read.csv("data/raw_data/raw_data_2022.csv")
file3 <- read.csv("data/raw_data/raw_data_2023.csv")
file4 <- read.csv("data/raw_data/daily-shelter-overnight-service-occupancy-capacity-2024.csv")

# Combine the data frames (assuming they have the same structure)
combined_data <- rbind(file1, file2, file3, file4)

# Write the combined data to a new CSV file
write.csv(combined_data, "data/raw_data/combined_data.csv", row.names = FALSE)

# Read combined data
raw_data <- read.csv("data/raw_data/combined_data.csv")

# Clean and process data
cleaned_data <-
  raw_data |>
  janitor::clean_names() |> 
  mutate(date = lubridate::ymd(occupancy_date),       # Convert the full date
         year = lubridate::year(date),               # Extract year
         month = lubridate::month(date, label = TRUE)  # Extract month with labels (e.g., Jan, Feb)
         ) |>
  drop_na(occupancy_rate_beds, program_model) |>      # Remove rows with NA in specified columns
  select(occupancy_date, year, month, occupancy_rate_beds, program_model, service_user_count, capacity_actual_bed, sector)  # Keep only necessary variables


#### Save cleaned data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
