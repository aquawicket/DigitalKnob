@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::################################################################################
::# dk_saveVars()
::#
::#    https://stackoverflow.com/a/41872317/688352
::#
:dk_saveVars
    call dk_debugFunc 0
 setlocal
	
	::	rem We need a temporary file to store the original environment
	::for %%f in ("original_vars.tmp") do (
	::	rem Retrieve the original environment to the temporary file
	::	start /i /wait /min "" "%comspec%" /c">""%%~ff"" set "
	::)

	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	
::	:: move current_vars to prev_vars
::	if exist "%DKCACHE_DIR%\current_vars.tmp" (
::	    %dk_call% dk_rename %DKCACHE_DIR%\current_vars.tmp %DKCACHE_DIR%\prev_vars.tmp  OVERWRITE
::	)

	:: save the current environment variables
	set > %DKCACHE_DIR%\current_vars.tmp
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_saveVars
	
%endfunction%