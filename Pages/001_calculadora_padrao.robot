*** Settings ***
Documentation   Tela de login
Resource        000_settings.robot
    
*** Variables ***
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