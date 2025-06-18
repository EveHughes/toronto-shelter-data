#### Preamble ####
# Purpose: Cleans the raw shelter occupancy data from Daily Shelter Overnight Service Occupancy and Capacity dataset
# Author: Tim Chen (translated to Python)
# Date: 26 September 2024
# Contact: timwt.chen@mail.utoronto.ca
# Pre-requisites: CSVs must exist in 'data/raw_data/' for 2021–2024

import pandas as pd
from pathlib import Path

# Define input paths
base_path = Path("data/raw_data")
files = [
    base_path / "daily-shelter-overnight-service-occupancy-capacity-2021.csv",
    base_path / "daily-shelter-overnight-service-occupancy-capacity-2022.csv",
    base_path / "daily-shelter-overnight-service-occupancy-capacity-2023.csv",
    base_path / "daily-shelter-overnight-service-occupancy-capacity-2024.csv"
]

# Read and parse each file with appropriate date format
df2021 = pd.read_csv(files[0], parse_dates=["OCCUPANCY_DATE"], date_format="%y-%m-%d", dayfirst=False)
df2022 = pd.read_csv(files[1], parse_dates=["OCCUPANCY_DATE"], date_format="%y-%m-%d", dayfirst=False)
df2023 = pd.read_csv(files[2], parse_dates=["OCCUPANCY_DATE"])
df2023["OCCUPANCY_DATE"] = pd.to_datetime(df2023["OCCUPANCY_DATE"], format="%Y-%m-%dT%H:%M:%S")
df2024 = pd.read_csv(files[3])

# Save cleaned raw versions (optional but mirrors R script)
df2021.to_csv(base_path / "raw_data_2021.csv", index=False)
df2022.to_csv(base_path / "raw_data_2022.csv", index=False)
df2023.to_csv(base_path / "raw_data_2023.csv", index=False)

# Re-read the saved files
file1 = pd.read_csv(base_path / "raw_data_2021.csv")
file2 = pd.read_csv(base_path / "raw_data_2022.csv")
file3 = pd.read_csv(base_path / "raw_data_2023.csv")
file4 = pd.read_csv(base_path / "daily-shelter-overnight-service-occupancy-capacity-2024.csv")

# Combine all data
combined_data = pd.concat([file1, file2, file3, file4], ignore_index=True)

# Save combined raw data
combined_data.to_csv(base_path / "combined_data.csv", index=False)

# Clean and process
raw_data = pd.read_csv(base_path / "combined_data.csv")

# Standardize column names (like janitor::clean_names())
raw_data.columns = raw_data.columns.str.lower().str.strip().str.replace(" ", "_")

# Final cleaned data
cleaned_data = (
    raw_data
    .assign(
        date=pd.to_datetime(raw_data["occupancy_date"], errors="coerce"),
        year=lambda df: df["date"].dt.year,
        month=lambda df: df["date"].dt.strftime("%b")  # abbreviated month name
    )
    .dropna(subset=["occupancy_rate_beds", "program_model"])
    .loc[:, ["occupancy_date", "year", "month", "occupancy_rate_beds", 
             "program_model", "service_user_count", "capacity_actual_bed", "sector"]]
)

# Save cleaned analysis dataset
cleaned_data.to_csv("data/analysis_data/analysis_data.csv", index=False)
