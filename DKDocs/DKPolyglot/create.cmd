@echo off
set "input=%~dp0dk_polyglot"
goto main

:copyTo .ext
	set "output=%input%%~1"
	if exist "%output%" del "%output%"
	echo F|xcopy "%input%" "%output%" /H /Y 1>nul 2>nul
%endfunction%


:main


echo: & echo ########################### BATCH .bat ##########################
call :copyTo .bat && call dk_polyglot && del dk_polyglot.bat


echo: & echo ########################### BATCH .cmd ##########################
call :copyTo .cmd && call dk_polyglot && del dk_polyglot.cmd


echo: & echo ######################## POWERSHELL ########################
call :copyTo .ps1 && powershell ".\dk_polyglot" && del dk_polyglot.ps1


echo: & echo ########################### BASH ###########################
%USERPROFILE%\digitalknob\DKTools\portablegit_2_44_0_64_bit_7z\bin\bash.exe dk_polyglot
