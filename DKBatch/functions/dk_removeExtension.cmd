@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_getExtension
call dk_source dk_replaceAll
::##################################################################################
::# dk_removeExtension(filepath rtn_var)
::#
::#
:dk_removeExtension
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	set "_filepath_=%~1"
	call dk_getExtension "%_filepath_%" _extension_
	call dk_replaceAll "%_filepath_%" "%_extension_%" "" _filepath_
	
	:: [ "${_filepath_##*.}" = "tar" ] &&	_filepath_="${_filepath_%.*}"	# if .tar remove everything past last dot
	endlocal & set "%2=%_filepath_%"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myPath "/test/test2/xfile.extension"
	call dk_removeExtension "%myPath%" filepath
	call dk_printVar filepath
goto:eof
