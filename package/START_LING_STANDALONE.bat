@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title Ling-3.0-tiny - llama.cpp CUDA 13.1

set "MODEL=%~1"
set "CTX=4096"
set "PORT=8080"

if not defined MODEL (
  echo.
  echo Drag your Ling-3.0-tiny GGUF onto this BAT file.
  echo.
  pause
  exit /b 1
)

if not exist "%MODEL%" (
  echo Model not found:
  echo %MODEL%
  pause
  exit /b 1
)

echo.
echo Model: %MODEL%
echo Context: %CTX%
echo Web UI: http://127.0.0.1:%PORT%
echo.

start "" /min cmd /c "timeout /t 5 /nobreak >nul & start "" http://127.0.0.1:%PORT%"

"%~dp0llama-server.exe" -m "%MODEL%" -ngl auto -c %CTX% --flash-attn on --host 127.0.0.1 --port %PORT%

echo.
echo llama-server stopped.
pause
