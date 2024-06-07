@echo off
call DK


::call dk_load dk_getExtension

::##################################################################################
::# dk_removeExtension(<filepath> rtn_var)
::#
::#
:dk_removeExtension () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "_filepath_=%~1"
	call dk_printVar _filepath_
	call dk_getExtension "%_filepath_%" _extension_
	call dk_replaceAll "%_filepath_%" "%_extension_%" "" _filepath_
	
	:: [ "${_filepath_##*.}" = "tar" ] &&	_filepath_="${_filepath_%.*}"	# if .tar remove everything past last dot
	endlocal & call dk_set %2 "%_filepath_%"
goto:eof



:DKTEST ###############################################################################

	call dk_set filepath "/test/test2/xfile.extension"
	call dk_removeExtension "%filepath%" filepath
	echo "filepath = %filepath%"