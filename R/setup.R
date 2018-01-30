.onLoad <- function(libname, pkgname) {
  path_to_sheets_token <- "INSERT_PATH_HERE"  # e.g. C:\GAS_token.rds

  if (!file.exists(path_to_sheets_token)) {
    scope_list <- c(
      "https://www.googleapis.com/auth/spreadsheets",
      "https://www.googleapis.com/auth/drive"
    )

    # Get key and secret by following "Web App" instructions here:
    # https://developers.google.com/adwords/api/docs/guides/authentication#webapp
    scripts_app <-
      httr::oauth_app("google",
        key = "INSERT_KEY_HERE",
        secret = "INSERT_SECRET_HERE")

    scripts_token <-
      httr::oauth2.0_token(httr::oauth_endpoints("google"), scripts_app,
        scope = scope_list, cache = FALSE)

    saveRDS(scripts_token, file = path_to_sheets_token)
  }

  options(gscsv.sheets_token = googlesheets::gs_auth(token = path_to_sheets_token))
  options(gscsv.script_token = readRDS(path_to_sheets_token))
  options(gscsv.project_number = "INSERT_PROJECT_NUMBER_HERE")

  invisible()
}