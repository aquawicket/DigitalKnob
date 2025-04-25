@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_installGit()
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
::# 	1. cd C:\Users\Administrator\digitalknob\Development
::# 	2. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" checkout Development
::# 	3. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" pull
::# 	4. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" checkout main
::# 	5. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" pull origin main
::#
::#		###### Resolve any conflicts then continue ######
::#			https://software.codidact.com/posts/286835
::#	
::#	 	    "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" checkout --ours -- *
::#
::# 	 6. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" merge --no-ff --no-commit Development
::# 	 7. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" commit -a -m "Merge Development Branch in to main"
::#		 9. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" push origin main
::#		10. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" checkout Development
::#		11. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" merge main
::#		12. "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" -C "C:\Users\Administrator\digitalknob\Development" push
::#
::#
::#
:dk_gitMergeBranch
::setlocal
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
	%dk_call% dk_validate GIT_EXE  "%dk_call% dk_installGit"
	%dk_call% dk_chdir "%DKBRANCH_DIR%"

	echo Merging %branch% into %destination%
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout %branch%
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" pull
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout %destination%
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" pull origin %destination%
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" merge --no-ff --no-commit %branch%

	if NOT "%ERRORLEVEL%" equ "0" (
	:conflicts
		echo THERE WAS AN ERROR MERGING.
		echo You will need to fix any existing conflicts to complete the merge.
		"%GIT_EXE%" -C "%DKBRANCH_DIR%" git status
		echo AFTER ALL CONFLICTS ARE RESOLVED, CONTINUE.
		pause
	)

	:resolved
	echo Pushing merge to %destination%
	pause
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" commit -a -m "Merge %branch% Branch in to %destination%"
	if NOT "%ERRORLEVEL%" equ "0" (
		echo THERE WAN AN ERROR COMMITING.
		goto :conflicts
	) 

	"%GIT_EXE%" -C "%DKBRANCH_DIR%" push origin %destination%

	:: Bring branch up to date with %destination%
	echo Bringing %branch% up to date with %destination%
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout %branch%
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" merge %destination%
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" push
	 
	%dk_call% dk_success "THE MERGE IS COMPLETE."
%endfunction%













::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitMergeBranch
%endfunction%
