@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# dk_chown(path)
::#
:dk_chown
	call dk_debugFunc 1
	
	::setlocal
	::if defined USER set "DKUSERNAME=%USER% else set "DKUSERNAME=%USERNAME%"
	call takeown /F "%~1" /R /D "Y"
	::endlocal
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_validate DIGITALKNOB_DIR "call dk_getDKPaths"
	call dk_chown ${DIGITALKNOB_DIR}
goto:eof