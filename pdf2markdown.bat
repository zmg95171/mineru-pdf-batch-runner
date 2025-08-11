@echo off
echo Starting MinerU...
echo.

:: 激活 Conda 环境
:: 注意: "d:\MinerU" 是您环境的安装路径(prefix)，使用此方式激活是正确的。
::       请确保您的 Conda 环境已正确初始化。
call conda activate d:\MinerU

:: 检查是否成功激活虚拟环境
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to activate the Conda environment.
    echo Please check if Conda is installed and the environment path is correct.
    pause
    exit /b 1
)
echo Conda environment 'd:\MinerU' activated successfully.
echo.

:: 提示用户输入 PDF 文件路径
echo Please enter the full path to the PDF file.
echo You can also drag and drop the file from your file explorer onto this window and press Enter.
set /p "PDF_FILE="

:: 移除用户可能输入的多余引号
set "PDF_FILE=%PDF_FILE:"=%"

:: 检查文件是否存在
if not exist "%PDF_FILE%" (
    echo [ERROR] The specified PDF file does not exist.
    echo Path given: "%PDF_FILE%"
    pause
    exit /b 1
)

:: 获取 PDF 文件所在的目录
for %%i in ("%PDF_FILE%") do set "PDF_DIR=%%~dpi"

:: 设置输出目录为 PDF 文件所在的目录
set "OUTPUT_DIR=%PDF_DIR%"

:: [最终修正] 删除输出目录末尾的反斜杠，以防止其转义引号
if "%OUTPUT_DIR:~-1%"=="\" set "OUTPUT_DIR=%OUTPUT_DIR:~0,-1%"

:: 设置日志文件路径 (不带引号，方便后续引用)
set "LOG_FILE=%PDF_DIR%minerus_log.txt"

:: 运行 MinerU 的命令
echo Running MinerU on "%PDF_FILE%"...
echo Writing log to "%LOG_FILE%"
echo.

:: 创建或清空日志文件，并记录开始时间
(
    echo %DATE% %TIME% - Starting processing of "%PDF_FILE%"
    echo -------------------------------------------------
) > "%LOG_FILE%"

magic-pdf -p "%PDF_FILE%" -o "%OUTPUT_DIR%" >> "%LOG_FILE%" 2>&1

:: 检查命令是否成功执行
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

:: 记录成功信息
(
    echo.
    echo -------------------------------------------------
    echo %DATE% %TIME% - Successfully processed "%PDF_FILE%".
) >> "%LOG_FILE%"

echo.
echo MinerU has finished processing the PDF file successfully.
echo Log file is saved at: "%LOG_FILE%"
pause