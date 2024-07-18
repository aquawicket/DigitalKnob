@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::##################################################################################
::# dk_chown(path)
::#
:dk_chown
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	::if defined USER set "DKUSERNAME=%USER% else set "DKUSERNAME=%USERNAME%"
	call takeown /F "%~1" /R /D "Y"
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_validate DIGITALKNOB_DIR "call dk_getDKPaths"
	call dk_chown ${DIGITALKNOB_DIR}
goto:eof