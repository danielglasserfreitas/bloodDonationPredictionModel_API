#plumber_file <- paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/plumber.R")
plumber_file <- paste0("plumber.R")
r <- plumber::plumb(dir = "C:/Users/daniel.freitas/Documents/blood_teste/bloodDonationPredictionModel_API/",file = plumber_file)
r$run(host="0.0.0.0", port=8000)