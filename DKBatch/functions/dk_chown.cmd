@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::##################################################################################
::# dk_chown(path)
::#
:dk_chown
    call dk_debugFunc 1
 setlocal
 

    ::if defined USER set "DKUSERNAME=%USER% else set "DKUSERNAME=%USERNAME%"
    takeown /F "%~1" /R /D "Y"
    ::endlocal
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_getDKPaths"
    %dk_call% dk_chown ${DIGITALKNOB_DIR}
%endfunction%