*** Settings ***
Documentation   Arquivo para importacao de bibliotecas comuns a todos os testes
...             Tambem foram inclusas palavras chaves que podem ser utilizadas em todos os testes

Library         AppiumLibrary
Library         BuiltIn
Library         Collections
Library         DateTime
Library         JSONLibrary
Library         OperatingSystem
Library         Screenshot
# caso nao seja utilizada a pasta actions, entao nas bibliotecas abaixo deve-se remover ../
Library         ../Resources/utils/general.py
                
*** Variables ***
${REMOTE_URL}               127.0.0.1:4723/wd/hub
${avdReadyTimeout}          1000
${avdLaunchTimeout}         1200
${platformName}             Android
${automationName}           uiautomator2
${deviceName}               emulator-5554
${appPackage}               com.google.android.calculator
${appActivity}              com.android.calculator2.Calculator
${avd}                      nexus10
${deviceOrientation}        portrait
${ensureWebviewsHavePages}  true
${nativeWebScreenshot}      true
${newCommandTimeout}        2600

${appPackageBusca}               com.android.quicksearchbox
${appActivityBusca}              com.android.quicksearchbox.SearchActivity

*** Keywords ***
Abrir o app
    ${data_atual}=                  Get Current Date             result_format=%d-%m-%Y
    Set Suite Variable      ${titulo}          ${TEST NAME}
    Create Directory                evidencias\\${data_atual}
    Exibir no console Abrir o app Calculadora ${appPackage}
    #Abrir aplicacao com os parametros fornecidos nas variaveis
    Open Application    ${REMOTE_URL}   
    ...    platformName=${platformName}  
    ...    automationName=${automationName}  
    ...    deviceName=${deviceName}  
    ...    appPackage=${appPackage}  
    ...    appActivity=${appActivity}
    ...    avd=${avd}
    ...    deviceOrientation=${deviceOrientation}  
    ...    ensureWebviewsHavePages=${ensureWebviewsHavePages}  
    ...    nativeWebScreenshot=${nativeWebScreenshot}  
    ...    newCommandTimeout=${newCommandTimeout}
    ...    avdReadyTimeout=${avdReadyTimeout}    
    ...    avdLaunchTimeout=${avdLaunchTimeout}
    ...    noSign=true
    #Reset Application
    Sleep    2000ms    Esperando loading

Dado que abri a busca
    Exibir no console Abrir o app Google Search ${appPackageBusca}
    #Abrir aplicacao com os parametros fornecidos nas variaveis
    Open Application    ${REMOTE_URL}   
    ...    platformName=${platformName}  
    ...    automationName=${automationName}  
    ...    deviceName=${deviceName}  
    ...    appPackage=${appPackageBusca}  
    ...    appActivity=${appActivityBusca}
    ...    avd=${avd}
    ...    deviceOrientation=${deviceOrientation}  
    ...    ensureWebviewsHavePages=${ensureWebviewsHavePages}  
    ...    nativeWebScreenshot=${nativeWebScreenshot}  
    ...    newCommandTimeout=${newCommandTimeout}
    ...    avdReadyTimeout=${avdReadyTimeout}    
    ...    avdLaunchTimeout=${avdLaunchTimeout}
    ...    noSign=true

    Sleep    2000ms    Esperando loading
    
Ler Arquivo Json [${LocalArquivoJson}]    
    ${ArquivoJson}     Load Json From File     ${LocalArquivoJson}
    Log To Console    \nArquivo utilizado: ${LocalArquivoJson}
    [Return]            ${ArquivoJson}     

Exibir no console ${mensagem}
    log to console  ${mensagem}

Clicar no elemento ${locator} 
    AppiumLibrary.Click Element    ${locator}

Elemento deve estar visivel ${locator}
    AppiumLibrary.Element Should Be Visible    ${locator}

Espere elemento estar visivel ${locator}
    AppiumLibrary.Wait Until Element Is Visible    ${locator}

Clicar num ponto
Pular testes
    Skip

Tirar print
    ${nome_arquivo}=                  Get Current Date             result_format=%H-%M-%S-%f
    Capture Page Screenshot        appium-screenshot-${nome_arquivo}.png
Espere por ${tempo} segundos ate que a palavra chave (${palavra-chave}) seja executada com sucesso, verifica a cada ${intervalo}s
    Wait Until Keyword Succeeds       ${tempo}      ${intervalo}      ${palavra-chave}

Pagina nao deve conter o elemento ${locator}
    AppiumLibrary.Page Should Not Contain Element     ${locator}

Pagina deve conter o elemento ${locator}
    AppiumLibrary.Page Should Contain Element     ${locator}

Arrastar pra cima
    Swipe    500    1450    500    150
    
Arrastar pra baixo
    Swipe    500    150    500    1450

Repetir palavra-chave ${qtd} vezes - ${palavra-chave}
    Repeat Keyword      ${qtd}      ${palavra-chave}


Mover Screenshots
    Set Suite Variable      ${titulo}          ${TEST NAME}
    ${DATA_ATUAL}=                         Get Current Date      result_format=%d-%m-%Y
    Move Files                             appium-screenshot-*.png    ${EXECDIR}\\evidencias\\${DATA_ATUAL}\\${titulo}
Mover Relatórios
    ${DATA_ATUAL}=                         Get Current Date      result_format=%d-%m-%Y
    Move Files                             *.xml                      ${EXECDIR}\\evidencias\\${DATA_ATUAL}
    Move Files                             *.html                      ${EXECDIR}\\evidencias\\${DATA_ATUAL}
Sair do app
    Exibir no console \n== Sair do aplicativo ==
    Mover Screenshots
    #Mover Relatórios
    
Fechar o app
    Exibir no console === Fechar o aplicativo ===
    Exibir no console ${LOG FILE}
    Close Application