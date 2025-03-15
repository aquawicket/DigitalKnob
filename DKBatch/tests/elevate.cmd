
::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 5
:: Automatically check & get admin rights
:: see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::

@echo off
 cls
 echo:
 echo =============================
 echo Running Admin shell
 echo =============================

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~dpnx0"
 rem this works also from cmd shell, other than %~0
 for %%k in (%0) do set batchName=%%~nk
 ::set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 set "vbsGetPrivileges=OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  echo:
  echo **************************************
  echo Invoking UAC for Privilege Escalation
  echo **************************************

  echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  echo args = "ELEV " >> "%vbsGetPrivileges%"
  echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  echo Next >> "%vbsGetPrivileges%"
  
  if '%cmdInvoke%'=='1' goto InvokeCmd 

  echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  echo args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  echo UAC.ShellExecute "%COMSPEC%", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
pause
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 ::if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

 ::::::::::::::::::::::::::::
 ::START
 ::::::::::::::::::::::::::::
 REM Run shell as admin (example) - put here code as you like
 echo %batchName% Arguments: P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9
 %COMSPEC% /k %1 %2 %3 %4 %5 %6 %7 %8 %9