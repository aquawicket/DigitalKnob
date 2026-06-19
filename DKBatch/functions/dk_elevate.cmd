<!-- rem ################## ELEVATE ##################
@echo off

net session 1>nul 2>nul
if %ERRORLEVEL% equ 0 goto elevated
:dk_elevate
rem %setlocal%
	
    if /i "%~2" equ "gotPrivileges" goto gotPrivileges
        echo "elevating permissions . . ."
        setlocal DisableDelayedExpansion
        set "THIS_PATH=%~dpnx0"
        for %%Z in (%*) do set "DKSCRIPT_PATH=%%~dpnxZ"          &rem get last argument
        setlocal EnableDelayedExpansion
        cscript //nologo "%~f0?.wsf" %THIS_PATH% gotPrivileges %DKSCRIPT_PATH% & exit
    :gotPrivileges
        setlocal & cd /d %~dp0
        %ComSpec% /k "%THIS_PATH%" elevated
    --><job><script language="VBScript">
            WScript.Echo "VBScript entry"
            Set oShell = CreateObject( "WScript.Shell" )
            THIS_PATH=oShell.ExpandEnvironmentStrings("%THIS_PATH%")
            Set UAC = CreateObject("Shell.Application")
            args = ""
            For Each strArg in WScript.Arguments
            args = args & strArg & " " 
            Next
            args = "/c """ + THIS_PATH + """ " + args
            UAC.ShellExecute "cmd", args, "", "runas", 1
        </script></job><!--
    :elevated
        for %%Z in (%*) do set "DKSCRIPT_PATH=%%~dpnxZ"          &rem get last argument
        for %%Z in (%*) do set "DKSCRIPT_DIR=%%~dpZ"             &rem get last argument
        cd /d %DKSCRIPT_DIR%
        call %DKSCRIPT_PATH% elevated
%endfunction%
-->