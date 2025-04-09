@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::##################################################################################
::# dk_chown(path)
::#
:dk_chown
setlocal
	%dk_call% dk_debugFunc 1
	
	set "_path_=%~1"
	
	::if defined USER (set "DKUSERNAME=%USER%) else (set "DKUSERNAME=%USERNAME%")
	takeown /F "%_path_:/=\%" /R /D "Y"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_chown "%DIGITALKNOB_DIR%"
%endfunction%