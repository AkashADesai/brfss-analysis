# R/download_brfss.R

download_brfss <- function(year, overwrite = FALSE) {
  
  # Validate year
  if (!is.numeric(year) || length(year) != 1) {
    stop("year must be a single numeric value.")
  }
  
  year <- as.integer(year)
  
  if (year < 2011 || year > 2024) {
    stop("Currently supported years: 2011-2024.")
  }
  
  # Project directories
  raw_dir <- here::here("data", "raw", as.character(year))
  dir.create(raw_dir, recursive = TRUE, showWarnings = FALSE)
  
  zip_path <- file.path(
    raw_dir,
    paste0("BRFSS_", year, "_LLCP.zip")
  )
  
  # Don't download if already present
  if (file.exists(zip_path) && !overwrite) {
    message("ZIP already exists: ", zip_path)
  } else {
    
    # CDC download URLs
    url <- sprintf(
      "https://www.cdc.gov/brfss/annual_data/%s/files/LLCP%sXPT.zip",
      year,
      year
    )
    
    message("Downloading BRFSS ", year, "...")
    
    request(url) |>
      req_perform(path = zip_path)
  }
  
  # Extract
  extract_dir <- file.path(raw_dir, "xpt")
  dir.create(extract_dir, recursive = TRUE, showWarnings = FALSE)
  
  unzip(
    zip_path,
    exdir = extract_dir,
    overwrite = overwrite
  )
  
  message("BRFSS ", year, " available at: ", extract_dir)
  
  invisible(extract_dir)
}