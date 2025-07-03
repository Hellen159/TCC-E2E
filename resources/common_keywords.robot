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

# ---- KEYWORDS PARA "ESQUECEU A SENHA" ----

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
