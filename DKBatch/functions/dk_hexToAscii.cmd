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
rem # dk_hexToAscii(<hex>, <output>:optional)
rem #
rem #		reference: https://stackoverflow.com/a/47826309
rem #		reference: https://www.ascii-code.com
rem #
:dk_hexToAscii
%setlocal%

    set "hex=%~1"

	rem ### Method 1:  curtutil.exe
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	(del %DKCACHE_DIR:/=\%\hex.tmp & del %DKCACHE_DIR:/=\%\ascii.tmp) 1>nul 2>nul
    echo.%hex:0x=%> "%DKCACHE_DIR%/hex.tmp"    
	
    %dk_call% certutil.exe -decodehex "%DKCACHE_DIR%/hex.tmp" "%DKCACHE_DIR%/ascii.tmp" 1>nul 2>nul
    set /p dk_hexToAscii=<%DKCACHE_DIR%/ascii.tmp
    (del %DKCACHE_DIR:/=\%\hex.tmp & del %DKCACHE_DIR:/=\%\ascii.tmp) 1>nul 2>nul
   
rem  ### Method 2:  !=ExitCodeASCII!
rem	set "dk_hexToAscii="
rem	for %%H in (%hex:0x=%) do (
rem	  for /l %%N in (%%H 1 %%H) do cmd /c exit %%N
rem	  echo ExitCodeASCII = !=ExitCodeASCII!
rem	  set "dk_hexToAscii=!dk_hexToAscii!!=ExitCodeASCII!"
rem	)

    endlocal & (
		set "dk_hexToAscii_1=%~1"
		set "dk_hexToAscii=%dk_hexToAscii%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	for /l %%N in (1 1 255) do (
		%dk_call% dk_decimalToHex %%N
		%dk_call% dk_hexToAscii "!dk_decimalToHex!"
		if "!dk_decimalToHex!" neq "0x22" (
			%dk_call% dk_echo "!dk_hexToAscii_1! = !dk_hexToAscii!"
		)
	)
%endfunction%
