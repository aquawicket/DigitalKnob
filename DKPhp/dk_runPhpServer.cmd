@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_runPhpServer()
::#
::#
:dk_runPhpServer
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate PHP "call %DKIMPORTS_DIR%\php-src\dk_installPhp.cmd"
	
	call dk_validate DKPHP_DIR "call dk_validateBranch"
	call dk_copy %PHP%\php.exe %DKPHP_DIR%\php_local.exe
	call dk_copy %PHP%\php.exe %DKPHP_DIR%\php_web.exe
	copy %PHP%\php8ts.dll %DKPHP_DIR%\php8ts.dll
	
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
	cd %DKBRANCH_DIR%
	TASKLIST | FINDSTR php_local.exe || start /min "" "%DKPHP_DIR%\php_local.exe" -S 127.0.0.1:2393
	TASKLIST | FINDSTR php_web.exe || start /min "" "%DKPHP_DIR%\php_web.exe" -S 192.168.1.210:2393
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_runPhpServer
goto:eof