@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_uninstallDigitalKnob()
::#
::#
:dk_uninstallDigitalKnob
%setlocal%
 	%dk_call% dk_debugFunc 0 

	::###### Uninstall DK Languages ######
	echo ############ Uninstall DK Languages ############
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% "%DKBRANCH_DIR%/DKBash/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKBatch/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKC/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKCMake/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKCpp/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKCSharp/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKHta/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKHtml/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKJava/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKJavascript/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKPhp/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKPowershell/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKPython/DKUNINSTALL.cmd"
	%dk_call% "%DKBRANCH_DIR%/DKVb/DKUNINSTALL.cmd"

	::###### Uninstall DK 3rdParty ######
	echo ############ Uninstall 3rdParty #############
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% "%DKIMPORTS_DIR%/git/contextMenu/DKUNINSTALL.cmd"
::	%dk_call% "%DKIMPORTS_DIR%/python/DKUNINSTALL.cmd"
::	%dk_call% "%DKIMPORTS_DIR%/python3/DKUNINSTALL.cmd"
::	%dk_call% "%DKIMPORTS_DIR%/tcc-rt/DKUNINSTALL.cmd"
::	%dk_call% "%DKIMPORTS_DIR%/vc_redist/DKUNINSTALL.cmd"
::	%dk_call% "%DKIMPORTS_DIR%/visualstudio/DKUNINSTALL.cmd"
::	%dk_call% "%DKIMPORTS_DIR%/vs_coreeditorfonts/DKUNINSTALL.cmd"
::	%dk_call% "%DKIMPORTS_DIR%/windows-sdk/DKUNINSTALL.cmd"
	::%dk_call% "%DKIMPORTS_DIR%/wsl/DKUNINSTALL.cmd"
	
	::###### Kill lingering processes ######
	%dk_call% dk_killProcess gpg-agent.exe

	::###### Backup DKBuilder.cmd to C:/ ######
	echo ### Creating backup of DKBuilder.cmd ###
	%dk_call% dk_copy "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%SystemDrive%/DKBuilder.cmd" OVERWRITE

	::###### Remove DK Pins ######
	%dk_call% dk_quickAccessUnpin "%DIGITALKNOB_DIR%"
	
	::###### Delete DK Simlinks ######
	echo ### Deleting Simlinks ###
	%dk_call% dk_validate DKDESKTOP_DIR "%dk_call% dk_DKDESKTOP_DIR"
	%dk_call% dk_delete "%DKDESKTOP_DIR%/DigitalKnob"
	%dk_call% dk_delete "%DKDESKTOP_DIR%/DKBuilder.cmd"
	
	::###### Delete DK Shortcuts ######
	echo ### Deleting Shortcuts ###
	%dk_call% dk_validate DKDESKTOP_DIR "%dk_call% dk_DKDESKTOP_DIR"
	%dk_call% dk_delete "%DKDESKTOP_DIR%/DigitalKnob.lnk"

	::###### Delete DKCACHE_DIR ######
	echo ### Deleting DKCACHE_DIR ###
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	%dk_call% dk_delete "%DKCACHE_DIR%"

	::###### Deleting DIGITALKNOB_DIR ######
	%dk_call% dk_deleteDigitalKnob

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0 

	%dk_call% dk_uninstallDigitalKnob
%endfunction%

