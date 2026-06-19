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
rem # dk_gitMergeBranch()
rem #
rem #
rem # 	 ###### Steps to manually merge (Method A) ######
rem #		https://stackoverflow.com/a/2763118
rem #
rem #	1	git checkout Development         				# This is the branch whose commits you want to keep
rem #	2a	git merge --strategy=ours master -m "Merge Development into main"
rem #				OR
rem #	2b	git merge --strategy=ours --no-commit main		# keep the content of this branch, but record a merge
rem #	2b	git commit          							# add information to the template merge message
rem # 3   git push
rem #	4	git checkout main                 				# You want to **lose** all changes on this branch
rem #	5	git merge Development             				# fast-forward main up to the merge
rem # 6	git push
rem #
rem #  ###### Steps to manually merge (Method B )######
rem #
rem # 	1. cd %USERPROFILE%\Digital Knob\Development
rem # 	2. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" checkout Development
rem # 	3. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" pull
rem # 	4. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" checkout main
rem # 	5. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" pull origin main
rem #
rem #		###### Resolve any conflicts then continue ######
rem #			https://software.codidact.com/posts/286835
rem #	
rem #	 	    "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" checkout --ours -- *
rem #
rem # 	 6. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" merge --no-ff --no-commit Development
rem # 	 7. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" commit -a -m "Merge Development Branch in to main"
rem #		 9. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" push origin main
rem #		10. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" checkout Development
rem #		11. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" merge main
rem #		12. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" push
rem #
rem #
rem #
:dk_gitMergeBranch
rem %setlocal%
	
	rem  Choose the repositoy and the branch to merge in to a destination(usually main)
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

	rem  ### Validate git.exe ###
	%dk_call% dk_validate git.exe  %dk_call% dk_depend git
	%dk_call% dk_chdir "%DKBRANCH_DIR%"

	echo Merging %branch% into %destination%
	"%git.exe%" -C "%DKBRANCH_DIR%" checkout %branch%
	"%git.exe%" -C "%DKBRANCH_DIR%" pull
	"%git.exe%" -C "%DKBRANCH_DIR%" checkout %destination%
	"%git.exe%" -C "%DKBRANCH_DIR%" pull origin %destination%
	"%git.exe%" -C "%DKBRANCH_DIR%" merge --no-ff --no-commit %branch%

	if "%ERRORLEVEL%" neq "0" (
	:conflicts
		echo THERE WAS AN ERROR MERGING.
		echo You will need to fix any existing conflicts to complete the merge.
		"%git.exe%" -C "%DKBRANCH_DIR%" git status
		%dk_call% dk_pause "AFTER ALL CONFLICTS ARE RESOLVED, CONTINUE."
	)

	:resolved
	%dk_call% dk_pause "Pushing merge to %destination%"
	"%git.exe%" -C "%DKBRANCH_DIR%" commit -a -m "Merge %branch% Branch in to %destination%"
	if "%ERRORLEVEL%" neq "0" (
		echo THERE WAN AN ERROR COMMITING.
		goto :conflicts
	)

	"%git.exe%" -C "%DKBRANCH_DIR%" push origin %destination%

	rem  Bring branch up to date with %destination%
	echo Bringing %branch% up to date with %destination%
	"%git.exe%" -C "%DKBRANCH_DIR%" checkout %branch%
	"%git.exe%" -C "%DKBRANCH_DIR%" merge %destination%
	"%git.exe%" -C "%DKBRANCH_DIR%" push
	
	%dk_call% dk_success "THE MERGE IS COMPLETE."
%endfunction%













rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_gitMergeBranch
%endfunction%
