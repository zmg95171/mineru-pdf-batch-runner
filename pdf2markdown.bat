@echo off
echo Starting MinerU...
echo.

:: ���� Conda ����
:: ע��: "d:\MinerU" ���������İ�װ·��(prefix)��ʹ�ô˷�ʽ��������ȷ�ġ�
::       ��ȷ������ Conda ��������ȷ��ʼ����
call conda activate d:\MinerU

:: ����Ƿ�ɹ��������⻷��
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to activate the Conda environment.
    echo Please check if Conda is installed and the environment path is correct.
    pause
    exit /b 1
)
echo Conda environment 'd:\MinerU' activated successfully.
echo.

:: ��ʾ�û����� PDF �ļ�·��
echo Please enter the full path to the PDF file.
echo You can also drag and drop the file from your file explorer onto this window and press Enter.
set /p "PDF_FILE="

:: �Ƴ��û���������Ķ�������
set "PDF_FILE=%PDF_FILE:"=%"

:: ����ļ��Ƿ����
if not exist "%PDF_FILE%" (
    echo [ERROR] The specified PDF file does not exist.
    echo Path given: "%PDF_FILE%"
    pause
    exit /b 1
)

:: ��ȡ PDF �ļ����ڵ�Ŀ¼
for %%i in ("%PDF_FILE%") do set "PDF_DIR=%%~dpi"

:: �������Ŀ¼Ϊ PDF �ļ����ڵ�Ŀ¼
set "OUTPUT_DIR=%PDF_DIR%"

:: [��������] ɾ�����Ŀ¼ĩβ�ķ�б�ܣ��Է�ֹ��ת������
if "%OUTPUT_DIR:~-1%"=="\" set "OUTPUT_DIR=%OUTPUT_DIR:~0,-1%"

:: ������־�ļ�·�� (�������ţ������������)
set "LOG_FILE=%PDF_DIR%minerus_log.txt"

:: ���� MinerU ������
echo Running MinerU on "%PDF_FILE%"...
echo Writing log to "%LOG_FILE%"
echo.

:: �����������־�ļ�������¼��ʼʱ��
(
    echo %DATE% %TIME% - Starting processing of "%PDF_FILE%"
    echo -------------------------------------------------
) > "%LOG_FILE%"

magic-pdf -p "%PDF_FILE%" -o "%OUTPUT_DIR%" >> "%LOG_FILE%" 2>&1

:: ��������Ƿ�ɹ�ִ��
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to run MinerU. Please check the log file for details.
    (
        echo.
        echo %DATE% %TIME% - [ERROR] Failed to run MinerU.
    ) >> "%LOG_FILE%"
    echo Log file is located at: "%LOG_FILE%"
    pause
    exit /b 1
)

:: ��¼�ɹ���Ϣ
(
    echo.
    echo -------------------------------------------------
    echo %DATE% %TIME% - Successfully processed "%PDF_FILE%".
) >> "%LOG_FILE%"

echo.
echo MinerU has finished processing the PDF file successfully.
echo Log file is saved at: "%LOG_FILE%"
pause