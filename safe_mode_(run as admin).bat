@echo off
setlocal

:: First, check if we're in Safe Mode without using bcdedit (which might need admin)
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Option" /v OptionValue >nul 2>&1
if %errorLevel% == 0 goto safemode_menu

:: If not in Safe Mode, check if we have admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This tool requires administrator privileges.
    echo Please right-click and select "Run as administrator"
    pause
    exit /b 1
)

goto normalmode_menu

:safemode_menu
echo.
echo ========================================
echo         SAFE MODE BOOT MANAGER
echo ========================================
echo.
echo Current mode: SAFE MODE
echo.
echo [1] Restart in NORMAL MODE
echo [2] Restart in SAFE MODE ^(Minimal^)
echo [3] Restart in SAFE MODE with NETWORKING
echo [4] Exit
echo.
choice /c 1234 /n /m "Select option: "

if errorlevel 4 goto cancel
if errorlevel 3 goto safe_network
if errorlevel 2 goto safe_minimal
if errorlevel 1 goto restart_normal

:normalmode_menu
echo.
echo ========================================
echo         SAFE MODE BOOT MANAGER
echo ========================================
echo.
echo Current mode: NORMAL MODE
echo.
echo [1] Restart in SAFE MODE ^(Minimal^)
echo [2] Restart in SAFE MODE with NETWORKING
echo [3] Exit
echo.
choice /c 123 /n /m "Select option: "

if errorlevel 3 goto cancel
if errorlevel 2 goto safe_network
if errorlevel 1 goto safe_minimal

:restart_normal
echo Removing safe boot configuration...
bcdedit /deletevalue {current} safeboot >nul 2>&1
bcdedit /deletevalue {current} safebootnetwork >nul 2>&1
echo Safe boot configuration removed.
echo Computer will restart in normal mode in 5 seconds...
shutdown /r /t 5
echo Press Ctrl+C to cancel restart
pause >nul
goto :eof

:restart_safe
echo Computer will restart in safe mode in 5 seconds...
shutdown /r /t 5
echo Press Ctrl+C to cancel restart
pause >nul
goto :eof

:safe_minimal
echo Configuring safe boot (minimal)...
bcdedit /set {current} safeboot minimal >nul 2>&1
echo Safe boot configured.
echo Computer will restart in safe mode in 5 seconds...
shutdown /r /t 5
echo Press Ctrl+C to cancel restart
pause >nul
goto :eof

:safe_network
echo Configuring safe boot with networking...
bcdedit /set {current} safeboot network >nul 2>&1
echo Safe boot with networking configured.
echo Computer will restart in safe mode with networking in 5 seconds...
shutdown /r /t 5
echo Press Ctrl+C to cancel restart
pause >nul
goto :eof

:cancel
echo Operation cancelled.
pause
goto :eof