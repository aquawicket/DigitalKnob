@echo off
call DK

::#################################################################################
:: dk_setRegistryKey() <reg_path> <key> <type> <value>
::
::
:dk_setRegistryKey <reg_path> <key> <type> <value>
	"C:\Windows\System32\reg.exe" ADD %1 /v %2 /t %3 /d "%4"
goto:eof