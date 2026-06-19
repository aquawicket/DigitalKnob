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
rem # dk_gitMergeBranch(repo_path source_branch target_branch)
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
rem # 	2. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" checkout Development
rem # 	3. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" pull
rem # 	4. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" checkout main
rem # 	5. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" pull origin main
rem #
rem #		###### Resolve any conflicts then continue ######
rem #			https://software.codidact.com/posts/286835
rem #	
rem #	 	    "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" checkout --ours -- *
rem #
rem # 	 6. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" merge --no-ff --no-commit Development
rem # 	 7. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" commit -a -m "Merge Development Branch in to main"
rem #		 9. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" push origin main
rem #		10. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" checkout Development
rem #		11. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" merge main
rem #		12. "%USERPROFILE%\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\Digital Knob\Development" push
rem #
rem #
rem #
:dk_gitMergeBranch
rem %setlocal%
	
	%dk_call% dk_assertPath DIGITALKNOB_DIR
	
	rem ### repo_path
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	if "%~1" neq "" (set "repo_path=%~1")		else (set "repo_path=%DKBRANCH_DIR%")
	
	rem ### source_branch
	%dk_call% dk_validate DKBRANCH %dk_call% dk_DKBRANCH_DIR
	if "%~2" neq "" (set "source_branch=%~2")	else (set "source_branch=%DKBRANCH%")
	
	rem ###### target_branch (usually 'main' or 'master') ######
	if "%~3" neq "" (set "target_branch=%~3")	else (set "target_branch=main")
	
	
	echo Running merge branch with these settings:
	echo     repo_path: %repo_path%
	echo source_branch: %source_branch%
	echo target_branch: %target_branch%

	rem ### Validate git.exe ###
	%dk_call% dk_validate git.exe  %dk_call% dk_depend git
	%dk_call% dk_chdir "%repo_path%"

	echo Merging %source_branch% into %target_branch%
	"%git.exe%" -C "%repo_path%" checkout %source_branch%
	"%git.exe%" -C "%repo_path%" pull
	"%git.exe%" -C "%repo_path%" checkout %target_branch%
	"%git.exe%" -C "%repo_path%" pull origin %target_branch%
	"%git.exe%" -C "%repo_path%" merge --no-ff --no-commit %source_branch%

	if "%errorlevel%" neq "0" (
	:conflicts
		echo THERE WAS AN ERROR MERGING.
		echo You will need to fix any existing conflicts to complete the merge.
		"%git.exe%" -C "%repo_path%" git status
		%dk_call% dk_pause "AFTER ALL CONFLICTS ARE RESOLVED, CONTINUE."
	)

	:resolved
	%dk_call% dk_pause "Pushing merge to %target_branch%"
	"%git.exe%" -C "%repo_path%" commit -a -m "Merge %source_branch% Branch in to %target_branch%"
	if "%errorlevel%" neq "0" (
		echo THERE WAN AN ERROR COMMITING.
		goto :conflicts
	)

	"%git.exe%" -C "%repo_path%" push origin %target_branch%

	rem Bring source_branch up to date with %target_branch%
	echo Bringing %source_branch% up to date with %target_branch%
	"%git.exe%" -C "%repo_path%" checkout %source_branch%
	"%git.exe%" -C "%repo_path%" merge %target_branch%
	"%git.exe%" -C "%repo_path%" push
	
	%dk_call% dk_success "THE MERGE IS COMPLETE."
%endfunction%













rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_gitMergeBranch
%endfunction%
