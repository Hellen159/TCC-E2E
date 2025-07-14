***Settings***
Resource             ../resources/common_keywords.robot
Variables            ../config.py
Test Setup           Abrir Navegador na URL Base      ${LOGIN_URL}
Test Teardown        Close Browser

***Variables***
${MATRICULA_VALIDA}      202016481
${SENHA_VALIDA}          senha1234
${MATRICULA_INVALIDA}    999999999
${SENHA_INVALIDA}        senhaerrada
${EMAIL_VALIDO_RECUPERACAO}    202016480@aluno.unb.br
${EMAIL_INVALIDO_RECUPERACAO}    202016480@aluno.unb.brqqqqq

${ERRO_MATRICULA_OBRIGATORIA_LOGIN}    A matrícula é obrigatória.
${ERRO_SENHA_OBRIGATORIA_LOGIN}        A senha é obrigatória.
${ERRO_CREDENCIAS_INVALIDAS}           Usuário ou senha incorretos.
${MENSAGEM_RECUPERACAO_SUCESSO_OU_GENERICA}    Se o e-mail estiver cadastrado, você receberá um link de redefinição de senha.

***Test Cases***
CT01_Login_com_Sucesso
    Fazer Login      ${MATRICULA_VALIDA}      ${SENHA_VALIDA}
    Verificar Redirecionamento Para Home
    Log To Console   Login efetuado e página inicial carregada com sucesso!

CT02_Login_Matricula_Vazia
    Input Text       id=Senha      ${SENHA_VALIDA}
    Click Button    css=button[type='submit']

    Verificar Permanencia Na Pagina De Login
    Wait Until Element Is Visible    css=span[data-valmsg-for='Matricula']
    Element Should Contain           css=span[data-valmsg-for='Matricula']    ${ERRO_MATRICULA_OBRIGATORIA_LOGIN}
    Log To Console   Teste de Matrícula Vazia: Falhou como esperado.

CT03_Login_Senha_Vazia
    Input Text       id=Matricula    ${MATRICULA_VALIDA}
    Click Button    css=button[type='submit']

    Verificar Permanencia Na Pagina De Login
    Wait Until Element Is Visible    css=span[data-valmsg-for='Senha']
    Element Should Contain           css=span[data-valmsg-for='Senha']    ${ERRO_SENHA_OBRIGATORIA_LOGIN}
    Log To Console   Teste de Senha Vazia: Falhou como esperado.

CT04_Login_Matricula_Invalida
   Preencher Credenciais E Clicar Login    ${MATRICULA_INVALIDA}    ${SENHA_VALIDA}

    Verificar Permanencia Na Pagina De Login
    Wait Until Element Is Visible    css=div.alert.alert-danger    timeout=15s
    Element Should Contain           css=div.alert.alert-danger    ${ERRO_CREDENCIAS_INVALIDAS}
    Log To Console   Teste de Matrícula Inválida: Falhou como esperado.

CT05_Login_Senha_Invalida
    Preencher Credenciais E Clicar Login      ${MATRICULA_VALIDA}    ${SENHA_INVALIDA}

    Verificar Permanencia Na Pagina De Login
    Wait Until Element Is Visible    css=div.alert.alert-danger
    Element Should Contain           css=div.alert.alert-danger    ${ERRO_CREDENCIAS_INVALIDAS}
    Log To Console   Teste de Senha Inválida: Falhou como esperado.

CT06_Login_Campos_Vazios
    Click Button    css=button[type='submit']

    Verificar Permanencia Na Pagina De Login
    Wait Until Element Is Visible    css=span[data-valmsg-for='Matricula']
    Element Should Contain           css=span[data-valmsg-for='Matricula']    ${ERRO_MATRICULA_OBRIGATORIA_LOGIN}
    Wait Until Element Is Visible    css=span[data-valmsg-for='Senha']
    Element Should Contain           css=span[data-valmsg-for='Senha']        ${ERRO_SENHA_OBRIGATORIA_LOGIN}
    Log To Console   Teste de Campos Vazios: Falhou como esperado.

CT07_Esqueceu_Senha_Email_Valido
    Clicar Link Esqueceu Senha
    Preencher Email NoModal De Recuperacao    ${EMAIL_VALIDO_RECUPERACAO}
    Clicar Botao Enviar NoModal De Recuperacao

    Wait Until Element Is Visible    css=div.alert.alert-success    timeout=15s
 
    Element Should Contain           css=div.alert.alert-success    ${MENSAGEM_RECUPERACAO_SUCESSO_OU_GENERICA}
    Log To Console                   Solicitação de recuperação de senha para email válido processada.

CT08_Esqueceu_Senha_Email_Invalido
    Clicar Link Esqueceu Senha
    Preencher Email NoModal De Recuperacao    ${EMAIL_INVALIDO_RECUPERACAO}
    Clicar Botao Enviar NoModal De Recuperacao

    Wait Until Element Is Visible    css=div.alert.alert-success    timeout=15s
    Element Should Contain           css=div.alert.alert-success    ${MENSAGEM_RECUPERACAO_SUCESSO_OU_GENERICA}
    Log To Console                   Solicitação de recuperação de senha para email inválido processada.

