@echo off
title World Monitor Launcher

echo Starting World Monitor Launcher...
echo.

REM Check for Node.js
where node >nul 2>nul
if %errorlevel% neq 0 goto NoNode

REM Check for node_modules
if exist "node_modules" goto ShowMenu

echo [Warning] dependencies not found (node_modules missing).
echo [Info] Running npm install...
echo ------------------------------------------
call npm install
if %errorlevel% neq 0 goto InstallError
echo [Success] Dependencies installed!
echo ------------------------------------------

:ShowMenu
echo.
echo ==========================================
echo       World Monitor Launcher
echo ==========================================
echo.
echo 1. World Monitor (Default)
echo 2. Tech Monitor
echo 3. Finance Monitor
echo 4. Happy Monitor
echo.

set /p choice="Enter number (1-4) [Default: 1]: "

if "%choice%"=="" set choice=1
if "%choice%"=="1" goto RunDefault
if "%choice%"=="2" goto RunTech
if "%choice%"=="3" goto RunFinance
if "%choice%"=="4" goto RunHappy

goto RunDefault

:RunDefault
set cmd=npm run dev
goto RunCmd

:RunTech
set cmd=npm run dev:tech
goto RunCmd

:RunFinance
set cmd=npm run dev:finance
goto RunCmd

:RunHappy
set cmd=npm run dev:happy
goto RunCmd

:RunCmd
echo.
echo [Starting] Running: %cmd%
echo.
call %cmd%
if %errorlevel% neq 0 goto RunError
goto End

:NoNode
echo.
echo [ERROR] Node.js not found!
echo Please install Node.js from https://nodejs.org/
echo.
pause
exit /b

:InstallError
echo.
echo [ERROR] npm install failed.
echo Please check your internet connection.
echo.
pause
exit /b

:RunError
echo.
echo [ERROR] Application failed to start.
echo.
pause
exit /b

:End
echo.
echo Press any key to exit...
pause >nul

