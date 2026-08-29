# BRFSS Behavioral Health Analysis

Exploratory analysis of the CDC Behavioral Risk Factor Surveillance System (BRFSS), completed as part of the Onos Health Data Scientist/Analyst exercise.

## Objective

This project explores behavioral health patterns in the most recent annual BRFSS dataset, with a focus on questions relevant to health plans and behavioral healthcare delivery.

The initial analysis examines mental health burden and healthcare access, including:

- Poor mental health days
- Health insurance coverage
- Connection to a personal healthcare provider
- Cost-related barriers to care
- Routine healthcare utilization
- Demographic and geographic variation

## Data

**Source:** CDC Behavioral Risk Factor Surveillance System (BRFSS)

The project uses the 2024 BRFSS annual public-use dataset downloaded directly from the CDC SAS Transport (`.XPT`) source file.

Raw data are not committed to this repository. The included ingestion code downloads and processes the source data reproducibly.

## Project Structure

```text
.
├── R/
│   ├── download_brfss.R
│   ├── ingest_brfss.R
├── analysis/
│   └── BRFSS_Notebook.Rmd
├── data/
│   ├── raw/
│   └── processed/
├── outputs/
│   ├── figures/
│   └── tables/
├── .Rprofile
├── renv.lock
├── setup.R
└── README.md

```

## Environment
The project uses renv to manage R package dependencies and DuckDB for local analytical storage.
To restore the project environment:
```
renv::restore()
```

## Data Setup
Download the BRFSS source data:
```
source("setup.R")
download_brfss(2024)
```
Ingest the raw BRFSS data into DuckDB:
```
ingest_brfss_to_duckdb(2024)
```
The resulting local DuckDB database and downloaded source data are excluded from version control.

## Analysis
The analysis is developed in R, SQL/DuckDB, and the tidyverse for data exploration and visualization.
The primary analysis focuses on identifying populations with substantial mental health burden and examining differences in healthcare access and engagement.
Reproducibility
The workflow is designed so that raw BRFSS data can be re-downloaded from the authoritative source rather than stored in the repository.
The same ingestion pattern can also support additional BRFSS years, providing a foundation for annual refreshes and future schema validation.