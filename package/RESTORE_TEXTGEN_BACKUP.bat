@echo off
setlocal EnableExtensions
cd /d "%~dp0"

title Restore TextGen llama.cpp

echo.
echo ============================================================
echo  RESTORE PREVIOUS TEXTGEN LLAMA.CPP
echo ============================================================
echo.

if not exist "%~dp0LAST_TEXTGEN_INSTALL.txt" (
    echo ERROR:
    echo LAST_TEXTGEN_INSTALL.txt was not found.
    echo.
    pause
    exit /b 1
)

set "TARGET="
set "BACKUP="

set /p TARGET=<"%~dp0LAST_TEXTGEN_INSTALL.txt"

for /f "usebackq skip=1 delims=" %%I in ("%~dp0LAST_TEXTGEN_INSTALL.txt") do (
    if not defined BACKUP set "BACKUP=%%I"
)

if not defined TARGET (
    echo ERROR reading target.
    pause
    exit /b 1
)

if not defined BACKUP (
    echo ERROR reading backup.
    pause
    exit /b 1
)

if not exist "%BACKUP%" (
    echo.
    echo ERROR:
    echo Backup not found:
    echo.
    echo %BACKUP%
    echo.
    pause
    exit /b 1
)

echo.
echo Current Ling build:
echo %TARGET%
echo.
echo Original backup:
echo %BACKUP%
echo.
echo CLOSE TEXTGEN COMPLETELY.
echo.

pause

for /f "delims=" %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do (
    set "STAMP=%%I"
)

set "LINGOLD=%TARGET%_LING_%STAMP%"

if exist "%TARGET%" (
    move "%TARGET%" "%LINGOLD%" >nul
)

move "%BACKUP%" "%TARGET%" >nul

if errorlevel 1 (
    echo.
    echo ERROR:
    echo Restore failed.
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================================
echo  RESTORE COMPLETE
echo ============================================================
echo.
echo Original TextGen llama.cpp has been restored.
echo.
echo The Ling build was kept at:
echo.
echo %LINGOLD%
echo.

pause
