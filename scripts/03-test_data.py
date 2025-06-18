#### Preamble ####
# Purpose: Sanity check of the shelter occupancy data
# Author: Tim Chen (translated to Python)
# Date: 26 September 2024
# Contact: timwt.chen@mail.utoronto.ca
# Pre-requisites: pandas
# Any other information needed? Expects data at 'data/analysis_data/analysis_data.csv'

import unittest
import pandas as pd

class TestShelterOccupancyData(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.data = pd.read_csv("data/analysis_data/analysis_data.csv")

    # Test for non-negative values in numeric columns
    def test_service_user_count_non_negative(self):
        self.assertTrue((self.data["service_user_count"] >= 0).all())

    def test_occupancy_rate_beds_non_negative(self):
        self.assertTrue((self.data["occupancy_rate_beds"] >= 0).all())

    def test_capacity_actual_bed_non_negative(self):
        self.assertTrue((self.data["capacity_actual_bed"] >= 0).all())

    # Test for no missing values in critical columns
    def test_occupancy_date_not_na(self):
        self.assertFalse(self.data["occupancy_date"].isna().any())

    def test_service_user_count_not_na(self):
        self.assertFalse(self.data["service_user_count"].isna().any())

    def test_program_model_not_na(self):
        self.assertFalse(self.data["program_model"].isna().any())

    def test_sector_not_na(self):
        self.assertFalse(self.data["sector"].isna().any())

    def test_occupancy_rate_beds_not_na(self):
        self.assertFalse(self.data["occupancy_rate_beds"].isna().any())

    # Test for valid occupancy rate range (0–100)
    def test_occupancy_rate_beds_range(self):
        valid = (self.data["occupancy_rate_beds"] >= 0) & (self.data["occupancy_rate_beds"] <= 100)
        self.assertTrue(valid.all())

if __name__ == "__main__":
    unittest.main()
