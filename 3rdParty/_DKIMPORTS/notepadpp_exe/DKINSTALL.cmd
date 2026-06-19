rem shebang
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
rem # DKINSTALL()
rem #
rem #
:DKINSTALL
%setlocal%
  
    if EXIST "%notepadpp_exe%" (%return%)
   
	rem ###### search for notepad++.exe in 'DKTOOLS_DIR' ######
rem %dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
rem	if NOT EXIST "%notepadpp_exe%" (%dk_call% dk_findFile "notepad++.exe" "%DKTOOLS_DIR%" "notepadpp_exe") &rem NO_ERROR

    rem ###### search for notepad++.exe on 'C:/Program Files' ######
	if NOT EXIST "%notepadpp_exe%" (%dk_call% dk_findFile "notepad++.exe" "%ProgramFiles%" "notepadpp_exe")
	
	if NOT EXIST "%notepadpp_exe%" (
		%dk_call% dk_error "notepadpp_exe:%notepadpp_exe% NOT FOUND"
		%return%
	)
	
	:return
	endlocal & (
		set "notepadpp_exe=%notepadpp_exe:\=/%"
	)
	rem %dk_call% dk_debug "notepadpp_exe = %notepadpp_exe%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp_exe
	%dk_call% dk_debug "notepadpp_exe = %notepadpp_exe%"
	
	set "PATH="
	set "notepadpp_exe="
	
	%dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp_exe
	%dk_call% dk_debug "notepadpp_exe = %notepadpp_exe%"
%endfunction%