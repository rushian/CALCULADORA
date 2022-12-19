*** Settings ***
Documentation   Arquivo para importacao de bibliotecas comuns a todos os testes
...             Tambem foram inclusas palavras chaves que podem ser utilizadas em todos os testes

Library         AppiumLibrary
Library         BuiltIn
Library         DateTime
Library         OperatingSystem
Library         Screenshot
Library         Collections
Library         ../utils/file_manager.py
Library         ../utils/general.py
                
*** Variables ***
${REMOTE_URL}               http://127.0.0.1:4723/wd/hub
${avdReadyTimeout}          30000
${avdLaunchTimeout}         12000
${platformName}             Android
${automationName}           uiautomator2
${deviceName}               emulator-5554
${appPackage}               com.android.calculator2
${appActivity}              com.android.calculator2.Calculator
${avd}                      pixel2api27
${deviceOrientation}        portrait
${ensureWebviewsHavePages}  true
${nativeWebScreenshot}      true
${newCommandTimeout}        3600
${connectHardwareKeyboard}  true

*** Keywords ***
Abrir o app
    ${data_atual}=                  Get Current Date             result_format=%d-%m-%Y
    Set Suite Variable      ${titulo}          ${TEST NAME}
    Create Directory                evidencias\\${data_atual}
    Exibir no console Abrir o app Calculadora ${appPackage}
    #Abrir aplicacao com os parametros fornecidos nas variaveis
    Open Application    ${REMOTE_URL}   platformName=${platformName}  automationName=${automationName}  deviceName=${deviceName}  appPackage=${appPackage}  appActivity=${appActivity}  avd=${avd}  deviceOrientation=${deviceOrientation}  ensureWebviewsHavePages=${ensureWebviewsHavePages}  nativeWebScreenshot=${nativeWebScreenshot}  newCommandTimeout=${newCommandTimeout}  connectHardwareKeyboard=${connectHardwareKeyboard}    avdReadyTimeout=${avdReadyTimeout}    avdLaunchTimeout=${avdLaunchTimeout}
    #Reset Application
    Sleep    2000ms    Esperando loading
    
Exibir no console ${mensagem}
    log to console  ${mensagem}
Clicar no elemento ${locator} 
    Click Element    ${locator}
Elemento deve estar visivel ${locator}
    Element Should Be Visible    ${locator}
Espere elemento estar visivel ${locator}
    Wait Until Element Is Visible    ${locator}
Ler dado da planilha
    [Arguments]     ${file}    ${sheetname}        ${cell}  
    ${cell_data}=   Ler Dado Celula    ${file}     ${sheetname}    ${cell}    
    [Return]        ${cell_data}
Ler dado da planilha na celula ao lado
    [Arguments]     ${file}    ${sheetname}        ${cell}  
    ${cell_data}=   Ler Dado Celula Ao Lado   ${file}     ${sheetname}    ${cell}    
    [Return]        ${cell_data}

#####  CAMINHOS PARA LOGOUT [UTILIZADOS EM TODOS OS TESTES] #####
E aciono a opcao "Perfil"
    Exibir no console Clicar no botao perfil
    Espere elemento estar visivel ${btn_perfil}
    Clicar no elemento ${btn_perfil}
    Espere elemento estar visivel ${btn_sair}   
    
    ${nome_arquivo}=                  Get Current Date             result_format=%H-%M-%S-%f
    Capture Page Screenshot    appium-screenshot-${nome_arquivo}.png

Quando aciono a opcao Sair
    Exibir no console Clicar no botao Sair
    Clicar no elemento ${btn_sair}
    Sleep    3000ms
    Espere elemento estar visivel ${img_logo_caixa}
    

Entao a tela de login e exibida
    Exibir no console Verificar se esta na tela inicial
    Espere elemento estar visivel ${img_logo_caixa}
    
    ${nome_arquivo}=                  Get Current Date             result_format=%H-%M-%S-%f
    Capture Page Screenshot    appium-screenshot-${nome_arquivo}.png
    
E executo logout
    E aciono a opcao "Perfil"
    Quando aciono a opcao Sair
    Entao a tela de login e exibida

Clicar num ponto
Pular testes
    Skip

Espere por ${tempo} segundos ate que a palavra chave (${palavra-chave}) seja executada com sucesso, verifica a cada ${intervalo}s
    Wait Until Keyword Succeeds       ${tempo}      ${intervalo}      ${palavra-chave}

Pagina nao deve conter o elemento ${locator}
    Page Should Not Contain Element     ${locator}

Pagina deve conter o elemento ${locator}
    Page Should Contain Element     ${locator}

Arrastar pra cima
    Swipe    500    1450    500    150
    
Arrastar pra baixo
    Swipe    500    150    500    1450

Repetir palavra-chave ${qtd} vezes - ${palavra-chave}
    Repeat Keyword      ${qtd}      ${palavra-chave}

Randomizar valor
    [Documentation]    Passe o valor minimo e maximo, a rotina vai sortear um valor no intervalo (até o maximo -1)
    [Arguments]     ${minimo}    ${maximo}        
    ${opcao_de_renegociacao}=      Randomize Value       ${minimo}        ${maximo}
    [Return]        ${opcao_de_renegociacao}

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
    Quit Application
Fechar o app
    Exibir no console === Fechar o aplicativo ===
    Exibir no console ${LOG FILE}
    Close Application