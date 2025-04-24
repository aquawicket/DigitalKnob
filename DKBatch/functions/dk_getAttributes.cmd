<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getAttributes(path rtn_var)
::#
:dk_getAttributes
    call dk_debugFunc 2
 setlocal
 
    set "_input_=%1"
    set "_input_=%_input_:"=%"
    if [%_input_:~-1%] == [\] set "_input_=%_input_:~0,-1%"
    if [%_input_:~-1%] == [/] set "_input_=%_input_:~0,-1%"
    endlocal & for %%Z in ("%_input_%") do set "%2=%%~aZ"
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_getAttributes(<pathname>, <rtn_var>:optional)
::#
::#		Reference: https://ss64.com/nt/syntax-args.html#attributes
::#
::#		 Attribute                    Expansion 
::#		 FILE_ATTRIBUTE_DIRECTORY     d-------- 
::#		 FILE_ATTRIBUTE_READONLY      -r------- 
::#		 FILE_ATTRIBUTE_ARCHIVE       --a------ 
::#		 FILE_ATTRIBUTE_HIDDEN        ---h----- 
::#		 FILE_ATTRIBUTE_SYSTEM        ----s---- 
::#		 FILE_ATTRIBUTE_COMPRESSED    -----c--- 
::#		 FILE_ATTRIBUTE_OFFLINE       ------o-- 
::#		 FILE_ATTRIBUTE_TEMPORARY     -------t- 
::#		 FILE_ATTRIBUTE_REPARSE_POINT --------l
::#		 FILE_ATTRIBUTE_NORMAL        ---------
::#
:dk_getAttributes
setlocal
	%dk_call% dk_debugFunc 2

	set "pathname=%1"
	set "pathname=%pathname:"=%"
	set "pathname=%pathname:/=\%"
	if "%pathname:~-1%" equ "\"   set "pathname=%pathname:~0,-1%"

	for %%Z in ("%pathname%") do set "dk_getAttributes=%%~aZ"

	endlocal & (
		set "dk_getAttributes=%dk_getAttributes%"
		if "%~2" neq "" (set "%~2=%dk_getAttributes%")
	)	
>>>>>>> Development
%endfunction%





<<<<<<< HEAD


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_getAttributes "%myPath%" attributes
    %dk_call% dk_printVar attributes
=======
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "myPath=C:/Users/Administrator/Desktop/digitalknob"
	%dk_call% dk_getAttributes "%myPath%" attributes
	%dk_call% dk_echo "dk_getAttributes = %dk_getAttributes%"
	%dk_call% dk_echo "attributes = %attributes%"
>>>>>>> Development
%endfunction%
