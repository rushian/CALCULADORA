*** Settings ***
Documentation   Testes web

Resource        ../../resources/base_web.robot
Resource        ../../resources/actions_web/000_settings_web.robot


*** Test Cases ***
Ver variaveis
    Listar variaveis
Apagar campo
    Dado que estou na pagina inicial
    E preencho o campo de busca
    E deleto o campo a cada caractere    ${input_busca}    ${txt_da_busca}
Abrir navegador
    Create WebDriver With Chrome Options
    E preencho o campo de busca
    
