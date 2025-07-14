***Settings***
Library    SeleniumLibrary    timeout=10s    implicit_wait=5s
Library    OperatingSystem    
Library    String             
Library    DateTime    

***Variables***
${LOGIN_URL} =    /Account/Login
${HOME_URL} =     /
${REGISTER_URL} =    /Account/Register

***Keywords***
Abrir Navegador na URL Base
    [Arguments]    ${url}=${EMPTY}
    ${full_url}=    Catenate    SEPARATOR=    ${BASE_URL}    ${url}
    Open Browser    ${full_url}    ${BROWSER_NAME}
    Maximize Browser Window

Preencher Credenciais E Clicar Login
    [Arguments]    ${matricula}    ${senha}
    Wait Until Page Contains Element    id=Matricula    timeout=10s 
    Input Text    id=Matricula    ${matricula}
    Input Text    id=Senha        ${senha}
    Click Button    css=button[type='submit']

Fazer Login
    [Arguments]    ${matricula}    ${senha}
    Input Text    id=Matricula    ${matricula}
    Input Text    id=Senha    ${senha}
    Click Button    css=button[type='submit']
    Wait Until Location Is    ${BASE_URL}${HOME_URL}
    Page Should Contain Element    tag=h2   

Registrar Novo Usuario Com Dados
    [Arguments]    ${nome}    ${email}    ${senha}    ${matricula}    ${semestre}    ${ano}
    Input Text    id=Nome                 ${nome}
    Input Text    id=Email                ${email}
    Select From List By Value    id=SemestreEntrada    ${semestre}
    Select From List By Value    id=AnoEntrada         ${ano}
    Input Text    id=Senha                ${senha}
    Input Text    id=ConfirmacaoSenha     ${senha}
    Input Text    id=Matricula            ${matricula}
    Click Button  css=button[type='submit']
    Log To Console    Novo usuário registrado: ${matricula}

Fazer Login Do Usuario
    [Arguments]    ${matricula}    ${senha}
    Wait Until Page Contains Element    css=h3.form-title       timeout=10s
    Element Should Contain              css=h3.form-title       Login
    Page Should Contain                 Não tem uma conta? Fazer Registro
    Input Text    id=Matricula          ${matricula}
    Input Text    id=Senha              ${senha}
    Click Button  css=button[type='submit']
    
Navegar Para Pagina De Upload
    [Arguments]    ${expected_url_path}
    Wait Until Location Is    ${BASE_URL}${expected_url_path}
    Wait Until Page Contains Element    css=.import-title    timeout=15s

Abrir Navegador na URL Register
    [Arguments]    ${url}=${REGISTER_URL}
    ${full_url}=    Catenate    SEPARATOR=    ${BASE_URL}    ${url}
    Open Browser    ${full_url}    ${BROWSER_NAME}
    Maximize Browser Window

Gerar Dados De Registro
    ${NOME_COMPLETO}=          Generate Random String    15    [LETTERS][NUMBERS]
    ${TIMESTAMP}=              Get Current Date    result_format=%Y%m%d%H%M%S
    ${EMAIL_ALEATORIO}=        Catenate    SEPARATOR=    teste_
    ...                        ${TIMESTAMP}
    ...                        @robotframework.com
    ${SENHA_ALEATORIA}=        Generate Random String    10    [LETTERS][NUMBERS][SYMBOLS]


    ${MATRICULA_ALEATORIA}=    Evaluate    random.randint(100000000, 999999999)    random
    ${SEMESTRE_ALEATORIO}=     Evaluate    random.choice(['01', '02'])    random
    ${ANO_ALEATORIO}=          Evaluate    random.randint(2015, 2025)    random

    Return From Keyword    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}

Verificar Redirecionamento Para Home
    Wait Until Page Contains Element    css=.grade-container    timeout=15s


Verificar Permanencia Na Pagina De Login
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Login
    Page Should Not Contain Element     css=.grade-container    

Clicar Link Esqueceu Senha
    Wait Until Element Is Visible    link=Clique aqui    timeout=10s
    Click Link                       link=Clique aqui

Preencher Email NoModal De Recuperacao
    [Arguments]    ${email}
    Wait Until Element Is Visible    css=input[placeholder="Digite seu Email"]    timeout=10s
    Input Text                       css=input[placeholder="Digite seu Email"]    ${email}

Clicar Botao Enviar NoModal De Recuperacao
    Wait Until Element Is Visible    xpath=//div[@class='modal-content']//button[text()='Enviar']    timeout=5s
    Click Element                    xpath=//div[@class='modal-content']//button[text()='Enviar']

Clicar Botao Cancelar NoModal De Recuperacao
    Wait Until Element Is Visible    xpath=//div[@class='modal-content']//button[text()='Cancelar']    timeout=5s
    Click Element                    xpath=//div[@class='modal-content']//button[text()='Cancelar']

Navegar Para Pagina Montar Grade

    Wait Until Page Contains Element    xpath=//h2[text()='Selecione os horários nos dias que você tem preferência.']    timeout=15s

    Wait Until Element Is Visible    css=td.celula[data-horario="M1"][data-dia="2"]    timeout=15s
    
    Log To Console    Página de Montar Grade carregada e pronta, e células visíveis.a.

Selecionar Horario E Dia Na Grade
    [Arguments]    ${horario}    ${dia}
    ${locator}=    Catenate    SEPARATOR=    td.celula[data-horario="${horario}"][data-dia="${dia}"]
    
    Wait Until Element Is Visible    css=${locator}
    Scroll Element Into View    css=${locator} 
    Click Element    css=${locator}
    Log To Console    Clicou na celula: Horario=${horario}, Dia=${dia}

Clicar Botao Enviar Grade
    ${locator}=    Set Variable    xpath=//button[@type='submit' and text()='Enviar Disponibilidade']

    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Button    ${locator}
    
    Log To Console    Botão 'Enviar Disponibilidade' clicado.

Clicar Botao Limpar Selecao
    ${locator}=    Set Variable    xpath=//button[@type='button' and text()='Limpar Seleção']

    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Button    ${locator}
    
    Log To Console    Botão 'Limpar Seleção' clicado.