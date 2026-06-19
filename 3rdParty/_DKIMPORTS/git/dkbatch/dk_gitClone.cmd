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

rem set "dk_gitClone_BACKUP=1"
rem ################################################################################
rem # dk_gitClone(url, dirctory, branch)
rem #
rem #
:dk_gitClone
%setlocal%
   
	if "%~1" neq "" (set "_URL_=%~1")
	if "%~2" neq "" (set "_DIR_=%~2")
	if "%~3" neq "" (set "_BRANCH_=%~3")

	rem ###### error if repository already exists
	if EXIST "%_DIR_%/.git" (%dk_call% dk_notice "'%_DIR_%/.git' repository already exists" && %return%)
		
	rem ###### backup if local path already exists
rem 	if "%dk_gitClone_BACKUP%" equ "1" (
		if EXIST "%_DIR_%" (
			%dk_call% dk_echo "Backing up %_DIR_% . . ."
			%dk_call% dk_copy "%_DIR_%" "%_DIR_%_BACKUP" OVERWRITE
			if NOT EXIST ("%_DIR_%_BACKUP" %dk_call% dk_fatal "dk_copy failed")
		)
rem 	) else (
rem 		%dk_call% dk_isEmptyDirectory "%_DIR_%" || (%dk_call% dk_delete "%_DIR_%")
rem 	)
	
	%dk_call% dk_validate git.exe %dk_call% dk_depend git
	
	rem ###### Clone if directory doesn't EXIST or is empty
	%dk_call% dk_mkdir "%_DIR_%"
	%dk_call% dk_isEmptyDirectory "%_DIR_%" && ("%git.exe%" -C "%_DIR_%" clone %_URL_% "%_DIR_%" && %return%)
	
	rem ###### Fetch and checkout if directory already exists and is NOT empty
rem 	"%git.exe%" -C "%_DIR_%" init -b %_BRANCH_%
rem 	"%git.exe%" -C "%_DIR_%" remote add origin %_URL_%
rem 	"%git.exe%" -C "%_DIR_%" fetch
rem 	"%git.exe%" -C "%_DIR_%" checkout -t origin/%_BRANCH_% -f
	
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_assertVar DKStorage_Dir
	%dk_call% dk_assertVar DIGITALKNOB_DIR
	rem %dk_call% dk_gitClone "%DKStorage_Dir%/DigitalKnob.bundle" "%DIGITALKNOB_DIR%/Development_TEST"
	
	%dk_call% dk_gitClone "http://aquawicket.com/DigitalKnob/Development.git" "%DIGITALKNOB_DIR%/Development_TEST"
	rem %dk_call% dk_gitClone "%REPO_URL%" "%USERPROFILE:\=/%/Digital Knob/Development" "Development"
%endfunction%
