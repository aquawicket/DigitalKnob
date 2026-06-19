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
rem # dk_reload()
rem #
rem #
:dk_reload
%setlocal%
   
    if NOT EXIST "%DKSCRIPT_PATH%" (
		%dk_call% dk_error "DKSCRIPT_PATH:'%DKSCRIPT_PATH%' NOT FOUND"
		%return%
	)
   
    %dk_call% dk_clearScreen
    %dk_call% dk_info "reloading %DKSCRIPT_PATH%. . ."
   
    rem ###### METHOD 1 ######
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
    %dk_call% dk_fileWrite "%DKCACHE_DIR%/reload" "%DKSCRIPT_PATH%"
	%dk_call% dk_exit 0
       
    rem ###### METHOD 2 ######
    ::start "" "%DKSCRIPT_PATH%" & dk_exit & dk_exit & dk_exit
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% dk_pause "Press any key to test dk_reload"
    %dk_call% dk_reload
%endfunction%
