# Blood Donation Predict Model API

Doações de sangue são fundamentais para o sistema de saúde, e manter a recorrência dos doadores é um desafio para bancos de sangue. Neste case criei uma API para um sistema que prevê se um doador fará sua próxima doação neste mês!

Neste case demonstramos a integração entre o python e o R, uma vez que o modelo preditivo foi escrito em python e a API utilizando o Plumber do R. Aproveito também para demonstrar alguns conceito no R a instalação de multilplas packages caso necessário.

## Execução da API
 - Edite o arquivo joblibRun.py e insira o path do seu projeto em joblib.load("your_path/blood_donation_model.joblib")
 - Edite o arquivo RunApi.bat
 - Insira o path do seu R geralmente C:\Program Files\R\R-4.0.3\bin
 - Insira o path do projeto Rscript.exe your_path\Run_API.R
 - Execute o arquivo RunApi.bat

## Endpoints da API
O swagger está disponível em 127.0.0.1:8000/__docs__/

**/PredictByPatient** Neste endpoint você pode pesquisar por patient_Id e verificar a predição da sua próxima doação neste mês.

**/patient_list** Neste endpoint você consegue verificar a lista de pacientes disponíveis.

**/TryYourNextBloodDonation** Neste endpoint você será capaz de verificar com seus dados a previsão de doação