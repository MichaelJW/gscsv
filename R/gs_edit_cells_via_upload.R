gs_edit_cells_via_upload <- function(ss, ws = 1, input = '', anchor = 'A1', byrow = FALSE, col_names = NULL, trim = FALSE, verbose = TRUE) {
  # NB. byrow, trim, and verbose don't do anything yet.
  # col_names simply includes col headers iff it's TRUE, and not otherwise (i.e. not by default)

  csv_sheet_name <- paste0('TEMP - Output CSV - ', base::date())
  write.csv(input, 'test_output.csv', row.names = FALSE)
  uploaded_details <- googlesheets::gs_upload('test_output.csv', sheet_title = csv_sheet_name)
  uploaded_sheet_key <- uploaded_details$sheet_key

  script_url <- file.path(
    "https://script.googleapis.com",
    paste0("v1/scripts/", getOption('gscsv.project_number'), ":run")
  )
  script_args <- list(
    `function` = "copyFromSheetToSheet",
    devMode = TRUE,
    parameters = list(
      uploaded_sheet_key,
      ss$sheet_key,
      anchor,
      ws,
      (is.null(col_names) | col_names == TRUE)
    )
  )
  script_args <- jsonlite::toJSON(script_args, auto_unbox = TRUE)
  req <-  httr::stop_for_status(httr::POST(script_url, getOption('gscsv.script_token'), body = script_args))

  ss <- googlesheets::gs_key(ss$sheet_key, verbose = FALSE)
  invisible(ss)
}