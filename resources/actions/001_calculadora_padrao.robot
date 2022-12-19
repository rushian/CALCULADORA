*** Settings ***
Documentation   Tela de login
Resource        000_settings.robot
    
*** Variables ***
${btn_0}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_0']
${btn_1}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_1']
${btn_2}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_2']
${btn_3}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_3']
${btn_4}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_4']
${btn_5}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_5']
${btn_6}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_6']
${btn_7}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_7']
${btn_8}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_8']
${btn_9}                    xpath=//*[@resource-id='com.android.calculator2:id/digit_9']
${btn_=}                    xpath=//*[@resource-id='com.android.calculator2:id/eq']
${btn_+}                    xpath=//*[@resource-id='com.android.calculator2:id/op_add']
${btn_-}                    xpath=//*[@resource-id='com.android.calculator2:id/op_sub']
${btn_*}                    xpath=//*[@resource-id='com.android.calculator2:id/op_mul']
${btn_/}                    xpath=//*[@resource-id='com.android.calculator2:id/op_div']
${texto_resultado}          xpath=//*[@resource-id='com.android.calculator2:id/result']



*** Keywords ***
Dado que estou na tela inicial
    Abrir o app
    # criacao do diretorio de evidencias
    ${data_atual}=                  Get Current Date           result_format=%d-%m-%Y
    Set Suite Variable      ${titulo}          ${TEST NAME}
    Create Directory                evidencias\\${data_atual}\\${titulo}
    Set Screenshot Directory        evidencias\\${data_atual}\\${titulo}
   
    Pagina deve conter o elemento ${texto_resultado}

    ${nome_arquivo}=                  Get Current Date             result_format=%H-%M-%S-%f
    Capture Page Screenshot        appium-screenshot-${nome_arquivo}.png
    Clic
E informo um valor (${var_valor1})
    ${lista}=    Listar Digitos    ${var_valor1}
    #@{lista_digitos}=     ${lista}
    Exibir no console Valor digitado ${var_valor1}
    FOR    ${digito}    IN    @{lista}
        ${n}=     Catenate     SEPARATOR=      \$\{    btn_     ${digito}    \}
        ${numero}     Replace Variables    ${n}
        Clicar no elemento ${numero}
    END
    Set Global Variable    ${var_valor1}
    
E escolho uma operacao (${oper})
    Exibir no console Operador escolhido ${oper}
    ${s}=     Catenate    SEPARATOR=    \$\{       btn_      ${oper}    \}
    ${sinal}     Replace Variables    ${s}
    Clicar no elemento ${sinal}
    Set Global Variable    ${oper}

E informo um segundo valor (${var_valor2})
    ${lista}=    Listar Digitos    ${var_valor2}
    #@{lista_digitos}=     ${lista}
    Exibir no console Valor digitado ${var_valor2}
    FOR    ${digito}    IN    @{lista}
        ${n}=     Catenate    SEPARATOR=     \$\{      btn_      ${digito}    \}
        ${numero}     Replace Variables    ${n}
        Clicar no elemento ${numero}
    END
    Set Global Variable    ${var_valor2}
Quando aciono a opcao igual
    Clicar no elemento ${btn_=}
Entao o resultado do calculo deve ser exibido
    Exibir no console ${var_valor1}${oper}${var_valor2}
    ${rsltd_esperado}         Evaluate    ${var_valor1}${oper}${var_valor2}
    ${resultado_esperado}    Convert to string     ${rsltd_esperado}
    ${resultado_obtido}           Get Text     ${texto_resultado}
    
    Element Should Contain Text    ${texto_resultado}     ${resultado_esperado}
    Exibir no console Resultado esperado: ${resultado_esperado} Resultado obtido: ${resultado_obtido}

    ${nome_arquivo}=                  Get Current Date             result_format=%H-%M-%S-%f
    Capture Page Screenshot        appium-screenshot-${nome_arquivo}.png
    # sleep para exibir o resultado
    Sleep    2000ms