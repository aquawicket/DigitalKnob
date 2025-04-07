@echo off
if not defined DKBATCH_FUNCTIONS_DIR_  (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::############################################################################
::# dk_uninstall()
::#
:dk_uninstall
setlocal
	%dk_call% dk_debugFunc 0

	::###### Uninstall DK Languages ######
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	echo ############ Uninstall DK languages ############
	call %DKBRANCH_DIR%/DKBash/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKBatch/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKC/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKCMake/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKCpp/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKCSharp/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKHta/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKHtml/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKJava/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKJavascript/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKPhp/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKPowershell/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKPython/dk_uninstall.cmd
	call %DKBRANCH_DIR%/DKVb/dk_uninstall.cmd

	::###### Uninstall DK 3rdParty ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	echo ############ Uninstall 3rdParty #############
	call %DKIMPORTS_DIR%/git/contextMenu/dk_uninstall.cmd
	call %DKIMPORTS_DIR%/visualstudio/dk_uninstall.cmd
	call %DKIMPORTS_DIR%/windows-sdk/dk_uninstall.cmd
	call %DKIMPORTS_DIR%/vs_coreeditorfonts/dk_uninstall.cmd
	call %DKIMPORTS_DIR%/vs_coreeditorfonts/dk_uninstall.cmd
	call %DKIMPORTS_DIR%/python/dk_uninstall.cmd

	::call %DKIMPORTS_DIR%/wsl/dk_uninstall.cmd

	::###### Backup DKBuilder.cmd to Desktop ######
	echo ### Creating backup of DKBuilder.cmd ###
	%dk_call% dk_copy "%DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd" "%SystemDrive%/DKBuilder.cmd"

	::###### Delete DK Simlinks ######
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
	((goto) 2>nul & cd "C:\" && rmdir /s /q "%DIGITALKNOB_DIR%") 
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

	call :dk_uninstall
%endfunction%
