:: dk_include_guard()


::################################################################################
::# dk_debugFunc()
::#
::#
:dk_debugFunc () {
	set "cyan=[36m"
	set "clr=[0m"
<:dk_caller <nul call %DKBATCH_DIR%\functions\dk_caller.cmd
	echo %_filename%: %cyan%%_func%(%_args%)%clr%
	::echo.
	::echo _path           = %_path%
	::echo _callerpath     = %_callerpath%
	::echo _callertype     = %_callertype%
	::echo _filename       = %_filename%
	::echo _func           = %_func%
	::echo _args           = %_args%
	::echo.
	::echo _returnVar      = %_returnVar%
	::echo.
	::echo _lastpath       = %_lastpath%
	::echo _lastcallerpath = %_lastcallerpath%
	::echo _lastfilename   = %_lastfilename%
	::echo _lastfunc       = %_lastfunc%
	::echo _lastargs       = %_lastargs%
goto:eof