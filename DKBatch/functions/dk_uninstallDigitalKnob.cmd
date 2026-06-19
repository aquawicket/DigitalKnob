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
rem # dk_uninstallDigitalKnob()
rem #
rem #
:dk_uninstallDigitalKnob
%setlocal%
 
	rem ###### Uninstall DK Languages ######
	echo ############ Uninstall DK Languages ############
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	%dk_call% "%DKBranch_Dir%/DKBash/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKBatch/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKC/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKCMake/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKCpp/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKCSharp/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKHta/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKHtml/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKJava/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKJavascript/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKPhp/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKPowershell/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKPython/DKUNINSTALL.cmd"
	%dk_call% "%DKBranch_Dir%/DKVbs/DKUNINSTALL.cmd"

	rem ###### Uninstall DK 3rdParty ######
	echo ############ Uninstall 3rdParty #############
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% "%DKImports_Dir%/git/contextMenu/DKUNINSTALL.cmd"
rem	%dk_call% "%DKImports_Dir%/python/DKUNINSTALL.cmd"
rem	%dk_call% "%DKImports_Dir%/python3/DKUNINSTALL.cmd"
rem	%dk_call% "%DKImports_Dir%/tcc-rt/DKUNINSTALL.cmd"
rem	%dk_call% "%DKImports_Dir%/vc_redist/DKUNINSTALL.cmd"
rem	%dk_call% "%DKImports_Dir%/visualstudio/DKUNINSTALL.cmd"
rem	%dk_call% "%DKImports_Dir%/vs_coreeditorfonts/DKUNINSTALL.cmd"
rem	%dk_call% "%DKImports_Dir%/windows-sdk/DKUNINSTALL.cmd"
rem	%dk_call% "%DKImports_Dir%/wsl/DKUNINSTALL.cmd"

	rem ###### git clean DKBRANCH_DIR ######
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_gitClean %DKBranch_Dir%

	rem ###### Kill lingering processes ######
	%dk_call% dk_killProcess gpg-agent.exe

	rem ###### Remove DK Pins ######
	echo ### Unpin quicklinks ###
	%dk_call% dk_quickAccessUnpin "%DigitalKnob_Dir%"
	
	rem ###### Delete DK Simlinks ######
	echo ### Deleting Simlinks ###
	%dk_call% dk_validate DKDESKTOP_DIR %dk_call% dk_DKDESKTOP_DIR
	%dk_call% dk_delete "%DKDesktop_Dir%/DigitalKnob"
	%dk_call% dk_delete "%DKDesktop_Dir%/DKBuilder.cmd"
	
	rem ###### Delete DK Shortcuts ######
	echo ### Deleting Shortcuts ###
	%dk_call% dk_validate DKDESKTOP_DIR %dk_call% dk_DKDESKTOP_DIR
	%dk_call% dk_delete "%DKDesktop_Dir%/DigitalKnob.lnk"
	%dk_call% dk_delete "%DKDesktop_Dir%/DKBuilder.lnk"

	rem ###### Backup DKBuilder.cmd to C:/ ######
	echo ### Creating backup of DKBuilder.cmd ###
	%dk_call% dk_copy "%DKBranch_Dir%/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%SystemDrive%/DKBuilder.cmd" OVERWRITE
	
	rem ###### Delete DKBranch_Dir_BACKUP ######
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	if exist "%DKBRANCH_DIR%_BACKUP" (
		%dk_call% dk_delete "%DKBRANCH_DIR%_BACKUP"
	)
	
	rem ###### Delete DKStorage_Dir ######
	%dk_call% dk_validate DKStorage_Dir %dk_call% dk_DKStorage_Dir
	%dk_call% dk_delete "%DKStorage_Dir%"
	
	rem ###### Delete DKTOOLS_DIR ######
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_delete "%DKTools_Dir%"
	
	rem ###### Delete DKDOWNLOAD_DIR ######
	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	%dk_call% dk_delete "%DKDownload_Dir%"
	
	rem ###### Delete DKCACHE_DIR ######
	echo ### Deleting DKCACHE_DIR ###
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	%dk_call% dk_delete "%DKCache_Dir%"

	rem ###### Deleting DIGITALKNOB_DIR ######
	%dk_call% dk_deleteDigitalKnob

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_uninstallDigitalKnob
%endfunction%

