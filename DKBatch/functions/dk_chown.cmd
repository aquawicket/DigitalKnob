@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_chown(path)
::#
:dk_chown
    %dk_call% dk_debugFunc 1
 setlocal
 
	set "_path_=%~1"
	set "_path_=%_path_:/=\%"
    ::if defined USER set "DKUSERNAME=%USER% else set "DKUSERNAME=%USERNAME%"
    takeown /F "%_path_%" /R /D "Y"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_chown %DIGITALKNOB_DIR%
%endfunction%