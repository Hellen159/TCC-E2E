@echo off
setlocal

REM Define o diretório dos testes
set TEST_DIR=tests

REM Define o diretório de saída para os relatórios
REM Criará uma pasta com a data e hora atual
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (set current_date=%%c%%b%%a)
for /f "tokens=1-2 delims=:" %%a in ('time /t') do (set current_time=%%a%%b)
set OUTPUT_DIR_NAME=%current_date%_%current_time%
set RESULTS_DIR=results\%OUTPUT_DIR_NAME%

REM Cria o diretório de resultados se não existir
if not exist %RESULTS_DIR% (
    mkdir %RESULTS_DIR%
)

echo.
echo ===================================================
echo INICIANDO A EXECUCAO DOS TESTES END-TO-END (E2E)
echo ===================================================
echo.
echo Diretorio dos testes: %TEST_DIR%
echo Diretorio de saida dos relatorios: %RESULTS_DIR%
echo.

REM Executa os testes do Robot Framework usando python -m robot
REM -d: Define o diretorio de saida para todos os relatorios
REM -o: Define o nome do arquivo XML de saida
REM -l: Define o nome do arquivo de log HTML
REM -r: Define o nome do arquivo de relatorio HTML
python -m robot ^
    -d %RESULTS_DIR% ^
    -o output.xml ^
    -l log.html ^
    -r report.html ^
    %TEST_DIR%

echo.
echo ===================================================
echo EXECUCAO CONCLUIDA
echo ===================================================
echo.

REM Verifica se o report.html foi gerado e o abre
if exist "%RESULTS_DIR%\report.html" (
    echo Abrindo o relatorio HTML...
    start "" "%RESULTS_DIR%\report.html"
) else (
    echo ERRO: O arquivo report.html nao foi gerado. Verifique os logs.
)

endlocal
pause