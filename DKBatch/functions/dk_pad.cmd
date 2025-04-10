@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::###############################################################################
::# dk_pad(str padchar left right align rtn_var)
::#
::#	  Pad the end of a string to length with a given character
::#
::#   @str		- The string to pad
::#   @padchar	- The fill character to use
::#	  @left		- The number of left spaces to pad
::#	  @right	- The number of right spaces to pad
::#	  @align	- Align text to either side  (L) or (R)
::#	  @rtn_var	- The returned string w/padding
::#
:dk_pad
setlocal
    %dk_call% dk_debugFunc 1 99

	
	set "str=%~1"
	set "padchar=%~2"
	set "left=%~3"
	set "right=%~4"
	set "align=%~5"
	set "rtn_var=%~6"
	
	%dk_call% dk_strlen str strlen
	set /a right_len=right-strlen
	set /a left_len=left
	
	set "padL="
	for /L %%G IN (1,1,!left_len!) do (
		set "padL=!padL!!padchar!"
	)
	
    set "padR="
	for /L %%G IN (1,1,!right_len!) do (
		set "padR=!padR!!padchar!"
	)
	
	if "%align%" equ "L" (
		set "rtn_var=!padL!!str!!padR!"
	)
	if "%align%" equ "R" (
		set "rtn_var=!padR!!str!!padL!"
	)
	
    endlocal & set "%6=%rtn_var%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0


	%dk_call% dk_pad "padded string A" " " 3 18 L strA 
	%dk_call% dk_echo "%strA%" 

	%dk_call% dk_pad "string B" " " 3 18 L strB 
	%dk_call% dk_echo "%strB%" 
	
	%dk_call% dk_pad "str C" " " 3 18 L strC 
	%dk_call% dk_echo "%strC%" 
	
	%dk_call% dk_pad "padded string D" " " 3 18 R strD 
	%dk_call% dk_echo "%strD%" 

	%dk_call% dk_pad "string E" " " 3 18 R strE 
	%dk_call% dk_echo "%strE%" 
	
	%dk_call% dk_pad "str F" " " 3 18 R strF 
	%dk_call% dk_echo "%strF%" 
	
	
	%dk_call% dk_echo "%strA% %strD%" 
	%dk_call% dk_echo "%strB% %strE%" 
	%dk_call% dk_echo "%strC% %strF%" 
%endfunction%
