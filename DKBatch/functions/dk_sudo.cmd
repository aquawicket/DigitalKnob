<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_sudo(command args...)
::#
::#
:dk_sudo
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 1 99
=======
setlocal
    %dk_call% dk_debugFunc 1 99
>>>>>>> Development
    
    @echo Set objShell = CreateObject("Shell.Application") > %temp%\sudo.tmp.vbs
    @echo args = Right("%*", (Len("%*") - Len("%1"))) >> %temp%\sudo.tmp.vbs
    @echo objShell.ShellExecute "%1", args, "", "runas" >> %temp%\sudo.tmp.vbs
    @cscript %temp%\sudo.tmp.vbs
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    
=======
setlocal
	%dk_call% dk_debugFunc 0
   
>>>>>>> Development
    %dk_call% dk_sudo services.msc
%endfunction%
