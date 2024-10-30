@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::###############################################################################
::# dk_pad(str padchar length rtn_var)
::#
::#	  Pad the end of a string to length with a given character
::#
::#   @str		- The string to pad
::#   @padchar	- The fill character to use
::#	  @length	- The number of spaces to pad
::#	  @rtn_var	- The returned string w/padding
::#
:dk_pad
    call dk_debugFunc 1 99
 setlocal
 
	set "spaces=                                                  "
    set "str=%~1"
    %dk_call% dk_strlen str pad
	set /a pad=%~3-pad
	set "col1=!spaces!"
	set "col1=!col1:~0,%pad%!"
	
	set "col2=%str%"
	
    set "_textFormat_=%col1%%col2%"
    endlocal & set "%4=%_textFormat_%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_pad "padded string A" " " 15 strA
    %dk_call% dk_echo "%strA%"
	
	%dk_call% dk_pad "string B" " " 15 strB
	%dk_call% dk_echo "%strB%"
	
	%dk_call% dk_pad "str C" " " 15 strC
    %dk_call% dk_echo "%strC%"
%endfunction%
