@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_appendCmakeArgs(string)
::#
::#
:dk_appendCmakeArgs () {
	call dk_debugFunc
	::if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    set CMAKE_ARGS=%CMAKE_ARGS% "%*"
	::call dk_set CMAKE_ARGS "%CMAKE_ARGS% "%*""
goto:eof




:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	call dk_debugFunc
	
	call dk_appendCmakeArgs string
goto:eof