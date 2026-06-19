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
::# dk_gitMergeBranch()
::#
::#
:dk_gitMergeBranch
::setlocal
	
	rem Choose the repositoy and the branch to merge in to a destination(usually main)
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_assertPath DKBRANCH_DIR
	%dk_call% dk_assertPath DIGITALKNOB_DIR
	%dk_call% dk_assertVar DKBRANCH

	set "repository=%DKBRANCH_DIR%"
	set "branch=%DKBRANCH%"
	set "destination=main"

	echo Running merge branch with these settings:
	echo Repository: %repository%
	echo     Branch: %branch%
	echo Merging To: %destination%

	rem ### Validate git.exe ###
	%dk_call% dk_validate git.exe  %dk_call% dk_depend git
	%dk_call% dk_chdir "%DKBRANCH_DIR%"

	pause
	echo Merging %branch% into %destination% and pushing to remote
	"%git.exe%" -C "%DKBRANCH_DIR%" checkout %branch%
	pause
	"%git.exe%" -C "%DKBRANCH_DIR%" pull
	pause
	"%git.exe%" -C "%DKBRANCH_DIR%" checkout %destination%
	pause
	"%git.exe%" -C "%DKBRANCH_DIR%" pull origin %destination%
	pause
	"%git.exe%" -C "%DKBRANCH_DIR%" merge --no-ff --no-commit %branch%
	pause

	if "%ERRORLEVEL%" neq "0" (
	:conflicts
		echo THERE WAS AN ERROR MERGING.
		echo You will need to fix any existing conflicts to complete the merge.
		pause
		"%git.exe%" -C "%DKBRANCH_DIR%" git status
		echo AFTER ALL CONFLICTS ARE RESOLVED, CONTINUE.
		pause
	) else (
		echo THE MERGE WAS SUCCESSFUL
		goto :resolved
	)

	:resolved
	rem push merge to %destination%
	echo Pushing merge to %destination%
	"%git.exe%" -C "%DKBRANCH_DIR%" commit -a -m "Merge %branch% Branch in to %destination%"
	if "%ERRORLEVEL%" neq "0" (
		echo THERE WAN AN ERROR COMMITING.
		goto :conflicts
	)

	"%git.exe%" -C "%DKBRANCH_DIR%" push origin %destination%

	rem Bring branch up to date with %destination%
	echo Bringing %branch% up to date with %destination%
	"%git.exe%" -C %DKBRANCH_DIR% checkout %branch%
	"%git.exe%" -C %DKBRANCH_DIR% merge %destination%
	"%git.exe%" -C %DKBRANCH_DIR% push
	
	%dk_call% dk_success "THE MERGE IS COMPLETE."
%endfunction%













rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal

    %dk_call% dk_gitMergeBranch
%endfunction%