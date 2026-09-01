@echo off

call "%~dp0Setup-Raylib.bat"

if errorlevel 1 (
    echo Failed to setup raylib.
    exit /b 1
)

pushd ..
Vendor\Binaries\Premake\Windows\premake5.exe --file=Build.lua vs2022
popd
pause