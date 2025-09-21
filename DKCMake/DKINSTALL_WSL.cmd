@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

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
		%dk_call% dk_validate cmd_exe 					"%dk_call% dk_depend cmd_exe"
		%dk_call% dk_debug "cmd_exe = !cmd_exe!"
		
		%dk_call% dk_validate cmake_exe 				"%dk_call% dk_depend cmake"
		%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ 	"%dk_call% dk_DKBRANCH_DIR"
		
		ftype DKCmake="!cmd_exe:/=\!" /c if EXIST !cmake_exe! ^
		(set "DKCMAKE_FUNCTIONS_DIR_=!DKCMAKE_FUNCTIONS_DIR_!" ^& "!cmd_exe!" /V:ON /K call !cmake_exe! -P "%%1"^) else ^
		(echo DKCmake NOT installed ^& "%%1"^)
		
		%dk_call% dk_registrySetKey "HKCR/DKCmake/DefaultIcon" "" "REG_SZ" "!cmake!/bin/cmake-gui.exe"
		assoc .cmake=DKCmake
	)	

	if /i "%DKCmake_ENV%" equ "WSL" (
		%dk_call% dk_debug "ComSpec = !ComSpec!"
		
		%dk_call% dk_validate cmd_exe 					"%dk_call% dk_depend cmd_exe"
		set "cmd_exe=!cmd_exe:/=\!"
		%dk_call% dk_debug "cmd_exe = !cmd_exe!"
		
		%dk_call% dk_validate wsl_exe 					"%dk_call% dk_depend wsl_exe"
		set "wsl_exe=!wsl_exe:/=\!"
		%dk_call% dk_debug "wsl_exe = !wsl_exe!"
		
		%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ 	"%dk_call% dk_DKBRANCH_DIR"
		for /f %%p in ('!wsl_exe! wslpath -u !DKCMAKE_FUNCTIONS_DIR_!') do set "DKCMAKE_FUNCTIONS_DIR_=%%p"
		%dk_call% dk_debug "DKCMAKE_FUNCTIONS_DIR_ = !DKCMAKE_FUNCTIONS_DIR_!"

		set COMMAND="%ComSpec%" /V:ON /k set "DKSCRIPT_PATH=%%1" ^& set "DKSCRIPT_PATH=^!DKSCRIPT_PATH:\=/^!" ^& for /f %%%%p in ('!wsl_exe! wslpath -u ^!DKSCRIPT_PATH^!'^) do set "DKSCRIPT_PATH=%%%%p" ^& set "DKCMAKE_FUNCTIONS_DIR_=^!DKCMAKE_FUNCTIONS_DIR_^!" ^& "!wsl_exe!" "^!DKSCRIPT_PATH^!^"
		
		echo ^!COMMAND^!
		ftype DKCmake=^!COMMAND^!

		%dk_call% dk_registrySetKey "HKCR/DKCmake/DefaultIcon" "" "REG_SZ" "!wsl_exe!"
		assoc .cmake=DKCmake
	)
	
	%dk_call% dk_success "DKCmake install complete"

%endfunction%

:: "C:\Windows\System32\cmd.exe" /V:ON /k set "DKSCRIPT_PATH=%1" & set "DKSCRIPT_PATH=!DKSCRIPT_PATH:\=/!" & for /f %%p in ('C:\Windows\System32\wsl.exe wslpath -u C:/Users/Administrator/DigitalKnob/Development/DKCMake/DKINSTALL_WSL.cmd') do set "DKSCRIPT_PATH=%%p" & set "DKCMAKE_FUNCTIONS_DIR_=!DKCMAKE_FUNCTIONS_DIR_!" & "C:\Windows\System32\wsl.exe" "!DKSCRIPT_PATH!"