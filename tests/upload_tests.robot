***Settings***
Resource             ../resources/common_keywords.robot
Variables            ../config.py
Library              SeleniumLibrary
# As libs String e DateTime não precisam ser importadas aqui, pois já estão na keyword em common_keywords.robot
Test Setup           Abrir Navegador na URL Base      ${REGISTER_URL}
Test Teardown        Close Browser

***Variables***
${FORM_UPLOAD_HISTORICO_URL}      /Upload/UploadHistorico

${CAMINHO_PDF_VALIDO}    C:/Users/Hellen/Documents/Estudos/TCC/historicosUnb/meu.pdf
${CAMINHO_ARQUIVO_NAO_PDF}    C:/Users/Hellen/Downloads/banco_tcc_v3.png
${CAMINHO_PDF_VAZIO}    C:/Users/Hellen/Downloads/pdf_vazio.pdf
${CAMINHO_PDF_NAO_HISTORICO}    C:/Users/Hellen/Downloads/R_1 _Grupo 6.pdf

${MSG_SUCESSO_PROCESSAR_HISTORICO}    Histórico processado com sucesso!
${MSG_ERRO_ARQUIVO_INVALIDO}    Erro ao processar o arquivo: PDF header not found.. Detalhes internos: sem inner exception
${MSG_ERRO_ARQUIVO_VAZIO}    Nenhum arquivo enviado.
${MSG_ERRO_CONTEUDO_NAO_HISTORICO}    Formato de histórico inválido ou nenhum dado encontrado.
          

# Identificadores de elementos
${ID_INPUT_HISTORICO}            id=historico
${CSS_ALERTA_SUCESSO}            css=div.alert.alert-success
${CSS_ALERTA_ERRO}               css=div.alert.alert-danger.fixed-top.text-center


        
***Test Cases***
CT01_Primeiro_acesso_usuario_anexa_historico_sucesso
    [Documentation]    Testa o fluxo completo de registro, login e anexo de histórico PDF válido.

    ${NOME_COMPLETO}    ${EMAIL}    ${SENHA}    ${MATRICULA}    ${SEMESTRE}    ${ANO}=    Gerar Dados De Registro

    # 1. Registrar o novo usuário
    Registrar Novo Usuario Com Dados    ${NOME_COMPLETO}    ${EMAIL}    ${SENHA}    ${MATRICULA}    ${SEMESTRE}    ${ANO}

    # 2. Fazer Login com o usuário recém-criado
    Fazer Login Do Usuario    ${MATRICULA}    ${SENHA}

    # 3. Navegar para a página de upload de histórico
    Navegar Para Pagina De Upload    ${FORM_UPLOAD_HISTORICO_URL}

    # 4. Anexar o arquivo PDF
    Choose File    ${ID_INPUT_HISTORICO}    ${CAMINHO_PDF_VALIDO}

    # 6. Verificar mensagem de sucesso
    Wait Until Element Is Visible       ${CSS_ALERTA_SUCESSO}    timeout=15s
    Element Should Contain              ${CSS_ALERTA_SUCESSO}    ${MSG_SUCESSO_PROCESSAR_HISTORICO}

    Log To Console    Primeiro acesso efetuado e historico anexado com sucesso!

CT02_Upload_historico_arquivo_nao_pdf
    [Documentation]    Verifica a validação para upload de arquivo com formato inválido (não-PDF).
    
    # Pre-requisito: Registrar e logar um usuário, ou usar um usuário existente para agilizar.
    ${NOME_COMPLETO}    ${EMAIL}    ${SENHA}    ${MATRICULA}    ${SEMESTRE}    ${ANO}=    Gerar Dados De Registro
    Registrar Novo Usuario Com Dados    ${NOME_COMPLETO}    ${EMAIL}    ${SENHA}    ${MATRICULA}    ${SEMESTRE}    ${ANO}
    Fazer Login Do Usuario    ${MATRICULA}    ${SENHA}
    # Log To Console      Novo usuário registrado com sucesso: Email=${MATRICULA}, Matrícula=${SENHA}
    Navegar Para Pagina De Upload    ${FORM_UPLOAD_HISTORICO_URL}

    # Anexar arquivo que não é PDF
    Choose File    ${ID_INPUT_HISTORICO}    ${CAMINHO_ARQUIVO_NAO_PDF}

    # Verificar mensagem de erro
    Wait Until Element Is Visible       ${CSS_ALERTA_ERRO}    timeout=15s
    Element Should Contain              ${CSS_ALERTA_ERRO}    ${MSG_ERRO_ARQUIVO_INVALIDO}
    Log To Console    Teste de formato inválido concluído.

CT03_Upload_historico_arquivo_vazio
    [Documentation]    Verifica a validação para upload de arquivo PDF vazio.
    
    # Pre-requisito: Registrar e logar um usuário, ou usar um usuário existente.
    ${NOME_COMPLETO}    ${EMAIL}    ${SENHA}    ${MATRICULA}    ${SEMESTRE}    ${ANO}=    Gerar Dados De Registro
    Registrar Novo Usuario Com Dados    ${NOME_COMPLETO}    ${EMAIL}    ${SENHA}    ${MATRICULA}    ${SEMESTRE}    ${ANO}
    Fazer Login Do Usuario    ${MATRICULA}    ${SENHA}
    Navegar Para Pagina De Upload    ${FORM_UPLOAD_HISTORICO_URL}

    # Anexar arquivo PDF vazio
    Choose File    ${ID_INPUT_HISTORICO}    ${CAMINHO_PDF_VAZIO}

    # Verificar mensagem de erro
    Wait Until Element Is Visible       ${CSS_ALERTA_ERRO}    timeout=15s
    Element Should Contain              ${CSS_ALERTA_ERRO}    ${MSG_ERRO_ARQUIVO_VAZIO}
    Log To Console    Teste de arquivo vazio concluído.

CT04_Upload_historico_PDF_conteudo_nao_relevante
    [Documentation]    Verifica a validação de negócio para upload de PDF válido mas com conteúdo não-histórico.
    
    ${NOME_COMPLETO}    ${EMAIL}    ${SENHA}    ${MATRICULA}    ${SEMESTRE}    ${ANO}=    Gerar Dados De Registro
    Registrar Novo Usuario Com Dados    ${NOME_COMPLETO}    ${EMAIL}    ${SENHA}    ${MATRICULA}    ${SEMESTRE}    ${ANO}
    Fazer Login Do Usuario    ${MATRICULA}    ${SENHA}
    Navegar Para Pagina De Upload    ${FORM_UPLOAD_HISTORICO_URL}

    Choose File    ${ID_INPUT_HISTORICO}    ${CAMINHO_PDF_NAO_HISTORICO}

    Wait Until Element Is Visible       ${CSS_ALERTA_ERRO}    timeout=15s
    Element Should Contain              ${CSS_ALERTA_ERRO}    ${MSG_ERRO_CONTEUDO_NAO_HISTORICO}
    Log To Console    Teste de conteúdo não-histórico concluído.