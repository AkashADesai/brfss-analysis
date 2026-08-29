ingest_brfss_to_duckdb <- function(
    year,
    db_path = here::here("data", "brfss.duckdb"),
    overwrite = FALSE
) {
  
  xpt_dir <- file.path(
    here::here("data", "raw", as.character(year)), "xpt"
  )
  
  if (!dir.exists(xpt_dir)) {
    stop(
      "XPT directory does not exist: ",
      xpt_dir,
      "\nRun download_brfss(", year, ") first."
    )
  }
  
  # Find the BRFSS LLCP XPT file
  xpt_files <- list.files(
    xpt_dir,
    pattern = "^LLCP.*\\.XPT\\s*$",
    full.names = TRUE,
    ignore.case = TRUE
  )
  
  if (length(xpt_files) == 0) {
    stop("Could not find LLCP XPT file in: ", xpt_dir)
  }
  
  if (length(xpt_files) > 1) {
    stop(
      "Found multiple LLCP XPT files:\n",
      paste(xpt_files, collapse = "\n")
    )
  }
  
  xpt_file <- xpt_files[[1]]
  
  message("Reading: ", xpt_file)
  
  dat <- haven::read_xpt(xpt_file)
  
  # Connect to DuckDB
  dir.create(
    dirname(db_path),
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  con <- DBI::dbConnect(
    duckdb::duckdb(shared_home = FALSE),
    dbdir = db_path,
    read_only = FALSE
  )
  
  on.exit(
    DBI::dbDisconnect(con, shutdown = TRUE),
    add = TRUE
  )
  
  table_name <- paste0("brfss_", year)
  
  table_exists <- DBI::dbExistsTable(
    con,
    table_name
  )
  
  if (table_exists && !overwrite) {
    message(
      "Table '", table_name,
      "' already exists. Skipping ingestion."
    )
    
    return(invisible(db_path))
  }
  
  DBI::dbWriteTable(
    con,
    table_name,
    dat,
    overwrite = overwrite
  )
  
  message(
    "Created table '", table_name,
    "' with ", nrow(dat), " rows and ",
    ncol(dat), " columns."
  )
  
  invisible(db_path)
}