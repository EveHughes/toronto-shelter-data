# Purpose: Downloads and saves the data from Toronto Open Data (Daily Shelter Overnight Service Occupancy and Capacity)
# Author: Tim Chen
# Date: 26 September 2024
# Contact: timwt.chen@mail.utoronto.ca
# Pre-requisites: Install opendatatoronto and tidyverse packages; access to the Toronto Open Data portal
# Any other information needed? The data will be saved in CSV format for future use

import pandas as pd
from io import StringIO
import requests

base_url = "https://ckan0.cf.opendata.inter.prod-toronto.ca"

url = base_url + "/api/3/action/package_show"
params = { "id": "daily-shelter-overnight-service-occupancy-capacity"}
package = requests.get(url, params = params).json()

for idx, resource in enumerate(package["result"]["resources"]):

       if resource["datastore_active"]:
            url = base_url + "/datastore/dump/" + resource["id"]
            resource_dump_data = requests.get(url)

            # Writing raw data to CSV
            raw_case_data = pd.read_csv(StringIO(resource_dump_data.text))
            raw_case_data.to_csv("data/raw_data/daily-shelter-overnight-service-occupancy-capacity-2024.csvv")
            

