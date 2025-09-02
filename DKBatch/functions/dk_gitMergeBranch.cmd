@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_gitMergeBranch()
::#
::#
::# 	 ###### Steps to manually merge (Method A) ######
::#		https://stackoverflow.com/a/2763118
::#
::#	1	git checkout Development         				# This is the branch whose commits you want to keep
::#	2a	git merge --strategy=ours master -m "Merge Development into main"
::#				OR
::#	2b	git merge --strategy=ours --no-commit main		# keep the content of this branch, but record a merge
::#	2b	git commit          							# add information to the template merge message
::# 3   git push
::#	4	git checkout main                 				# You want to **lose** all changes on this branch
::#	5	git merge Development             				# fast-forward main up to the merge
::# 6	git push
::#
::#  ###### Steps to manually merge (Method B )######
::#
::# 	1. cd %USERPROFILE%\DigitalKnob\Development
::# 	2. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" checkout Development
::# 	3. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" pull
::# 	4. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" checkout main
::# 	5. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" pull origin main
::#
::#		###### Resolve any conflicts then continue ######
::#			https://software.codidact.com/posts/286835
::#	
::#	 	    "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" checkout --ours -- *
::#
::# 	 6. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" merge --no-ff --no-commit Development
::# 	 7. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" commit -a -m "Merge Development Branch in to main"
::#		 9. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" push origin main
::#		10. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" checkout Development
::#		11. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" merge main
::#		12. "%USERPROFILE%\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "%USERPROFILE%\DigitalKnob\Development" push
::#
::#
::#
:dk_gitMergeBranch
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	:: Choose the repositoy and the branch to merge in to a destination(usually main)
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
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

	:: ### Validate git.exe ###
	%dk_call% dk_validate git_exe  "%dk_call% dk_depend git"
	%dk_call% dk_chdir "%DKBRANCH_DIR%"

	echo Merging %branch% into %destination%
	"%git_exe%" -C "%DKBRANCH_DIR%" checkout %branch%
	"%git_exe%" -C "%DKBRANCH_DIR%" pull
	"%git_exe%" -C "%DKBRANCH_DIR%" checkout %destination%
	"%git_exe%" -C "%DKBRANCH_DIR%" pull origin %destination%
	"%git_exe%" -C "%DKBRANCH_DIR%" merge --no-ff --no-commit %branch%

	if "%ERRORLEVEL%" neq "0" (
	:conflicts
		echo THERE WAS AN ERROR MERGING.
		echo You will need to fix any existing conflicts to complete the merge.
		"%git_exe%" -C "%DKBRANCH_DIR%" git status
		%dk_call% dk_pause "AFTER ALL CONFLICTS ARE RESOLVED, CONTINUE."
	)

	:resolved
	%dk_call% dk_pause "Pushing merge to %destination%"
	"%git_exe%" -C "%DKBRANCH_DIR%" commit -a -m "Merge %branch% Branch in to %destination%"
	if "%ERRORLEVEL%" neq "0" (
		echo THERE WAN AN ERROR COMMITING.
		goto :conflicts
	)

	"%git_exe%" -C "%DKBRANCH_DIR%" push origin %destination%

	:: Bring branch up to date with %destination%
	echo Bringing %branch% up to date with %destination%
	"%git_exe%" -C "%DKBRANCH_DIR%" checkout %branch%
	"%git_exe%" -C "%DKBRANCH_DIR%" merge %destination%
	"%git_exe%" -C "%DKBRANCH_DIR%" push
	
	%dk_call% dk_success "THE MERGE IS COMPLETE."
%endfunction%













::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitMergeBranch
%endfunction%
