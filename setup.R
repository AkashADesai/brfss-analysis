# Install renv if needed
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# Restore the project environment
renv::restore(prompt = FALSE)

# Load packages
library(here)
library(tidyverse)
library(haven)
library(httr2)
library(janitor)
library(broom)
library(scales)
library(DBI)
library(duckdb)

# Load project functions
source(here("R", "download_brfss.R"))
source(here("R", "ingest_brfss_to_duckdb.R"))

# Keep DuckDB state within the project rather than ~/.duckdb
Sys.setenv(
  DUCKDB_HOME = normalizePath(
    ".duckdb",
    mustWork = FALSE
  )
)

dir.create(
  Sys.getenv("DUCKDB_HOME"),
  showWarnings = FALSE,
  recursive = TRUE
)