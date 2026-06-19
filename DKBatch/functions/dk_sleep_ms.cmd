@if (@X)==(@Y) @end /*
@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # dk_sleep_ms(milliseconds)
rem #
:dk_sleep_ms
%setlocal%
	
    rem ### Method 1 - direct javascript (fastest)
	%dk_call% dk_validate cscript.exe %dk_call% dk_findFile cscript.exe
    %cscript.exe% /nologo /e:javascript "%~f0" "%~1"
   
	rem ### Method 2 - dk_evalPowershell
	rem %dk_call% dk_evalPowershell "Start-Sleep -m %~1"
   
	rem ### Method 3 - direct powershell
	rem powershell.exe -Command "Start-Sleep -m %~1"
   
	rem ### Method 4 - using ping
	rem set /a "seconds=(%~1+1000)/1000"
	rem ping 127.0.0.1 -n %seconds% >null
	
	endlocal & (
		set "cscript.exe=%cscript.exe%"
	)
%endfunction%



rem ############################ DKTEST ############################
:DKTEST
%setlocal%

	echo.
    echo. sleeping for 3000 milliseconds (3 seconds). . .
    %dk_call% dk_sleep_ms 3000
	echo. done
	
	echo.
	echo. sleeping for 1000 milliseconds (1 second). . .
    %dk_call% dk_sleep_ms 1000
	echo. done
%endfunction%

*/
WSH.Sleep(WSH.Arguments(0));



