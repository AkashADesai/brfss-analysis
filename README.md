# BRFSS Behavioral Health Analysis

Exploratory analysis of the CDC Behavioral Risk Factor Surveillance System (BRFSS).

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
│   └── documentation/
├── outputs/
│   ├── figures/
├── .Rprofile
├── renv.lock
├── setup.R
└── README.md

```

## Environment
Currently this project runs/works only on local R environments.
The project uses renv to manage R package dependencies and DuckDB for local analytical storage.
To restore the project environment:
```
renv::restore()
```

After running once locally, you can run scripts within the project. You may or may not
need to restart your R session after running the renv::restore() command.

## Data Setup
Download the BRFSS source data, tested on 2024 only but likely works with other earlier years:
```
source("setup.R")
download_brfss(2024)
```
Ingest the raw BRFSS data into DuckDB:
```
ingest_brfss_to_duckdb(2024)
```
The resulting local DuckDB database and downloaded source data are excluded from version control.

## Data Reference
BRFSS codebooks are retained as a versioned reference artifact to support reproducible recoding and data-governance checks. In a production pipeline, source documentation would be archived with raw data, and variable metadata would be modeled into tables or yamls.

## Analysis
The analysis is developed in R, SQL/DuckDB, and the tidyverse for data exploration and visualization.
The primary analysis focuses on identifying populations with substantial mental health burden and examining differences in healthcare access and engagement.
Reproducibility
The workflow is designed so that raw BRFSS data can be re-downloaded from the authoritative source rather than stored in the repository.
The same ingestion pattern can also support additional BRFSS years, providing a foundation for annual refreshes and future schema validation.