***Settings***
Resource             ../resources/common_keywords.robot
Variables            ../config.py
Library              SeleniumLibrary
# As libs String e DateTime não precisam ser importadas aqui, pois já estão na keyword em common_keywords.robot
Test Setup           Abrir Navegador na URL Base      ${REGISTER_URL}
Test Teardown        Close Browser

***Variables***
# Mensagens de erro esperadas (ajuste conforme o texto exato da sua aplicação)
${ERRO_NOME_OBRIGATORIO}          O campo Nome Completo é obrigatório.
${ERRO_EMAIL_OBRIGATORIO}         O campo Email é obrigatório.
${ERRO_SEMESTRE_OBRIGATORIO}      Este campo precisa ser preenchido.
${ERRO_ANO_OBRIGATORIO}           Este campo precisa ser preenchido.
${ERRO_SENHA_OBRIGATORIO}         O campo Senha é obrigatório.
${ERRO_CONFIRMACAO_SENHA_OBRIGATORIO}    O campo Confirme a Senha é obrigatório.
${ERRO_MATRICULA_OBRIGATORIO}     O campo Matrícula é obrigatório.
${ERRO_SENHAS_NAO_COINCIDEM}      As senhas não coincidem.

***Test Cases***
CT01_Registro_de_Novo_Usuario_com_Sucesso
    # 1. Gerar dados de registro
    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}=    Gerar Dados De Registro

    # 2. Preencher os campos do formulário
    Input Text          id=Nome                 ${NOME_COMPLETO}
    Input Text          id=Email                ${EMAIL_ALEATORIO}
    Select From List By Value    id=SemestreEntrada    ${SEMESTRE_ALEATORIO}
    Select From List By Value    id=AnoEntrada         ${ANO_ALEATORIO}
    Input Text          id=Senha                ${SENHA_ALEATORIA}
    Input Text          id=ConfirmacaoSenha     ${SENHA_ALEATORIA}
    Input Text          id=Matricula            ${MATRICULA_ALEATORIA}

    # 3. Clicar no botão "Registrar"
    Click Button        css=button[type='submit']

    # 4. Verificar se o registro foi bem-sucedido
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Login
    Page Should Contain                 Não tem uma conta? Fazer Registro    # Ou o texto que você identificou para a tela de login
    Log To Console      Novo usuário registrado com sucesso: Email=${EMAIL_ALEATORIO}, Matrícula=${MATRICULA_ALEATORIA}


CT02_Registro_Nome_Completo_Nao_Preenchido
    # 1. Gerar dados completos, mas vamos sobrescrever o Nome para ficar vazio
    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}=    Gerar Dados De Registro
    # NOME VAZIO: Não preencher o campo nome.
    # Input Text          id=Nome                 ${EMPTY} # Poderia usar assim, mas a ausência já é o suficiente.

    # 2. Preencher os campos do formulário (Nome será omitido)
    Input Text          id=Email                ${EMAIL_ALEATORIO}
    Select From List By Value    id=SemestreEntrada    ${SEMESTRE_ALEATORIO}
    Select From List By Value    id=AnoEntrada         ${ANO_ALEATORIO}
    Input Text          id=Senha                ${SENHA_ALEATORIA}
    Input Text          id=ConfirmacaoSenha     ${SENHA_ALEATORIA}
    Input Text          id=Matricula            ${MATRICULA_ALEATORIA}

    # 3. Clicar no botão "Registrar"
    Click Button        css=button[type='submit']

    # 4. Verificações de falha:
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Formulário de Registro
    Wait Until Element Is Visible       css=span[data-valmsg-for='Nome']
    Element Should Contain              css=span[data-valmsg-for='Nome']    ${ERRO_NOME_OBRIGATORIO}
    Log To Console      Teste de Nome Vazio: Falhou como esperado.


CT03_Registro_Email_Nao_Preenchido
    # 1. Gerar dados completos, mas vamos sobrescrever o Email para ficar vazio
    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}=    Gerar Dados De Registro
    # EMAIL VAZIO:
    # Input Text          id=Email                ${EMPTY}

    # 2. Preencher os campos do formulário
    Input Text          id=Nome                 ${NOME_COMPLETO}
    Select From List By Value    id=SemestreEntrada    ${SEMESTRE_ALEATORIO}
    Select From List By Value    id=AnoEntrada         ${ANO_ALEATORIO}
    Input Text          id=Senha                ${SENHA_ALEATORIA}
    Input Text          id=ConfirmacaoSenha     ${SENHA_ALEATORIA}
    Input Text          id=Matricula            ${MATRICULA_ALEATORIA}

    # 3. Clicar no botão "Registrar"
    Click Button        css=button[type='submit']

    # 4. Verificações de falha:
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Formulário de Registro
    Wait Until Element Is Visible       css=span[data-valmsg-for='Email']
    Element Should Contain              css=span[data-valmsg-for='Email']    ${ERRO_EMAIL_OBRIGATORIO}
    Log To Console      Teste de Email Vazio: Falhou como esperado.


CT04_Registro_Semestre_Entrada_Nao_Preenchido
    # 1. Gerar dados completos
    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}=    Gerar Dados De Registro

    # 2. Preencher os campos do formulário
    Input Text          id=Nome                 ${NOME_COMPLETO}
    Input Text          id=Email                ${EMAIL_ALEATORIO}
    Select From List By Value    id=AnoEntrada         ${ANO_ALEATORIO}
    Input Text          id=Senha                ${SENHA_ALEATORIA}
    Input Text          id=ConfirmacaoSenha     ${SENHA_ALEATORIA}
    Input Text          id=Matricula            ${MATRICULA_ALEATORIA}

    # 3. Clicar no botão "Registrar"
    Click Button        css=button[type='submit']

    # 4. Verificações de falha:
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Formulário de Registro
    Wait Until Element Is Visible       css=span[data-valmsg-for='SemestreEntrada']
    Element Should Contain              css=span[data-valmsg-for='SemestreEntrada']    ${ERRO_SEMESTRE_OBRIGATORIO}
    Log To Console      Teste de Semestre Vazio: Falhou como esperado.


CT05_Registro_Ano_Entrada_Nao_Preenchido
    # 1. Gerar dados completos
    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}=    Gerar Dados De Registro

    # 2. Preencher os campos do formulário
    Input Text          id=Nome                 ${NOME_COMPLETO}
    Input Text          id=Email                ${EMAIL_ALEATORIO}
    Select From List By Value    id=SemestreEntrada    ${SEMESTRE_ALEATORIO}
    Input Text          id=Senha                ${SENHA_ALEATORIA}
    Input Text          id=ConfirmacaoSenha     ${SENHA_ALEATORIA}
    Input Text          id=Matricula            ${MATRICULA_ALEATORIA}

    # 3. Clicar no botão "Registrar"
    Click Button        css=button[type='submit']

    # 4. Verificações de falha:
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Formulário de Registro
    Wait Until Element Is Visible       css=span[data-valmsg-for='AnoEntrada']
    Element Should Contain              css=span[data-valmsg-for='AnoEntrada']    ${ERRO_ANO_OBRIGATORIO}
    Log To Console      Teste de Ano Vazio: Falhou como esperado.


CT06_Registro_Senha_Nao_Preenchida
    # 1. Gerar dados completos
    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}=    Gerar Dados De Registro

    # 2. Preencher os campos do formulário
    Input Text          id=Nome                 ${NOME_COMPLETO}
    Input Text          id=Email                ${EMAIL_ALEATORIO}
    Select From List By Value    id=SemestreEntrada    ${SEMESTRE_ALEATORIO}
    Select From List By Value    id=AnoEntrada         ${ANO_ALEATORIO}
    # SENHA VAZIA:
    # Input Text          id=Senha                ${EMPTY}
    Input Text          id=ConfirmacaoSenha     ${SENHA_ALEATORIA} # Confirmação da Senha precisa ser preenchida para testar apenas a Senha
    Input Text          id=Matricula            ${MATRICULA_ALEATORIA}

    # 3. Clicar no botão "Registrar"
    Click Button        css=button[type='submit']

    # 4. Verificações de falha:
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Formulário de Registro
    Wait Until Element Is Visible       css=span[data-valmsg-for='Senha']
    Element Should Contain              css=span[data-valmsg-for='Senha']    ${ERRO_SENHA_OBRIGATORIO}
    Log To Console      Teste de Senha Vazia: Falhou como esperado.


CT07_Registro_Confirmacao_Senha_Nao_Preenchido
    # 1. Gerar dados completos
    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}=    Gerar Dados De Registro

    # 2. Preencher os campos do formulário
    Input Text          id=Nome                 ${NOME_COMPLETO}
    Input Text          id=Email                ${EMAIL_ALEATORIO}
    Select From List By Value    id=SemestreEntrada    ${SEMESTRE_ALEATORIO}
    Select From List By Value    id=AnoEntrada         ${ANO_ALEATORIO}
    Input Text          id=Senha                ${SENHA_ALEATORIA}
    # CONFIRMAR SENHA VAZIA:
    # Input Text          id=ConfirmacaoSenha     ${EMPTY}
    Input Text          id=Matricula            ${MATRICULA_ALEATORIA}

    # 3. Clicar no botão "Registrar"
    Click Button        css=button[type='submit']

    # 4. Verificações de falha:
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Formulário de Registro
    Wait Until Element Is Visible       css=span[data-valmsg-for='ConfirmacaoSenha']
    Element Should Contain              css=span[data-valmsg-for='ConfirmacaoSenha']    ${ERRO_CONFIRMACAO_SENHA_OBRIGATORIO}
    Log To Console      Teste de Confirmar Senha Vazia: Falhou como esperado.


CT08_Registro_Senhas_Nao_Coincidem
    # 1. Gerar dados completos, mas com senhas diferentes
    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA_BASE}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}=    Gerar Dados De Registro

    # Gerar uma segunda senha diferente da primeira
    ${SENHA_DIFERENTE}=    Generate Random String    10    [LETTERS]

    # 2. Preencher os campos do formulário
    Input Text          id=Nome                 ${NOME_COMPLETO}
    Input Text          id=Email                ${EMAIL_ALEATORIO}
    Select From List By Value    id=SemestreEntrada    ${SEMESTRE_ALEATORIO}
    Select From List By Value    id=AnoEntrada         ${ANO_ALEATORIO}
    Input Text          id=Senha                ${SENHA_ALEATORIA_BASE}
    Input Text          id=ConfirmacaoSenha     ${SENHA_DIFERENTE}
    Input Text          id=Matricula            ${MATRICULA_ALEATORIA}

    # 3. Clicar no botão "Registrar"
    Click Button        css=button[type='submit']

    # 4. Verificações de falha:
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Formulário de Registro
    Wait Until Element Is Visible       css=span[data-valmsg-for='ConfirmacaoSenha']
    Element Should Contain              css=span[data-valmsg-for='ConfirmacaoSenha']    ${ERRO_SENHAS_NAO_COINCIDEM}
    Log To Console      Teste de Senhas Não Coincidem: Falhou como esperado.


CT09_Registro_Matricula_Nao_Preenchida
    # 1. Gerar dados completos, mas vamos sobrescrever a Matrícula para ficar vazia
    ${NOME_COMPLETO}    ${EMAIL_ALEATORIO}    ${SENHA_ALEATORIA}    ${MATRICULA_ALEATORIA}    ${SEMESTRE_ALEATORIO}    ${ANO_ALEATORIO}=    Gerar Dados De Registro
    # MATRICULA VAZIA:
    # Input Text          id=Matricula            ${EMPTY}

    # 2. Preencher os campos do formulário
    Input Text          id=Nome                 ${NOME_COMPLETO}
    Input Text          id=Email                ${EMAIL_ALEATORIO}
    Select From List By Value    id=SemestreEntrada    ${SEMESTRE_ALEATORIO}
    Select From List By Value    id=AnoEntrada         ${ANO_ALEATORIO}
    Input Text          id=Senha                ${SENHA_ALEATORIA}
    Input Text          id=ConfirmacaoSenha     ${SENHA_ALEATORIA}

    # 3. Clicar no botão "Registrar"
    Click Button        css=button[type='submit']

    # 4. Verificações de falha:
    Wait Until Page Contains Element    css=h3.form-title    timeout=10s
    Element Should Contain              css=h3.form-title    Formulário de Registro
    Wait Until Element Is Visible       css=span[data-valmsg-for='Matricula']
    Element Should Contain              css=span[data-valmsg-for='Matricula']    ${ERRO_MATRICULA_OBRIGATORIO}
    Log To Console      Teste de Matrícula Vazia: Falhou como esperado.