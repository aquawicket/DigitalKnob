@echo off
call DK


::##################################################################################
::# dk_removeExtension(<filepath> <output>)
::#
::#
:dk_removeExtension () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	set "_filepath_=%~1"
	call dk_printVar _filepath_
	call dk_getExtension "%_filepath_%" _extension_
	call dk_replaceAll "%_filepath_%" "%_extension_%" "" _filepath_
	
	:: [ "${_filepath_##*.}" = "tar" ] &&	_filepath_="${_filepath_%.*}"	# if .tar remove everything past last dot
	endlocal & set "%2=%_filepath_%"
goto:eof



:DKTEST ###############################################################################

	set "filepath=/test/test2/xfile.extension"
	call dk_removeExtension "%filepath%" filepath
	echo "filepath = %filepath%"