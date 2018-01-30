GSCSV
-----

Edit an existing Google Sheets worksheet via uploading a CSV rather than cell-by-cell. Uses the same arguments as `googlesheets::gs_edit_cells()`, making it easy to swap one call for the other.

### Setup Instructions

This package must (for the time being) be built manually by the user; it cannot be installed via devtools::install_github() or the like. This is partly because it's still a work in progress, and also because it requires sending your data to a Google Apps Script, which could potentially be malicious if you aren't controlling it yourself.

Download all the files from GitHub via the "Clone or download > Download ZIP" button.

Create a new project in https://console.developers.google.com/apis/credentials. Click "Enable APIs and Services". Search for "Google Apps Script API" and click it. Click "Enable". Do the same with the Google Sheets API and Google Drive API.

In sidebar (not the prompt at top of screen), click "Credentials". Click "Create credentials" and select "OAuth client ID". (If it asks you to enter a name for your project, do so.) Select "Other" from the list, give it a name if you like, and click "Create". Copy your client ID and client secret.

In "Project > Project Settings", copy the Project number.

Go to https://script.google.com. Click "New script". Paste the contents of `google_apps_script.txt`. Save (give it a name). From "File > Project properties > Info", copy the "Project key". In "Resources > Cloud Platform project", paste the project number you copied earlier. Click "Confirm".

Open `gscsv.Rproj` in RStudio. In setup.R, replace:

- `INSERT_KEY_HERE` with the key you got earlier
- `INSERT_SECRET_HERE` with the secret you copied earlier
- `INSERT_PROJECT_NUMBER_HERE` with the project number you copied earlier
- `INSERT_PATH_HERE` with a valid path on your hard drive to an RDS file. The RDS file will be created - just put "C:\GAS_token.rds" if you're not sure (on Windows).

Click "Build > Build and Reload".

Now you should be able to do:

```
library(gscsv)
gs_edit_cells_via_upload(ss, ws, input, anchor, byrow, col_names, trim, verbose)  
```

The call is the same as for googlesheets::gs_edit_cells(), but `byrow`, `trim`, and `verbose` don't do anything.
