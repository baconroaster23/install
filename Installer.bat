@echo off
setlocal EnableDelayedExpansion
title Install
color 0A

set "OWNER=baconroaster23"
set "REPO=BatchManager"
set "BRANCH=main"

set "INSTALL=C:\Users\%USERNAME%\BatchManager"
set "ZIP=%TEMP%\BatchManager.zip"
set "TEMP=%TEMP%\BatchManager_Update"

echo =====================================
echo         BatchManager Updater
echo =====================================
echo.

echo [1/5] Checking for updates...

curl -L -s "https://github.com/%OWNER%/%REPO%/archive/refs/heads/%BRANCH%.zip" -o "%ZIP%" >nul 2>&1

if errorlevel 1 (
    cls
    echo =====================================
    echo         BatchManager Updater
    echo =====================================
    echo.
    echo Failed to download update.
    pause
    exit /b
)

echo [2/5] Preparing files...

if exist "%TEMP%" rmdir /s /q "%TEMP%" >nul 2>&1
mkdir "%TEMP%" >nul 2>&1

powershell -NoProfile -Command "Expand-Archive -Path '%ZIP%' -DestinationPath '%TEMP%' -Force" >nul 2>&1

echo [3/5] Installing update...

if exist "%INSTALL%" rmdir /s /q "%INSTALL%" >nul 2>&1

move "%TEMP%\%REPO%-%BRANCH%" "%INSTALL%" >nul

echo [4/5] Cleaning up...

del "%ZIP%" >nul 2>&1
rmdir /s /q "%TEMP%" >nul 2>&1

echo [5/5] Starting BatchManager...
timeout /t 2 >nul

start "" "%INSTALL%\BatchManager\BatchManager.bat"

exit
