:: dk_include_guard()


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_debugFunc()
::
::
:dkdebugfunc () {
<:dkgetcaller <nul call dkgetcaller.cmd SCRIPT_PATH
	echo %_filename%: %_func%(%_args%)
	echo.
	echo _path       = %_path%
	echo _callerpath = %_callerpath%
	echo _callertype = %_callertype%
	echo _filename   = %_filename%
	echo _func       = %_func%
	echo _args       = %_args%
	echo _returnVar  = %_returnVar%
	echo.
	echo _lastpath       = %_lastpath%
	echo _lastcallerpath = %_lastcallerpath%
	echo _lastfilename   = %_lastfilename%
	echo _lastfunc       = %_lastfunc%
	echo _lastargs       = %_lastargs%
goto:eof