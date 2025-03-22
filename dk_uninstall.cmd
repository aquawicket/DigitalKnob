@echo off
if not defined DKBATCH_FUNCTIONS_DIR_  (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::############################################################################
::# dk_uninstall()
::#
:dk_uninstall
setlocal
	%dk_call% dk_debugFunc 0

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

	echo ############ Uninstall 3rdParty #############
	call %DKBRANCH_DIR%/3rdParty/_DKIMPORTS/git/contextMenu/dk_uninstall.cmd

%endfunction%
	::##############################################################

	echo:
	echo ### Uninstalling Microsoft Visual Studio BuildTools ###
	"C:\Program Files (x86)\Microsoft Visual Studio\Installer\setup.exe" uninstall --installPath "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"

	echo:
	echo ### Uninstalling Windows Software Development Kit ###
	"C:\ProgramData\Package Cache\{71684ad3-afc2-4a65-9d45-92ef58510f18}\winsdksetup.exe" /uninstall /quiet

	echo:
	echo ### Uninstalling vs_CoreEditorFonts ###
	MsiExec.exe /uninstall {1851460E-0E63-4117-B5BA-25A2F045801B} /quiet

	echo:
	echo ### Uninstalling Windows SDK AddOn ###
	MsiExec.exe /uninstall {F1E37C98-16B7-421F-BA33-6C5B5400012A} /quiet

	echo:
	echo ### Uninstalling Microsoft Visual Studio Installer ###
	"C:\Program Files (x86)\Microsoft Visual Studio\Installer\setup.exe" /uninstall

	echo:
	echo ### Uninstalling Python 2.7.18 ###
	MsiExec.exe /uninstall {A5F504DF-2ED9-4A2D-A2F3-9D2750DD42D6} /quiet

	echo:
	echo ### Uninstalling Windows Subsystem for Linux ###
	MsiExec.exe /uninstall {AAAA4669-FCEF-4B2A-8355-1E0FA411A269} /quiet

	echo:
	echo ### Creating backup of DKBuilder.cmd ###
	%dk_call% dk_validate DKDESKTOP_DIR "%dk_call% dk_DKDESKTOP_DIR"
	%dk_call% dk_copy "%DKBATCH_FUNCTIONS_DIR_%DKBuilder.cmd" "%DKDESKTOP_DIR%\DKBuilder.cmd"

	echo:
	echo ### Deleting DKCACHE_DIR ###
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	%dk_call% dk_delete "%DKCACHE_DIR%"

	echo:
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	echo Do you want to delete %DIGITALKNOB_DIR% ?
	%dk_call% dk_confirm || (exit /b 0)

	echo ### Deleting DIGITALKNOB_DIR ###
	%dk_call% dk_delete "%DKCACHE_DIR%"
%endfunction%

:::DKUninstallExt extension
::	if "%~1"==".bat"	(call :DKRemoveFtype DKBash)
::	if "%~1"==".c"		(call :DKRemoveFtype DKC)
::	if "%~1"==".cmake"	(call :DKRemoveFtype DKCmake)
::	if "%~1"==".cmd"	(call :DKRemoveFtype DKBatch)
::	if "%~1"==".cpp"	(call :DKRemoveFtype DKCpp)
::	if "%~1"==".cs"		(call :DKRemoveFtype DKCSharp)
::	if "%~1"==".hta"	(call :DKRemoveFtype DKHta)
::	if "%~1"==".html"	(call :DKRemoveFtype DKHtml)
::	if "%~1"==".java"	(call :DKRemoveFtype DKJava)
::	if "%~1"==".js"		(call :DKRemoveFtype DKJavascript)
::	if "%~1"==".php"	(call :DKRemoveFtype DKPhp)
::	if "%~1"==".ps1"	(call :DKRemoveFtype DKPowershell)
::	if "%~1"==".py"		(call :DKRemoveFtype DKPython)
::	if "%~1"==".sh"		(call :DKRemoveFtype DKBash)
::	if "%~1"==".vbs"	(call :DKRemoveFtype DKVb)
::
::	(call :DKRemoveAssoc %~1)
::	(call :DKRestoreDefault %~1)
::%endfunction%

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
