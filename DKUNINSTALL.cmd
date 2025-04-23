@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
setlocal
	%dk_call% dk_debugFunc 0

	::###### Uninstall DK Languages ######
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	echo ############ Uninstall DK languages ############
	call %DKBRANCH_DIR%/DKBash/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKBatch/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKC/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKCMake/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKCpp/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKCSharp/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKHta/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKHtml/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKJava/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKJavascript/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKPhp/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKPowershell/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKPython/DKUNINSTALL.cmd
	call %DKBRANCH_DIR%/DKVb/DKUNINSTALL.cmd

	::###### Uninstall DK 3rdParty ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	echo ############ Uninstall 3rdParty #############
	call %DKIMPORTS_DIR%/git/contextMenu/DKUNINSTALL.cmd
	call %DKIMPORTS_DIR%/visualstudio/DKUNINSTALL.cmd
	call %DKIMPORTS_DIR%/windows-sdk/DKUNINSTALL.cmd
	call %DKIMPORTS_DIR%/vs_coreeditorfonts/DKUNINSTALL.cmd
	call %DKIMPORTS_DIR%/vs_coreeditorfonts/DKUNINSTALL.cmd
	call %DKIMPORTS_DIR%/python/DKUNINSTALL.cmd
	call %DKIMPORTS_DIR%/vc_redist/DKUNINSTALL.cmd

	::call %DKIMPORTS_DIR%/wsl/DKUNINSTALL.cmd

	::###### Backup DKBuilder.cmd to Desktop ######
	echo ### Creating backup of DKBuilder.cmd ###
	%dk_call% dk_copy "%DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd" "%SystemDrive%/DKBuilder.cmd" OVERWRITE

	::###### Delete DK Simlinks ######
	%dk_call% dk_validate DKDESKTOP_DIR "%dk_call% dk_DKDESKTOP_DIR"
	%dk_call% dk_delete "%DKDESKTOP_DIR%/digitalknob"
	%dk_call% dk_delete "%DKDESKTOP_DIR%/DKBuilder.cmd"

	::###### Delete DK Directories ######
	echo ### Deleting DKCACHE_DIR ###
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	%dk_call% dk_delete "%DKCACHE_DIR%"

	echo ### Deleting DIGITALKNOB_DIR ###
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	echo Do you want to delete the digitalknob folder ?
	%dk_call% dk_confirm || (exit /b 0)
	
	echo ((goto) 2>nul ^& cd "C:\" ^&^& rmdir /s /q "%DIGITALKNOB_DIR:/=\%") > C:\delete_DK.cmd
	start "" /MIN C:\delete_DK.cmd & exit
%endfunction%



:::DKRemoveFtype ftype_name
::	(ftype %~1 2>nul) && (ftype %~1=)
::	%dk_call% dk_registryDeleteKey "HKCR\%~1"
::%endfunction%

:::DKRemoveAssoc assoc_ext
::	(assoc %~1=)
::	%dk_call% dk_registryDeleteKey "HKCR\%~1"
::	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%~1"
::%endfunction%

:::DKRestoreDefault extension
::	::### .bat ###
::	if "%~1"==".bat" (
::		(ftype batfile="%%1" %%*)
::		(assoc .bat=batfile)
::	)
::	::### .c ###
::	::### .cmake ###
::	::### .cmd ###
::	if "%~1"==".cmd" (
::		(ftype cmdfile="%%1" %%*)
::		(assoc .cmd=cmdfile)
::		rem %windir%\system32\reg.exe import "%DKBATCH_DIR%\default.reg"
::	)
::	::### .cpp ###
::	::### .cs ###
::	::### .hta ###
::	::### .html ###
::	if "%~1"==".html" (
::		(ftype htmlfile="C:\Program Files\Internet Explorer\iexplore.exe" %%1)
::		(assoc .html=htmlfile)
::		rem %windir%\system32\reg.exe import "%DKHTML_DIR%\default.reg"
::	)
::	::### .java ###
::	::### .js ###
::	if "%~1"==".js" (
::		(ftype JSFile=%WINDIR%\System32\WScript.exe "%%1" %%*)
::		(assoc .js=JSFile)
::		rem %windir%\system32\reg.exe import "%DKJAVASCRIPT_DIR%\default.reg"
::	)
::	::### .php ###
::	::### .ps1 ###
::	if "%~1"==".ps1" (
::		(ftype Microsoft.PowerShellScript.1="%WINDIR%\System32\notepad.exe" "%%1")
::		(assoc .ps1=Microsoft.PowerShellScript.1)
::		rem %windir%\system32\reg.exe import "%DKPOWERSHELL_DIR%\default.reg"
::	)
::	::### .py ###
::	::### .sh ###
::	::### .vbs ###
::	if "%~1"==".vbs" (
::		(ftype VBSFile="%%SystemRoot%%\System32\WScript.exe" "%%1" %%*)
::		(assoc .vbs=VBSFile)
::		rem %windir%\system32\reg.exe import "%DKVB_DIR%\default.reg"
::	)
::%endfunction%


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% DKUNINSTALL
%endfunction%
