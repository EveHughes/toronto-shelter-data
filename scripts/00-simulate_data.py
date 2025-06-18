#### Preamble ####
# Purpose: Simulates shelter occupancy data with random dates and various attributes
# Author: Tim Chen (translated to Python)
# Date: 19 September 2024
# Contact: timwt.chen@mail.utoronto.ca
# Pre-requisites: pandas, numpy
# Any other information needed? Data saved in CSV format for further use

import pandas as pd
import numpy as np

# Set random seed for reproducibility
np.random.seed(304)

# Define date range
start_date = pd.to_datetime("2018-01-01")
end_date = pd.to_datetime("2023-12-31")

# Number of observations
n_dates = 100

# Generate random dates
random_dates = pd.to_datetime(
    np.random.uniform(start_date.value, end_date.value, n_dates).astype('int64'),
    origin='unix'
)

# Simulate data
simulated_data = pd.DataFrame({
    "OCCUPANCY_DATE": random_dates,
    "SERVICE_USER_COUNT": np.random.poisson(lam=150, size=n_dates),
    "OCCUPANCY_RATE_BEDS": np.random.uniform(0, 100, n_dates),
    "CAPACITY_ACTUAL_BED": np.random.poisson(lam=80, size=n_dates),
    "PROGRAM_MODEL": np.random.choice(["Emergency", "Transitional"], size=n_dates),
    "SECTOR": np.random.choice(["Health", "Housing", "Education", "Community"], size=n_dates)
})

# Save to CSV
simulated_data.to_csv("data/raw_data/simulated_data.csv", index=False)
