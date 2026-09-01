@echo off
setlocal

echo ========================================
echo Tagbound - Windows Project Setup
echo ========================================
echo.

REM --------------------------------------------------
REM Get the repository root
REM --------------------------------------------------

set "ROOT=%~dp0.."

REM --------------------------------------------------
REM Initialize / update all Git submodules
REM --------------------------------------------------

echo [1/3] Initializing Git submodules...

git -C "%ROOT%" submodule update --init --recursive

if errorlevel 1 (
    echo.
    echo ERROR: Failed to initialize Git submodules.
    pause
    exit /b 1
)

echo Git submodules ready.
echo.

REM --------------------------------------------------
REM Delete generated build files
REM
REM .idea is intentionally NOT deleted.
REM Rider's project settings should persist between
REM regenerations.
REM --------------------------------------------------

echo [2/3] Cleaning generated files...

REM Binaries
if exist "%ROOT%\Binaries" (
    echo Removing Binaries...
    rmdir /s /q "%ROOT%\Binaries"
)

REM Visual Studio solution
if exist "%ROOT%\Tagbound.sln" (
    echo Removing Tagbound.sln...
    del /f /q "%ROOT%\Tagbound.sln"
)

REM VertexEditor project
if exist "%ROOT%\Vertex\VertexEditor.vcxproj" (
    echo Removing VertexEditor.vcxproj...
    del /f /q "%ROOT%\Vertex\VertexEditor.vcxproj"
)

REM VertexRuntime project
if exist "%ROOT%\Vertex\VertexRuntime.vcxproj" (
    echo Removing VertexRuntime.vcxproj...
    del /f /q "%ROOT%\Vertex\VertexRuntime.vcxproj"
)

REM raylib project
if exist "%ROOT%\Vertex\Vendor\raylib.vcxproj" (
    echo Removing raylib.vcxproj...
    del /f /q "%ROOT%\Vertex\Vendor\raylib.vcxproj"
)

REM Tagbound project
if exist "%ROOT%\Tagbound\Tagbound.vcxproj" (
    echo Removing Tagbound.vcxproj...
    del /f /q "%ROOT%\Tagbound\Tagbound.vcxproj"
)

echo Cleanup complete.
echo.

REM --------------------------------------------------
REM Generate Visual Studio solution
REM --------------------------------------------------

echo [3/3] Generating Visual Studio solution...

cd /d "%ROOT%"

Vendor\Binaries\Premake\Windows\premake5.exe --file=Build.lua vs2022

if errorlevel 1 (
    echo.
    echo ERROR: Premake failed to generate the solution.
    pause
    exit /b 1
)

echo.
echo ========================================
echo Setup complete!
echo ========================================
echo.
echo Generated:
echo   Tagbound.sln
echo.
echo Projects:
echo   VertexRuntime
echo   VertexEditor
echo   raylib
echo   Tagbound
echo.

pause
exit /b 0