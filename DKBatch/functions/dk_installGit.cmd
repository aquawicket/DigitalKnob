@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::##################################################################################
::# dk_installGit()
::#
::#
:dk_installGit
::%setlocal%
	%dk_call% dk_debugFunc 0
	
::	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::	if not exist "%DKIMPORTS_DIR%/git/DKINSTALL.cmd" (
::		%dk_call% dk_validate DKHTTP_DKIMPORTS_DIR "set DKHTTP_DKIMPORTS_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS"
::		%dk_call% dk_download "!DKHTTP_DKIMPORTS_DIR!/git/DKINSTALL.cmd"  "%DKIMPORTS_DIR%/git/DKINSTALL.cmd"
::	)
	%dk_call% dk_depend git
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    ::%dk_call% dk_installGit
	%dk_call% dk_depend git
%endfunction%
