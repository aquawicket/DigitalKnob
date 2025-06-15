@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::%dk_call% dk_validate DKHTTP_DKIMPORTS_DIR "%dk_call% dk_DKHTTP_DKIMPORTS_DIR"
%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
if not exist "%DKIMPORTS_DIR%/git/DKINSTALL.cmd" (
	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/DKINSTALL.cmd"  "%DKIMPORTS_DIR%/git/DKINSTALL.cmd"
)
%dk_call% dk_depend git
exit /b 0
::#################################################################################################################






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_installGit
%endfunction%
