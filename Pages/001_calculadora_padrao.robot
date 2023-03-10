*** Settings ***
Documentation   Tela de login
Resource        000_settings.robot
Library    String
Library    Collections
    
*** Variables ***
${input_busca}              xpath=//*[@resource-id='com.android.quicksearchbox:id/search_src_text']
${btn_0}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_0']
${btn_1}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_1']
${btn_2}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_2']
${btn_3}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_3']
${btn_4}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_4']
${btn_5}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_5']
${btn_6}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_6']
${btn_7}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_7']
${btn_8}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_8']
${btn_9}                    xpath=//*[@resource-id='com.google.android.calculator:id/digit_9']
${btn_=}                    xpath=//*[@resource-id='com.google.android.calculator:id/eq']
${btn_+}                    xpath=//*[@resource-id='com.google.android.calculator:id/op_add']
${btn_-}                    xpath=//*[@resource-id='com.google.android.calculator:id/op_sub']
${btn_*}                    xpath=//*[@resource-id='com.google.android.calculator:id/op_mul']
${btn_/}                    xpath=//*[@resource-id='com.google.android.calculator:id/op_div']
${texto_resultado}          xpath=//*[@resource-id='com.google.android.calculator:id/result_final']
${clear}                    xpath=//*[@resource-id='com.google.android.calculator:id/clr']

*** Keywords ***
Dado que estou na tela inicial
    Abrir o app
    # criacao do diretorio de evidencias
    ${data_atual}=                  Get Current Date           result_format=%d-%m-%Y
    Set Suite Variable      ${titulo}          ${TEST NAME}
    Create Directory                evidencias\\${data_atual}\\${titulo}
    Set Screenshot Directory        evidencias\\${data_atual}\\${titulo}
   
    Pagina deve conter o elemento ${clear}
    Run Keyword And Ignore Error    Tirar print

E informo um valor (${var_valor1})
    ${lista}=    Listar Digitos    ${var_valor1}
    
    FOR    ${digito}    IN    @{lista}
        ${n}=     Catenate     SEPARATOR=      \$\{    btn_     ${digito}    \}
        ${numero}     Replace Variables    ${n}
        Clicar no elemento ${numero}
    END
    Set Global Variable    ${var_valor1}
    
E escolho uma operacao (${oper})
    ${s}=     Catenate    SEPARATOR=    \$\{       btn_      ${oper}    \}
    ${sinal}     Replace Variables    ${s}
    Clicar no elemento ${sinal}
    Set Global Variable    ${oper}

E informo um segundo valor (${var_valor2})
    ${lista}=    Listar Digitos    ${var_valor2}
    
    FOR    ${digito}    IN    @{lista}
        ${n}=     Catenate    SEPARATOR=     \$\{      btn_      ${digito}    \}
        ${numero}     Replace Variables    ${n}
        Clicar no elemento ${numero}
    END
    Set Global Variable    ${var_valor2}
    
Quando aciono a opcao igual
    Clicar no elemento ${btn_=}
    Sleep    2000ms

Entao o resultado do calculo deve ser exibido
    Exibir no console ${var_valor1}${oper}${var_valor2}
    ${rsltd_esperado}         Evaluate    ${var_valor1}${oper}${var_valor2}
    ${resultado_esperado}    Convert to string     ${rsltd_esperado}
    ${resultado_obtido}           Get Text     ${texto_resultado}
    
    Element Should Contain Text    ${texto_resultado}     ${resultado_esperado}
    Exibir no console Resultado esperado: ${resultado_esperado} Resultado obtido: ${resultado_obtido}

    Run Keyword And Ignore Error    Tirar print
    # sleep para exibir o resultado
    Sleep    2000ms

E aciono a opcao limpar
    Clicar no elemento ${clear}

E passo uma lista de operacoes num json
    ${ArquivoJson}    Ler Arquivo Json [TestData\\operacoes.json]
    ${tamanhoJson}    Get Length    ${ArquivoJson}
    Log To Console    Quantidade de operacoes: ${tamanhoJson}
    FOR    ${counter}    IN RANGE    0    ${tamanhoJson}
        ${valor1}                Get From Dictionary    ${ArquivoJson[${counter}]}    valor1
        ${valor2}                Get From Dictionary    ${ArquivoJson[${counter}]}    valor2
        ${oper}                  Get From Dictionary    ${ArquivoJson[${counter}]}    oper
        ${resultado_esperado}     Get From Dictionary    ${ArquivoJson[${counter}]}    rslt_esperado
        E informo um valor (${valor1})
        E escolho uma operacao (${oper})
        E informo um segundo valor (${valor2})
        Quando aciono a opcao igual
        Exibir no console ${valor1}${oper}${valor2}
        ${resultado_obtido}           Get Text     ${texto_resultado}
    
        Element Should Contain Text    ${texto_resultado}     ${resultado_esperado}
        Exibir no console Resultado esperado: ${resultado_esperado} Resultado obtido: ${resultado_obtido}

        Run Keyword And Ignore Error    Tirar print
        E aciono a opcao limpar
    END

E gerei codigo no appium
    Tap With Positions    100    ${129, 874}
    Tap With Positions    100    ${358, 1038}
    Tap With Positions    100    ${797, 1210}
    Tap With Positions    100    ${527, 860}
    Tap With Positions    100    ${550, 886}
    Tap With Positions    100    ${754, 1413}
 
    Log To Console    Codigo gerado executado

E crio um dicionario
        &{dicionario}         Create Dictionary    0=7     1=8     2=9     3=10    4=11
        Set To Dictionary  	${dicionario}          5=12    6=13    7=14    8=15    9=16
        Set Global Variable    ${dicionario}
        Log To Console    Conteudo do dicionario: ${dicionario}

E leio o cep em um json e digito via codigo cada numero desse cep
        #${cep}    set variable     02083110
        ${ArquivoJson}    Ler Arquivo Json [TestData\\ceps.json]
        ${cep}    Get From Dictionary  ${ArquivoJson[0]}   cep
        Set Global Variable    ${cep}
        @{digitos}    Split String To Characters   ${cep}
        Log To Console   Digitos: ${digitos}

        FOR     ${numero}    IN     @{digitos}
            ${digito}    Get From Dictionary  ${dicionario}   ${numero}
            Press Keycode    ${digito}
        END
    Sleep    4

Entao o texto de busca deve ser o cep digitado
    ${texto da busca}    Get Text    ${input_busca}
    Element Text Should Be   ${input_busca}   ${cep}
    Log To Console    cep digitado: ${cep}
    Tirar print