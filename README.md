# Toronto Shelter Occupancy Data Analysis: Project Overview and Guide

## Overview

This repo provides students with a foundation for their own projects associated with *Telling Stories with Data*. You do not need every aspect for every paper and you should delete aspects that you do not need.

## File Structure

The repo is structured as:

-   data/

    -   raw_data/: Contains raw datasets sourced from Open Data Toronto. These datasets track shelter occupancy, capacity, and service user counts from 2021 to 2024.
        -   combined_data.csv daily-shelter-overnight-service-occupancy.csv
        -   raw_data_2021.csv
        -   raw_data_2022.csv
        -   raw_data_2023.csv
        -   simulated_data.csv
    -   analysis_data/: Contains cleaned data ready for analysis.
        -   analysis_data.csv

-   other/

    -   llm/: Documentation on interactions with large language models.
        -   usage.txt
    -   sketches/: Graphical sketches and dataset images used in the analysis.
        -   sketches/: Graphical sketches and dataset images used in the analysis.
            -    dataset.jpg
            -   graph1.jpg
            -   graph2.jpg
            -   graph3.jpg
            -   graph4.jpg

-   paper/: Includes the Quarto markdown document used for the paper, references, and the final PDF version.

    -   paper.qmd
    -   paper.pdf
    -   references.bib

-   scripts/: R scripts for downloading, cleaning, and simulating data.

    -   00-simulate_data.R: Script to generate simulated data for analysis.

    -    01-download_data.R: Script to download the raw data from Open Data Toronto.

    -   02-data_cleaning.R: Script for cleaning the raw data and preparing it for analysis.

    -   03-test_data.R: Script for testing the integrity and structure of the data

-   .gitignore: Ignores unnecessary or sensitive files from being tracked in version control.

-   README.md: Documentation of the repository structure and purpose.

-   toronto-shelter-data.Rproj: R project file for organizing the workspace.

## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, Codriver. The citation and code format, and formal language formatting were written with the help of ChatGPT-4o and the entire chat history is available in other/llm/usage.txt.