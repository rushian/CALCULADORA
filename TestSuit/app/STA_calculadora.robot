*** Settings ***
Documentation   Valida operacoes matematicas

Resource        ../../Resources/base.robot

Test Setup      Log to console    \n==== INICIO DA AUTOMACAO ====
Test Teardown   Sair do app
Suite Setup     Log to console    == Suite: STA_Calculadora ==
Suite Teardown  Fechar o app

*** Test Cases ***
Calculo com numeros inteiros 
    [Documentation]    Testes com calculos de numeros inteiros exceto divisao
    [Tags]    inteiros    soma    subttracao     multiplicacao
    #Pular testes
    Dado que estou na tela inicial
    E informo um valor (12)
    E escolho uma operacao (*)
    E informo um segundo valor (3)
    Quando aciono a opcao igual
    Entao o resultado do calculo deve ser exibido

Calculo com numeros inteiros - divisao
    [Documentation]    Testes com calculos de divisao de numeros inteiros 
    [Tags]    inteiros    divisao
    #Pular testes
    Dado que estou na tela inicial
    E informo um valor (22)
    E escolho uma operacao (/)
    E informo um segundo valor (5)
    Quando aciono a opcao igual
    Entao o resultado do calculo deve ser exibido

Calculo com numeros inteiros com json
    [Documentation]    Testes com calculos de numeros inteiros exceto divisao
    [Tags]    inteiros    soma    subttracao     multiplicacao
    #Pular testes
    Dado que estou na tela inicial
    E passo uma lista de operacoes num json

    #Entao o resultado do calculo deve ser exibido