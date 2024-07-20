@echo off

if "%*" neq "" (goto:runDKBash)
:installDKBash
	echo Associating .sh files with DKBash . . .
	
	::###### DKINIT ######
	set "DKBATCH_FUNCTIONS_DIR_=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\DKBatch\functions\"
	call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"
	
	call dk_load dk_validate
    call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_validate GITBASH_EXE "call dk_installGit"

	::###### Git Bash ######::
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.sh
	ftype dkbash=cmd /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%GITBASH_EXE%" "%%1" %*
	assoc .sh=dkbash
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dkbash\DefaultIcon" "" "REG_SZ" "%GITBASH_EXE%"
goto:eof


:runDKBash
	set "DKBASH_FUNCTIONS_DIR=%~1"
	set "GITBASH_EXE=%~2"
	set "SH_FILE=%~3"

	echo ############### Digitalknob ##################
	start %GITBASH_EXE% %SH_FILE%
goto:eof