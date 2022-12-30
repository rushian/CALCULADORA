*** Settings ***
Documentation   Arquivo para importacao de bibliotecas comuns a todos os testes
...             Tambem foram inclusas palavras chaves que podem ser utilizadas em todos os testes

Library         BuiltIn
Library         DateTime
Library         OperatingSystem
Library         Screenshot
Library         SeleniumLibrary
Library         Collections
Resource        ../actions_web/000_settings_web.robot


                
*** Variables ***
${browser}         chrome
${url}             http://www.amazon.com.br
${input_busca}     id=twotabsearchtextbox
${txt_da_busca}    texto para deletar via codigo
@{options}         --start-maximized    --disable-extensions   
&{caps}            chrome_options=@{options}

*** Keywords ***
Listar variaveis
    Exibir no console \n
    Exibir no console ${CURDIR}
    Exibir no console ${EXECDIR}
    Exibir no console @{options}
    Exibir no console &{caps}
Create WebDriver With Chrome Options
    Set Environment Variable      webdriver.Chrome.driver      C:\\qa\\drivers\\chrome\\81.0.4044.92\\chromedriver.exe
    ${chrome_options} =    Evaluate    selenium.webdriver.ChromeOptions()
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --disable-extensions 
    Call Method    ${chrome_options}    add_argument    --dns-prefetch-disable
    Call Method    ${chrome_options}    add_argument    --disable-extensions-file-access-check
    Call Method    ${chrome_options}    add_argument    --disable-policy-key-verification
    Call Method    ${chrome_options}    add_argument    --allow-failed-policy-fetch-for-test
    Call Method    ${chrome_options}    add_argument    --disable-site-isolation-for-policy
    Call Method    ${chrome_options}    add_argument    --disable-web-security
    Call Method    ${chrome_options}    add_argument    --disallow-policy-block-dev-mode
    Call Method    ${chrome_options}    add_argument    --wait-for-initial-policy-fetch-for-test
    
    Create WebDriver    Chrome    chrome_options=${chrome_options} 
    Go To    ${url}

Dado que estou na pagina inicial
    Open Browser    ${url}    ${browser}
E preencho o campo de busca
    SeleniumLibrary.Input Text    ${input_busca}        ${txt_da_busca}
Exibir no console ${mensagem}
    log to console  ${mensagem}
Apagar campo por digitos
    [Arguments]    ${field}    ${character count}
    [Documentation]    Esta palavra-chave aperta a tecla delete (ascii: \8) um numero de vezes especificado num campo determinado
    
    Press Keys    ${field}    \ue011
    FOR    ${index}    IN RANGE    ${character count}
        Press Keys    ${field}    \ue017
    END
E deleto o campo a cada caractere
    [Arguments]    ${input_busca}    ${text}
    [Documentation]    Keyword is just an input text keyword. That clears the text field dynamically.
    ${field text}=    Get Value    ${input_busca}
    ${field text length}=    Get Length    ${field text}
    Apagar campo por digitos    ${input_busca}    ${field text length}
    Input Text    ${input_busca}    ${text}


Pular testes
    Skip

Espere por ${tempo} segundos ate que a palavra chave (${palavra-chave}) seja executada com sucesso, verifica a cada ${intervalo}s
    Wait Until Keyword Succeeds       ${tempo}      ${intervalo}      ${palavra-chave}

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
