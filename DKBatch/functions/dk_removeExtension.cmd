@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_removeExtension(filepath rtn_var)
::#
::#
:dk_removeExtension
 setlocal
    call dk_debugFunc 2
    
    set "_filepath_=%~1"
    %dk_call% dk_getExtension "%_filepath_%" _extension_
    %dk_call% dk_replaceAll "%_filepath_%" "%_extension_%" "" _filepath_
    
    :: [ "${_filepath_##*.}" = "tar" ] &&   _filepath_="${_filepath_%.*}"   # if .tar remove everything past last dot
    endlocal & set "%2=%_filepath_%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_set myPath "/test/test2/xfile.extension"
    %dk_call% dk_removeExtension "%myPath%" filepath
    %dk_call% dk_printVar filepath
%endfunction%
