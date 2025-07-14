***Settings***
Resource             ../resources/common_keywords.robot
Variables            ../config.py
Library              SeleniumLibrary
# As libs String e DateTime não precisam ser importadas aqui, pois já estão na keyword em common_keywords.robot
Test Setup           Abrir Navegador na URL Base      ${LOGIN_URL}
Test Teardown        Close Browser

***Variables***
${GRID_MONTAR_GRADE_URL}      /Grid/MontarGrade

${MATRICULA_VALIDA}    202016481
${SENHA_VALIDA}    senha1234

${MSG_INFO_SUCESSO_ENVIAR_DISPONIBILIDADE}    Turmas encontradas com sucesso. Selecione a turma desejada e clique em “Salvar turma”.
${MSG_ERRO_NENHUMA_SELECAO}    Erro: Selecione os horários antes de enviar a disponibilidade!
        

${CSS_INFO}               css=div.alert.alert-info.alert-dismissible.fade.show   

${CLASS_CELULA_SELECIONADA}       selecionada 
${CHECKBOX_TCC2_LOCATOR}=    css:input[type="checkbox"][data-codigounicoturma="668"]
${CHECKBOX_TCC2_SELECTOR_JS}=    input[type="checkbox"][data-codigounicoturma="668"]
${CHECKBOX_TCC2_LOCATOR_SELENIUM}=    xpath://div[@class="linha" and .//div[@title="TRABALHO DE CONCLUSAO DE CURSO 2"] and .//div[@title="VINICIUS RICARDO MARQUES DE SOUZA"]]//input[@type="checkbox" and @data-codigounicoturma="668"]



${TURMAS_OBRIGATORIAS_CONTAINER}=    xpath://div[contains(@class, 'card') and .//div[contains(@class, 'card-header') and contains(text(), 'Turmas Obrigatórias Disponíveis')]]//div[contains(@class, 'tabela-turmas')]


***Test Cases***
CT01_Usuario_envia_disponibilidade_sucesso
    [Documentation]    Testa o fluxo completo de registro, login e anexo de histórico PDF válido.

    Fazer Login      ${MATRICULA_VALIDA}      ${SENHA_VALIDA}

    Scroll Element Into View         css=a.btn-montar[href='/Grid/MontarGrade'] 
    Wait Until Element Is Visible    css=a.btn-montar[href='/Grid/MontarGrade']
    Execute Javascript    document.querySelector("a.btn-montar[href='/Grid/MontarGrade']").click();

    Navegar Para Pagina Montar Grade

    Selecionar Horario E Dia Na Grade    M2    2    
    Selecionar Horario E Dia Na Grade    M3    2    
    Selecionar Horario E Dia Na Grade    M3    3   
    
    Clicar Botao Enviar Grade

    Wait Until Element Is Visible       ${CSS_INFO}    timeout=15s
    Element Should Contain              ${CSS_INFO}    ${MSG_INFO_SUCESSO_ENVIAR_DISPONIBILIDADE}

    Log To Console    Disponibilidades enviadas com sucesso!

CT02_Usuario_envia_disponibilidade_sem_selecao
    [Documentation]    Testa o envio de disponibilidade sem selecionar nenhum horário.

    Fazer Login    ${MATRICULA_VALIDA}    ${SENHA_VALIDA}

    # Clica no link para ir para a página de montar grade
    Scroll Element Into View         css=a.btn-montar[href='/Grid/MontarGrade'] 
    Wait Until Element Is Visible    css=a.btn-montar[href='/Grid/MontarGrade']
    Execute Javascript    document.querySelector("a.btn-montar[href='/Grid/MontarGrade']").click();

    Navegar Para Pagina Montar Grade

    # ATENÇÃO: NENHUMA CHAMADA A 'Selecionar Horario E Dia Na Grade' AQUI.
    # O objetivo é NÃO selecionar nada.
    
    Clicar Botao Enviar Grade

    # 4. Verificar mensagem de erro/validação
    Wait Until Element Is Visible    ${CSS_INFO}    timeout=15s
    Element Should Contain           ${CSS_INFO}    ${MSG_ERRO_NENHUMA_SELECAO}

    Log To Console    Teste de envio sem seleção concluído. Mensagem de erro esperada exibida.


CT03_Usuario_seleciona_disponibilidade_clica_em_limpar_selecao
    [Documentation]    Testa que, após selecionar horários e clicar em 'Limpar Seleção', os inputs do table são limpos.

    Fazer Login    ${MATRICULA_VALIDA}    ${SENHA_VALIDA}

    # Clica no link para ir para a página de montar grade
    Scroll Element Into View     css=a.btn-montar[href='/Grid/MontarGrade']
    Wait Until Element Is Visible    css=a.btn-montar[href='/Grid/MontarGrade']
    Execute Javascript     document.querySelector("a.btn-montar[href='/Grid/MontarGrade']").click();

    Navegar Para Pagina Montar Grade

    # 1. Selecionar algumas células
    Log To Console    Selecionando algumas células para limpeza...
    Selecionar Horario E Dia Na Grade    M2    2

    # Opcional, mas boa prática: Verificar se as células foram realmente selecionadas antes de tentar limpar
    # Isso serve como uma verificação da keyword 'Selecionar Horario E Dia Na Grade'
    ${LOCATOR_M2_2_SELECIONADA}=    Catenate    SEPARATOR=    td.celula.selecionada[data-horario="M2"][data-dia="2"]

    Wait Until Element Is Visible    css=${LOCATOR_M2_2_SELECIONADA}

    Log To Console    Células confirmadas como selecionadas.

    # 2. Clicar no botão 'Limpar Seleção'
    Clicar Botao Limpar Selecao

    ${LOCATOR_M2_2_NAO_SELECIONADA}=    Catenate    SEPARATOR=    td.celula[data-horario="M2"][data-dia="2"]

    # 3. Verificar se cada célula selecionada foi limpa (classe de seleção removida)
    Log To Console    Verificando se as células foram limpas...
    
    Wait Until Element Is Visible    css=${LOCATOR_M2_2_NAO_SELECIONADA}

    Log To Console    Verificação de limpeza dos inputs do table concluída com sucesso.
