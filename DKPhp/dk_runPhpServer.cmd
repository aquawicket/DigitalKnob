@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::################################################################################
::# dk_runPhpServer()
::#
::#
:dk_runPhpServer
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate PHP "call %DKIMPORTS_DIR%\php-src\dk_installPhp.cmd"
	
	call dk_validate DKPHP_DIR "call dk_validateBranch"
	call dk_copy %PHP%\php.exe %DKPHP_DIR%\php_local.exe OVERWRITE
	call dk_copy %PHP%\php.exe %DKPHP_DIR%\php_web.exe OVERWRITE
	call dk_copy %PHP%\php8ts.dll %DKPHP_DIR%\php8ts.dll OVERWRITE
	
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
	cd %DKBRANCH_DIR%
	TASKLIST | FINDSTR php_local.exe || start /min "" "%DKPHP_DIR%\php_local.exe" -S 127.0.0.1:2393
	TASKLIST | FINDSTR php_web.exe || start /min "" "%DKPHP_DIR%\php_web.exe" -S 192.168.1.210:2393
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_runPhpServer
%endfunction%