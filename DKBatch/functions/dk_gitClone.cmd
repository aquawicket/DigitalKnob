@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::set "dk_gitClone_BACKUP=1"
::################################################################################
::# dk_gitClone(url, branch, dirctory)
::#
::#
:dk_gitClone
%setlocal%
	%dk_call% dk_debugFunc 2 3
   
	if NOT defined _URL_ (set "_URL_=%~1")
	if NOT defined DKBRANCH_DIR (set "DKBRANCH_DIR=%~3")
	if NOT EXIST "%DKBRANCH_DIR%" (%dk_call% dk_mkdir "%DKBRANCH_DIR:/=\%")

	::###### error if repository already exists
	if EXIST "%DKBRANCH_DIR%/.git" (%dk_call% dk_error "'%DKBRANCH_DIR%/.git' repository already exists" && %return%)
		
	::###### backup if local path already exists
::	if "%dk_gitClone_BACKUP%" equ "1" (
		%dk_call% dk_echo "Backing up %DKBRANCH_DIR% . . ."
		%dk_call% dk_copy "%DKBRANCH_DIR%" "%DKBRANCH_DIR%_BACKUP" OVERWRITE
		if NOT EXIST ("%DKBRANCH_DIR%_BACKUP" %dk_call% dk_fatal "dk_copy failed")
::	) else (
::		%dk_call% dk_isEmptyDirectory "%DKBRANCH_DIR%" || (%dk_call% dk_delete "%DKBRANCH_DIR%")
::	)
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_depend git"
	
	::###### Clone if directory doesn't EXIST or is empty
	if NOT EXIST "%DKBRANCH_DIR%" ("%GIT_EXE%" -C "%DKBRANCH_DIR%" clone "%_URL_%" "%DKBRANCH_DIR%" && %return%)
	%dk_call% dk_isEmptyDirectory "%DKBRANCH_DIR%" && ("%GIT_EXE%" -C "%DKBRANCH_DIR%" clone %_URL_% "%DKBRANCH_DIR%" && %return%)
	
	::###### Fetch and checkout if directory already exists and is NOT empty
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" init -b %~2
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" remote add origin %_URL_%
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" fetch
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout -t origin/%~2 -f
	
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
    %dk_call% dk_gitClone "https://github.com/aquawicket/DigitalKnob.git" "%USERPROFILE:\=/%/DigitalKnob/Development" "Development"
%endfunction%
