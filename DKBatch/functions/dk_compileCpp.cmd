@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_debugFunc
call dk_source dk_error
::####################################################################
::# dk_compileCpp(filepath)
::#
::#
:dk_compileCpp
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	::if %__ARGC__% gtr 1 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"

	set "filepath=%~1"
	set "appname=%~2"
	if not defined appname set "appname=temp"
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GXX_EXE "call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd"
	
	::gcc -o [executable_name] [source_file].c
	%GXX_EXE% -o %appname% -static "%filepath%"
goto:eof




call dk_source dk_printVar
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	set "MSYSTEM=CLANG64"
	call dk_validate DKAPPS_DIR "call dk_validateBranch"
	call dk_compile "%DKAPPS_DIR%\HelloWorld\main.cpp"
goto:eof
