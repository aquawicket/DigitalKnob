<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::##################################################################################
::# dk_chown(path)
::#
:dk_chown
<<<<<<< HEAD
    call dk_debugFunc 1
 setlocal
 

    ::if defined USER set "DKUSERNAME=%USER% else set "DKUSERNAME=%USERNAME%"
    takeown /F "%~1" /R /D "Y"
=======
setlocal
	%dk_call% dk_debugFunc 1
	
	set "_path_=%~1"
	
	::if defined USER (set "DKUSERNAME=%USER%) else (set "DKUSERNAME=%USERNAME%")
	takeown /F "%_path_:/=\%" /R /D "Y"
>>>>>>> Development
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_chown ${DIGITALKNOB_DIR}
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_chown "%DIGITALKNOB_DIR%"
>>>>>>> Development
%endfunction%