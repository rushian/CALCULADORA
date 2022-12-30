*** Settings ***
Documentation       Teste de consulta no buscador Google
...                 Abre o navegador
...                 E realiza a consulta com a biblioteca do Selenium
...                 smoketest e um teste pra garantir o funcionamento minimo
Library         SeleniumLibrary
Library         OperatingSystem
Test Setup      log to console  \n===== INICIO DOS TESTES ======
Test Teardown   Encerrar browser



*** Variables ***
${browser}   chrome
#${browser}   headlesschrome
#${browser}    firefox
#${driver}     \\chrome\\chromedriver.exe
#${driver}     \\firefox\\geckodriver.exe
${url}          https://www.google.com.br    



*** Test Cases ***
Consulta Google
    [Tags]    smoketest, rapido
    Setup chromedriver
    Dado que estou usando o Chrome e acesso o site https://www.google.com.br    
    E pesquiso pelo termo deck de magic arena
    Entao verifico se no titulo da guia contem "teste"
*** Keywords ***
Setup chromedriver
    #Log To Console    ${EXECDIR}\\venv\\webdriver${driver}  
    Set Environment Variable      webdriver.Chrome.driver      C:\\qa\\drivers\\chrome\\81.0.4044.92\\chromedriver.exe
Dado que estou usando o Chrome e acesso o site https://www.google.com.br    

   Open Browser    ${url}  ${browser}    
    Log To Console    Abrir a pagina no navegador
E pesquiso pelo termo deck de magic arena
    Set Test Variable    ${query}   teste
    Log To Console       Buscar a caixa pra digitar "${query}"
    Input Text           name = q   ${query}
    Press Keys      q    ENTER
Entao verifico se no titulo da guia contem "${query}"
    Log To Console   Verificar titulo da pagina
    Sleep    2000ms
    ${titulo} =      Get Title
    Should Contain    ${titulo}    ${query}
    Log To Console    Verificar e clicar no link escolhido
    Page Should Contain    ${query}
Encerrar browser
    Sleep       4000ms
    Close Browser