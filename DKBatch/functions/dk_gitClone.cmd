@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::set "dk_gitClone_BACKUP=1"
::################################################################################
::# dk_gitClone(url, dirctory, branch)
::#
::#
:dk_gitClone
%setlocal%
	%dk_call% dk_debugFunc 2 3
   
	if "%~1" neq "" (set "_URL_=%~1")
	if "%~2" neq "" (set "_DIR_=%~2")
	if "%~3" neq "" (set "_BRANCH_=%~3")

	::###### error if repository already exists
	if EXIST "%_DIR_%/.git" (%dk_call% dk_notice "'%_DIR_%/.git' repository already exists" && %return%)
		
	::###### backup if local path already exists
::	if "%dk_gitClone_BACKUP%" equ "1" (
		if EXIST "%_DIR_%" (
			%dk_call% dk_echo "Backing up %_DIR_% . . ."
			%dk_call% dk_copy "%_DIR_%" "%_DIR_%_BACKUP" OVERWRITE
			if NOT EXIST ("%_DIR_%_BACKUP" %dk_call% dk_fatal "dk_copy failed")
		)
::	) else (
::		%dk_call% dk_isEmptyDirectory "%_DIR_%" || (%dk_call% dk_delete "%_DIR_%")
::	)
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_depend git"
	
	::###### Clone if directory doesn't EXIST or is empty
	if NOT EXIST "%_DIR_%" (%dk_call% dk_mkdir "%_DIR_:/=\%")
	%dk_call% dk_isEmptyDirectory "%_DIR_%" && ("%GIT_EXE%" -C "%_DIR_%" clone %_URL_% "%_DIR_%" && %return%)
	
	::###### Fetch and checkout if directory already exists and is NOT empty
::	"%GIT_EXE%" -C "%_DIR_%" init -b %_BRANCH_%
::	"%GIT_EXE%" -C "%_DIR_%" remote add origin %_URL_%
::	"%GIT_EXE%" -C "%_DIR_%" fetch
::	"%GIT_EXE%" -C "%_DIR_%" checkout -t origin/%_BRANCH_% -f
	
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
    ::%dk_call% dk_gitClone "https://github.com/aquawicket/DigitalKnob.git" "%USERPROFILE:\=/%/DigitalKnob/Development" "Development"
	
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_gitClone "%DKDOWNLOAD_DIR%/DigitalKnob.bundle" "%USERPROFILE:\=/%/DigitalKnob/Development"
%endfunction%
