# Blood Donation Predict Model API

Doações de sangue são fundamentais para o sistema de saúde, e manter a recorrência dos doadores é um desafio para bancos de sangue. Neste case criei uma API para um sistema que prevê se um doador fará sua próxima doação neste mês!

Neste case demonstramos a integração entre o python e o R, uma vez que o modelo preditivo foi escrito em python e a API utilizando o Plumber do R. Aproveito também para demonstrar alguns conceito no R a instalação de multilplas packages caso necessário.

English

Blood donations are critical to the health care system, and maintaining donor recurrence is a challenge for blood banks. In this case I created an API for a system that predicts whether a donor will make their next donation this month!

In this case, I demonstrate an integration between python and R, since the predictive model was written in python and an API using the Plumber of R. I also take the opportunity to demonstrate the concept in R by installing multiple packages if necessary.

## Versions
Python 3.9.0 and R-4.0.3 

## Execução da API
 - Edite o arquivo joblibRun.py e altere o path do seu projeto em joblib.load("your_path/blood_donation_model.joblib")
 - Edite o arquivo RunApi.bat
    - Altere o path do seu R geralmente C:\Program Files\R\R-4.0.3\bin
    - Altere o path do projeto Rscript.exe your_path\Run_API.R
 - Execute o arquivo RunApi.bat


English
 - Edit the joblibRun.py file and change the path of your project in joblib.load ("your_path / blood_donation_model.joblib")
  - Edit the RunApi.bat file
     - Change the path of your R usually C: \ Program Files \ R \ R-4.0.3 \ bin
     - Change the path of the Rscript.exe project your_path \ Run_API.R
  - Run the RunApi.bat file

## Endpoints da API
A documentação da API está disponível no [swagger](http://127.0.0.1:8000/__docs__/)


**/PredictByPatient** 
 - Neste endpoint você pode pesquisar por patient_Id e verificar a predição da sua próxima doação neste mês.

**/patient_list** 
 - Neste endpoint você consegue verificar a lista de pacientes disponíveis.

**/TryYourNextBloodDonation** 
 - Neste endpoint você será capaz de verificar com seus dados a previsão de doação

English

**/ PredictByPatient** 
 - In this endpoint you can search for patient_Id and check the prediction of your next donation this month.

**/ patient_list** 
 - In this endpoint you can check the list of available patients.

**/ TryYourNextBloodDonation** 
 - At this endpoint you will be able to check the donation forecast with your data