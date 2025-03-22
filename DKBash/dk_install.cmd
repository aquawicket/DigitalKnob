@echo off
if "%~1" == "" (goto dk_install)

:runDKBash
	set "DKBASH_FUNCTIONS_DIR=%~1"
	set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:\=/%"
	set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:C:/=/c/%"
	set "DKBASH_FUNCTIONS_DIR_=%~1/"
	set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR_:\=/%"
	set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR_:C:/=/c/%"
	set "BASH_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:/=/c/%"

	::###### run script ######
	::"%GITBASH_EXE%" %DKSCRIPT_PATH% && (echo returned TRUE) || (echo returned FALSE && pause)
	"%BASH_EXE%" -c %DKSCRIPT_PATH% && (echo returned TRUE) || (echo returned FALSE && pause)

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
	
	:: FIXME:  bash only returns 0
%endfunction%










:dk_install
	::###### DK_CMD ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

	::###### Install DKBash ######
	%dk_call% dk_echo "Installing DKBash . . ."
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate BASH_EXE "%dk_call% dk_installGit"

	set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR_:\=/%"
	set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR_:C:/=/c/%"
	%~1
	::ftype DKBash="%COMSPEC%" /V:ON /k set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR_%" ^&^& set "f=%%1" ^&^& set "f=^!f:\=/^!" ^&^& set "f=^!f:C:=/c^!" ^&^& "%BASH_EXE%" -c "^!f^!"
	ftype DKBash="%COMSPEC%" /V:ON /k set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR_%" ^&^& set "f=%%1" ^&^& set "f=^!f:\=/^!" ^&^& set "f=^!f:C:=/c^!" ^&^& "%BASH_EXE%" -c "^!f^!"
	::ftype DKBash=%COMSPEC% /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%BASH_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKBash\DefaultIcon" "" "REG_SZ" "%BASH_EXE%"
	assoc .sh=DKBash

	%dk_call% dk_success "DKBash install complete"
%endfunction%