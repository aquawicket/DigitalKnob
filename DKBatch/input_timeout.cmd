@echo off
setlocal EnableExtensions EnableDelayedExpansion
cls
echo %0(%*)


:::::: Load DK Function files (DK_INIT) ::::::
call functions\DK.cmd

:::::: Load Main Program ::::::
::if "%*" NEQ "" call %* 
dk_input_timeout "My Message" "10" "no selection"




:: https://superuser.com/a/1166728
::for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"
::for /f %%a in ('"prompt $H&for %%b in (0) do rem"') do set "BS=%%a"
::<nul set /p"=!BS!!CR!%message% (waiting %timeout% seconds) "
::<nul set /p"=!BS!!CR!result = %result% 