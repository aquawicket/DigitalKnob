@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################



::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/crosstool-ng/DKINSTALL.cmake')" "CROSSTOOL_NG"
    %dk_call% dk_assertVar CROSSTOOL_NG

	endlocal & (
		set "CROSSTOOL_NG=%CROSSTOOL_NG%"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	%dk_call% DKINSTALL
%endfunction%


















%USERPROFILE%\digitalknob\Development\3rdParty\cygwin-setup-x86_64\bin\bash.exe --login -c '/cygdrive/c/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/cygwin/crosstool-ng-build.sh'