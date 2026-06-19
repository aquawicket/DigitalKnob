@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
setlocal

	echo ### Uninstall DK Languages ###
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
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
	%dk_call% "%DKBRANCH_DIR%/DKVbs/DKUNINSTALL.cmd"

	echo ### Uninstall 3rdParty ###
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% "%DKIMPORTS_DIR%/git/contextMenu/DKUNINSTALL.cmd"
	%dk_call% "%DKIMPORTS_DIR%/python/DKUNINSTALL.cmd"
	%dk_call% "%DKIMPORTS_DIR%/python3/DKUNINSTALL.cmd"
	%dk_call% "%DKIMPORTS_DIR%/tcc-rt/DKUNINSTALL.cmd"
	%dk_call% "%DKIMPORTS_DIR%/vc_redist/DKUNINSTALL.cmd"
	%dk_call% "%DKIMPORTS_DIR%/visualstudio/DKUNINSTALL.cmd"
	%dk_call% "%DKIMPORTS_DIR%/vs_coreeditorfonts/DKUNINSTALL.cmd"
	%dk_call% "%DKIMPORTS_DIR%/windows-sdk/DKUNINSTALL.cmd"
	::%dk_call% "%DKIMPORTS_DIR%/wsl/DKUNINSTALL.cmd"

	echo ### Creating backup of DKBuilder.cmd ###
	%dk_call% dk_copy "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%SystemDrive%/DKBuilder.cmd" OVERWRITE

	echo ### Removing DK Pins ###
	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	::%dk_call% dk_quickAccessUnpin "%DIGITALKNOB_DIR%"
	
	echo ### Deleting Simlinks ###
	%dk_call% dk_validate DKDESKTOP_DIR %dk_call% dk_DKDESKTOP_DIR
	%dk_call% dk_delete "%DKDESKTOP_DIR%/digitalknob"
	%dk_call% dk_delete "%DKDESKTOP_DIR%/DKBuilder.cmd"
	
	echo ### Deleting Shortcuts ###
	%dk_call% dk_validate DKDESKTOP_DIR %dk_call% dk_DKDESKTOP_DIR
	%dk_call% dk_delete "%DKDESKTOP_DIR%/digitalknob.lnk"

	echo ### Deleting DKCACHE_DIR ###
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	%dk_call% dk_delete "%DKCACHE_DIR%"

	echo ### Deleting DIGITALKNOB_DIR ###
	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	echo Do you want to delete the digitalknob folder ?
	%dk_call% dk_confirm || (exit /b 0)
	
	echo ###### Create a deleter, run is in a new process and exit this script
	echo ((goto) 2^>nul ^& cd "%SystemDrive%\" ^&^& rmdir /s /q "%DIGITALKNOB_DIR:/=\%") > "%TEMP%\delete_DK.cmd"
	echo ((goto) 2^>nul ^& del "%TEMP%\delete_DK.cmd" ^& %clearerror%) >> "%TEMP%\delete_DK.cmd"
	start "" /min "%TEMP%\delete_DK.cmd" & exit
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal

	%dk_call% DKUNINSTALL
%endfunction%
