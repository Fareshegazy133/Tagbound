@echo off
setlocal

set "RAYLIB_DIR=%~dp0..\Vertex\Vendor\raylib"

if exist "%RAYLIB_DIR%\src\raylib.h" (
    echo raylib already exists.
    exit /b 0
)

echo raylib not found. Downloading...

git clone --depth 1 https://github.com/raysan5/raylib.git "%RAYLIB_DIR%"

if errorlevel 1 (
    echo Failed to download raylib.
    exit /b 1
)

echo raylib downloaded successfully.
exit /b 0