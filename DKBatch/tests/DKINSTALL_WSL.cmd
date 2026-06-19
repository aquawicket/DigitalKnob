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

::set "DKCmake_ENV=CMD"
set "DKCmake_ENV=WSL"
::set "DKCmake_ENV=WSL2"


:DKINSTALL
%setlocal%
	if "%~1" neq "" (
		%dk_call% dk_fatal "DKBash/DKINSTALL.cmd does NOT take arguments"
		exit /b -1
	)
	
	
	::###### Install DKCMake ######
	echo Installing DKCmake . . .
	

	::############ (CMD) ############
	if /i "%DKCmake_ENV%" equ "CMD" (
		%dk_call% dk_validate cmd.exe 					%dk_call% dk_depend cmd.exe
		%dk_call% dk_debug "cmd.exe = !cmd.exe!"
		
		%dk_call% dk_validate cmake.exe 				%dk_call% dk_depend cmake.exe
		%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ 	%dk_call% dk_DKBRANCH_DIR
		
		ftype DKCmake="!cmd.exe:/=\!" /c if EXIST !cmake.exe! ^
		(set "DKCMAKE_FUNCTIONS_DIR_=!DKCMAKE_FUNCTIONS_DIR_!" ^& "!cmd.exe!" /V:ON /K call !cmake.exe! -P "%%1"^) else ^
		(echo DKCmake NOT installed ^& "%%1"^)
		
		%dk_call% dk_registrySetKey "HKCR/DKCmake/DefaultIcon" "" "REG_SZ" "!cmake!/bin/cmake-gui.exe"
		assoc .cmake=DKCmake
	)	

	if /i "%DKCmake_ENV%" equ "WSL" (
		%dk_call% dk_debug "ComSpec = !ComSpec!"
		
		%dk_call% dk_validate cmd.exe 					%dk_call% dk_depend cmd.exe
		set "cmd.exe=!cmd.exe:/=\!"
		%dk_call% dk_debug "cmd.exe = !cmd.exe!"
		
		%dk_call% dk_validate wsl.exe 					%dk_call% dk_depend wsl.exe
		set "wsl.exe=!wsl.exe:/=\!"
		%dk_call% dk_debug "wsl.exe = !wsl.exe!"
		
		%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ 	%dk_call% dk_DKBRANCH_DIR
		for /f %%p in ('!wsl.exe! wslpath -u !DKCMAKE_FUNCTIONS_DIR_!') do set "DKCMAKE_FUNCTIONS_DIR_=%%p"
		%dk_call% dk_debug "DKCMAKE_FUNCTIONS_DIR_ = !DKCMAKE_FUNCTIONS_DIR_!"

		set COMMAND="%ComSpec%" /V:ON /k set "DKSCRIPT_PATH=%%1" ^& set "DKSCRIPT_PATH=^!DKSCRIPT_PATH:\=/^!" ^& for /f %%%%p in ('!wsl.exe! wslpath -u ^!DKSCRIPT_PATH^!'^) do set "DKSCRIPT_PATH=%%%%p" ^& set "DKCMAKE_FUNCTIONS_DIR_=^!DKCMAKE_FUNCTIONS_DIR_^!" ^& "!wsl.exe!" "^!DKSCRIPT_PATH^!^"
		
		echo !COMMAND!
		ftype DKCmake=!COMMAND!

		%dk_call% dk_registrySetKey "HKCR/DKCmake/DefaultIcon" "" "REG_SZ" "!wsl.exe!"
		assoc .cmake=DKCmake
	)
	
	%dk_call% dk_success "DKCmake install complete"

%endfunction%

