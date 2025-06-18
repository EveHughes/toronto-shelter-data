#### Preamble ####
# Purpose: Downloads and saves the data from the Open Data Toronto portal
# Author: Amie Liu
# Date: 16 January 2024
# Contact: amie.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

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
            

