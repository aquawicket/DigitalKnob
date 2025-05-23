@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_fileSearch(<base_path>, <file_pattern>, <search_depth>, optional:<rtn_var>)
::#
::#
::#   Example:  %dk_call% dk_fileSearch "C:\Users\Administrator\digitalknob" "\bin\bash.exe" 7 BASH_EXE
:dk_fileSearch
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 3 4
	set "base_path=%~1"
	set "base_path=%base_path:/=\%"
	set "file_pattern=%~2"
	set "file_pattern=%file_pattern:/=\%"
	set "search_depth=%~3"

	::set file_pattern=%file_pattern:/=\%
	for %%a in (%file_pattern:\= %) do set filename=%%a
	set prefix=!file_pattern:%filename%=!

	echo searching '%base_path%' for '%file_pattern%'
	:: /s		- copy Subdirectories, but not empty ones.
	:: /fp		- include Full Pathname of files in the output.
	:: /l		- List only - don't copy, timestamp or delete any files.
	:: /lev:n 	- only copy the top n LEVels of the source directory tree.
	:: /nc		- No Class - don't log file classes.
	:: /ndl		- No Directory List - don't log directory names.
	:: /njh		- No Job Header.
	:: /njs		- No Job Summary.
	:: /ns		- No Size - don't log file sizes.
	echo:
	for /f "tokens=*" %%g in ('%systemroot%\system32\robocopy.exe "%base_path%" "null" "%filename%" /fp /l /lev:%search_depth% /nc /ndl /njh /njs /ns /s') do (
		set "string=%%g"
		if not "!string:%file_pattern%=!" equ "!string!" (
			echo *** %%g
			set "dk_fileSearch=%%g"
		) else (
			echo %%g
		)
	)
	endlocal & (
		set "dk_fileSearch=%dk_fileSearch%"
		if "%~4" neq "" set "%4=%dk_fileSearch%"
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	%dk_call% dk_fileSearch "%DK3RDPARTY_DIR%" "\usr\bin\bash.exe" 4 BASH_EXE
	%dk_call% dk_printVar BASH_EXE
%endfunction%
