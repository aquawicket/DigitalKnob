@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_runPhpServer()
::#
::#
:dk_runPhpServer
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PHP "%dk_call% %DKIMPORTS_DIR%\php-src\dk_install.cmd"
	
	%dk_call% dk_validate DKPHP_DIR "%dk_call% dk_DKPHP_DIR"
	%dk_call% dk_copy %PHP%\php.exe %DKPHP_DIR%\php_local.exe OVERWRITE
	%dk_call% dk_copy %PHP%\php.exe %DKPHP_DIR%\php_web.exe OVERWRITE
	%dk_call% dk_copy %PHP%\php8ts.dll %DKPHP_DIR%\php8ts.dll OVERWRITE
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	cd %DKBRANCH_DIR%
	TASKLIST | FINDSTR php_local.exe || start /min "" "%DKPHP_DIR%\php_local.exe" -S 127.0.0.1:2393
	TASKLIST | FINDSTR php_web.exe || start /min "" "%DKPHP_DIR%\php_web.exe" -S 192.168.1.210:2393
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_runPhpServer
%endfunction%
