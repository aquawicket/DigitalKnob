@echo off
if not defined DKBATCH_FUNCTIONS_DIR_  set "DKBATCH_FUNCTIONS_DIR_=%CD%/DKBatch/functions/"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# DKUninstall()
::#
::#
:DKUninstall
setlocal
	%dk_call% dk_debugFunc 0

	echo:
	echo ############ Remove File Association (windows) ############
	(call :DKUninstallExt .bat)
	(call :DKUninstallExt .c)
	(call :DKUninstallExt .cmake)
	(call :DKUninstallExt .cmd)
	(call :DKUninstallExt .cpp)
	(call :DKUninstallExt .cs)
	(call :DKUninstallExt .hta)
	(call :DKUninstallExt .html)
	(call :DKUninstallExt .java)
	(call :DKUninstallExt .js)
	(call :DKUninstallExt .php)
	(call :DKUninstallExt .ps1)
	(call :DKUninstallExt .py)
	(call :DKUninstallExt .sh)
	(call :DKUninstallExt .vbs)
	
	echo:
	echo ############ Remove Context menus ############
	%dk_call% dk_registryDeleteKey "HKCR\AllFilesystemObjects\shell\GIT ADD"
	
	echo:
	echo ############ Remove Other registry entries ############
	%dk_call% dk_registryDeleteKey "HKCR\Applications\bash.exe"
	%dk_call% dk_registryDeleteKey "HKCU\Software\Classes\Applications\bash.exe"
	
%endfunction%

:DKUninstallExt extension
	if "%~1"==".bat"	(call :DKRemoveFtype DKBash)
	if "%~1"==".c"		(call :DKRemoveFtype DKC)
	if "%~1"==".cmake"	(call :DKRemoveFtype DKCmake)
	if "%~1"==".cmd"	(call :DKRemoveFtype DKBatch)
	if "%~1"==".cpp"	(call :DKRemoveFtype DKCpp)
	if "%~1"==".cs"		(call :DKRemoveFtype DKCSharp)
	if "%~1"==".hta"	(call :DKRemoveFtype DKHta)
	if "%~1"==".html"	(call :DKRemoveFtype DKHtml)
	if "%~1"==".java"	(call :DKRemoveFtype DKJava)
	if "%~1"==".js"		(call :DKRemoveFtype DKJavascript)
	if "%~1"==".php"	(call :DKRemoveFtype DKPhp)
	if "%~1"==".ps1"	(call :DKRemoveFtype DKPowershell)
	if "%~1"==".py"		(call :DKRemoveFtype DKPython)
	if "%~1"==".sh"		(call :DKRemoveFtype DKBash)
	if "%~1"==".vbs"	(call :DKRemoveFtype DKVb)
	
	(call :DKRemoveAssoc %~1)
	(call :DKRestoreDefault %~1)
%endfunction%

:DKRemoveFtype ftype_name
	(ftype %~1 2>nul) && (ftype %~1=)
	%dk_call% dk_registryDeleteKey "HKCR\%~1"
%endfunction%

:DKRemoveAssoc assoc_ext
	(assoc %~1=)
	%dk_call% dk_registryDeleteKey "HKCR\%~1"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%~1"
%endfunction%

:DKRestoreDefault extension
	::### .bat ###
	if "%~1"==".bat" (
		(ftype batfile="%%1" %%*)
		(assoc .bat=batfile)
	)
	::### .c ###
	::### .cmake ###
	::### .cmd ###
	if "%~1"==".cmd" (
		(ftype cmdfile="%%1" %%*)
		(assoc .cmd=cmdfile)
		rem %windir%\system32\reg.exe import "%DKBATCH_DIR%\default.reg"
	)
	::### .cpp ###
	::### .cs ###
	::### .hta ###
	::### .html ###
	if "%~1"==".html" (
		(ftype htmlfile="C:\Program Files\Internet Explorer\iexplore.exe" %%1)
		(assoc .html=htmlfile)
		rem %windir%\system32\reg.exe import "%DKHTML_DIR%\default.reg"
	)
	::### .java ###
	::### .js ###
	if "%~1"==".js" (
		(ftype JSFile=C:\Windows\System32\WScript.exe "%%1" %%*)
		(assoc .js=JSFile)
		rem %windir%\system32\reg.exe import "%DKJAVASCRIPT_DIR%\default.reg"
	)
	::### .php ###
	::### .ps1 ###
	if "%~1"==".ps1" (
		(ftype Microsoft.PowerShellScript.1="C:\Windows\System32\notepad.exe" "%%1")
		(assoc .ps1=Microsoft.PowerShellScript.1)
		rem %windir%\system32\reg.exe import "%DKPOWERSHELL_DIR%\default.reg"
	)
	::### .py ###
	::### .sh ###
	::### .vbs ###
	if "%~1"==".vbs" (
		(ftype VBSFile="%%SystemRoot%%\System32\WScript.exe" "%%1" %%*)
		(assoc .vbs=VBSFile)
		rem %windir%\system32\reg.exe import "%DKVB_DIR%\default.reg"
	)
%endfunction%


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% DKUninstall
%endfunction%
