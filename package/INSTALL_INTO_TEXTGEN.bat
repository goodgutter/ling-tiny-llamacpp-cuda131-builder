@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"
title Ling Tiny CUDA 13.1 - Install into TextGen

echo.
echo ============================================================
echo  LING-3.0-TINY LLAMA.CPP CUDA 13.1
echo  TEXTGEN INSTALLER
echo ============================================================
echo.
echo CLOSE TEXTGEN COMPLETELY BEFORE CONTINUING.
echo.

set "ROOT=%~1"
if not defined ROOT (
  echo Drag your main TextGen folder onto this BAT,
  echo or paste the TextGen folder path below.
  echo.
  set /p "ROOT=TextGen folder: "
)

if not exist "%ROOT%" (
  echo.
  echo ERROR: Folder does not exist:
  echo %ROOT%
  pause
  exit /b 1
)

set "TEXTGEN_ROOT=%ROOT%"
set "TARGET="

for /f "usebackq delims=" %%I in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "$r=$env:TEXTGEN_ROOT; $x=Get-ChildItem -LiteralPath $r -Filter llama-server.exe -File -Recurse -ErrorAction SilentlyContinue ^| Where-Object { $_.DirectoryName -match 'llama_cpp_binaries[\\/]bin$' } ^| Select-Object -First 1; if($x){$x.DirectoryName}"`) do set "TARGET=%%I"

if not defined TARGET (
  echo.
  echo ERROR: Could not find llama_cpp_binaries\bin\llama-server.exe
  echo inside:
  echo %ROOT%
  echo.
  echo Select the TOP TextGen folder and try again.
  pause
  exit /b 1
)

for /f "delims=" %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set "STAMP=%%I"
set "BACKUP=%TARGET%_BACKUP_%STAMP%"

echo.
echo Found:
echo %TARGET%
echo.
echo Backup:
echo %BACKUP%
echo.

move "%TARGET%" "%BACKUP%" >nul
if errorlevel 1 (
  echo ERROR: Could not back up the old bin folder.
  echo Make sure TextGen is fully closed.
  pause
  exit /b 1
)

mkdir "%TARGET%" >nul 2>&1
copy /Y "%~dp0*.exe" "%TARGET%\" >nul
copy /Y "%~dp0*.dll" "%TARGET%\" >nul

if not exist "%TARGET%\llama-server.exe" (
  echo.
  echo ERROR: Copy failed. Restoring original build...
  rmdir /S /Q "%TARGET%" >nul 2>&1
  move "%BACKUP%" "%TARGET%" >nul
  pause
  exit /b 1
)

(
  echo %TARGET%
  echo %BACKUP%
) > "%~dp0LAST_TEXTGEN_INSTALL.txt"

echo.
echo ============================================================
echo  INSTALL COMPLETE
echo ============================================================
echo.
echo Start TextGen normally and load Ling-3.0-tiny with llama.cpp.
echo If needed, run RESTORE_TEXTGEN_BACKUP.bat.
echo.
pause
