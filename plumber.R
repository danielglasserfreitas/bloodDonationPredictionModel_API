list.of.packages <- c("plumber", "data.table","zoo","reticulate","dplyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages, require, character.only = TRUE)

nm_arq1       <- "blood_donation_hist.csv"
model_file_nm <- "joblibRun.py"
df_blood_donation <- fread(paste0(nm_arq1))

df_summarized_blo <<- df_blood_donation %>% group_by(patient_id) %>% summarise(
  months_since_last_donation = (as.yearmon(Sys.Date()) - as.yearmon(as.Date(max(donation_date)))) * 12,
  number_of_donations=n(),
  total_volume_donated_cc=sum(volume_donated_cc),
  months_since_first_donation = (as.yearmon(Sys.Date()) - as.yearmon(as.Date(min(donation_date)))) * 12
)

python_file <- paste0(model_file_nm)

use_python("/usr/local/bin/python")
use_virtualenv("venv")
source_python(python_file)


#* @apiTitle Blood Donation Prediction Model
#* @apiDescription This api was develop to demonstrate a python blood Donation prediction model integrates into R api using Plumber.
#* @apiVersion 0.0.1
#* @apiTag bloodDonation Blood Donation Prediction Model

#* Blood donation model prediction by patient_id
#* @tag bloodDonation
#* @param PatientId Choose your patitient ID to filter. You can use patient_list endpoint to obtain another patient_ids
#* @get /PredictByPatient
function(PatientId=442,res) {
  
  tryCatch({
    df_patient     <- df_summarized_blo %>% filter(patient_id==PatientId)
    patient_vector <- as.vector(as.numeric(t(df_patient[,2:5])))
    
    lista_us              <- r_to_py( patient_vector)
    df_patient$prediction <- as.character(model$predict(list(lista_us)))

    resultat_final = list(Status      ="Succeed", 
                          Value       = df_patient)
    
    }, error=function(e){
      res$status = 400  # the response object that is always available in plumber functions
      return(list(error = e, traceback = ...))
  })
  
}

#* Patient Summarized List
#* @tag bloodDonation
#* @get /patient_list
function(res) {
  
  tryCatch({
   
    resultat_final = list(Status      ="Succeed", 
                          Value       = df_summarized_blo)
    
  }, error=function(e){
    res$status = 400  # the response object that is always available in plumber functions
    return(list(error = e, traceback = ...))
  })
  
}


#* Predict your next Blood donation
#* @tag bloodDonation
#* @param firstDonationDate Insert your first blood donation date
#* @param lastDonationDate  Insert your last blood donation date
#* @param numberOfDonations Insert how many times you donate blood in this period. Try change this for 5 times
#* @param accum_volume_donated_cc Insert how much volume of blood you donate in this period. Try change this for 2500
#* @get /TryYourNextBloodDonation
function(lastDonationDate='2021-01-01',firstDonationDate='2020-01-01',numberOfDonations=2,accum_volume_donated_cc=1000,res) {
  
  tryCatch({
    
    p_lastDonationDate        <- as.POSIXct(lastDonationDate)
    p_firstDonationDate       <- as.POSIXct(firstDonationDate)
    p_numberOfDonations       <- as.numeric(numberOfDonations)
    p_accum_volume_donated_cc <- as.numeric(accum_volume_donated_cc)
    months_since_last_donation = (as.yearmon(Sys.Date()) - as.yearmon(p_lastDonationDate)) * 12
    months_since_first_donation = (as.yearmon(Sys.Date()) - as.yearmon(p_firstDonationDate)) * 12
    
    
    df_patient <- data.frame(months_since_last_donation=months_since_last_donation,numberOfDonations=p_numberOfDonations,total_volume_donated_cc=p_accum_volume_donated_cc,months_since_first_donation=months_since_first_donation)
    
    patient_vector <- as.vector(as.numeric(t(df_patient)))
    
    lista_us              <- r_to_py( patient_vector)
    df_patient$prediction <- as.character(model$predict(list(lista_us)))
    
    resultat_final = list(Status      ="Succeed", 
                          Value       = df_patient)
    
  }, error=function(e){
    res$status = 400  # the response object that is always available in plumber functions
    return(list(error = e, traceback = ...))
  })
  
}