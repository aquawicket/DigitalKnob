@echo off
if not defined DKBATCH_FUNCTIONS_DIR_  set "DKBATCH_FUNCTIONS_DIR_=%CD%/DKBatch/functions/"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# dk_uninstall()
::#
::#
:dk_uninstall
setlocal
	%dk_call% dk_debugFunc 0

	echo:
	echo ######## Remove File Types (windows) ############
	(call :dk_removeFtype DKBash)
	(call :dk_removeFtype DKBat)
	(call :dk_removeFtype DKBatch)
	(call :dk_removeFtype DKC)
	(call :dk_removeFtype DKCMake)
	(call :dk_removeFtype DKCSharp)
	(call :dk_removeFtype DKCpp)
	(call :dk_removeFtype DKHta)
	(call :dk_removeFtype DKHtml)
	(call :dk_removeFtype DKJScript)
	(call :dk_removeFtype DKJava)
	(call :dk_removeFtype DKJavascript)
	(call :dk_removeFtype DKPhp)
	(call :dk_removeFtype DKPowershell)
	(call :dk_removeFtype DKPython)
	(call :dk_removeFtype DKVb)
	
	echo:
	echo ############ Remove File Extensions (windows) ############
	(call :dk_removeAssoc .bat)
	(call :dk_removeAssoc .c)
	(call :dk_removeAssoc .cmake)
	(call :dk_removeAssoc .cmd)
	(call :dk_removeAssoc .cpp)
	(call :dk_removeAssoc .js)
	(call :dk_removeAssoc .ps1)
	(call :dk_removeAssoc .sh)
	(call :dk_removeAssoc .vbs)
	
	echo:
	echo ############ Remove Context menus ############
	::%dk_call% dk_registryDeleteKey "HKCR\AllFilesystemObjects\shell\GIT ADD"
	
	echo:
	echo ############ Remove Other registry entries ############
	%dk_call% dk_registryDeleteKey "HKCR\Applications\bash.exe"
	%dk_call% dk_registryDeleteKey "HKCU\Software\Classes\Applications\bash.exe"
	
	echo:
	echo ############ Restore Defaults ############
	
	
	
	
	
	
%endfunction%


:dk_removeFtype ftype_name
	(ftype %~1=)
	%dk_call% dk_registryDeleteKey "HKCR\%~1"
%endfunction%

:dk_removeAssoc assoc_ext
	(assoc %~1=)
	%dk_call% dk_registryDeleteKey "HKCR\%~1"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%~1"
	call: dk_restoreDefault %~1
%endfunction%

:dk_restoreDefault
	::### DKBatch ###
	if "%~1"==".bat" (
		ftype DKBatch=
		ftype batfile="%%1" %%*
		assoc .bat=batfile
	)
	::### DKC ###
	if "%~1"==".c" (
		ftype DKC=
		assoc .c=
	)
	::### DKCmake ###
	if "%~1"==".cmake" (
		ftype DKCmake=
		assoc .cmake=
	)
	::### DKBatch ###
	if "%~1"==".cmd" (
		rem %windir%\system32\reg.exe import "%DKBATCH_DIR%\default.reg"
		ftype DKBatch=
		ftype cmdfile="%%1" %%*
		assoc .cmd=cmdfile
	)
	::### DKCpp ###
	if "%~1"==".cpp" (
		ftype DKCpp=
		assoc .cpp=
	)
	::### DKCSharp ###
	if "%~1"==".cs" (
		ftype DKCSharp=
		assoc .cs=
	)
	::### DKHta ###
	if "%~1"==".hta" (
		ftype DKHta=
		assoc .hta=
	)
	::### DKHtml ###
	if "%~1"==".html" (
		rem %windir%\system32\reg.exe import "%DKHTML_DIR%\default.reg"
		ftype DKHtml=
		ftype htmlfile="C:\Program Files\Internet Explorer\iexplore.exe" %%1
		assoc .html=htmlfile
	)
	::### DKJava ###
	if "%~1"==".java" (
		ftype DKJava=
		assoc .java=
	)
	::### DKJavascript ###
	if "%~1"==".js" (
		rem %windir%\system32\reg.exe import "%DKJAVASCRIPT_DIR%\default.reg"
		ftype DKJavascript=
		ftype JSFile=C:\Windows\System32\WScript.exe "%%1" %%*
		assoc .js=JSFile
	)
	::### DKPhp ###
	if "%~1"==".php" (
		ftype DKPhp=
		assoc .php=
	)
	::### DKPowershell ###
	if "%~1"==".ps1" (
		rem %windir%\system32\reg.exe import "%DKPOWERSHELL_DIR%\default.reg"
		ftype DKPowershell=
		ftype Microsoft.PowerShellScript.1="C:\Windows\System32\notepad.exe" "%%1"
		assoc .ps1=Microsoft.PowerShellScript.1
	)
	::### DKPython ###
	if "%~1"==".py" (
		ftype DKPython=
		assoc .py=
	)
	::### DKBash ###
	if "%~1"==".sh" (
		ftype DKBash=
		assoc .sh=
	)
	::### DKVb ###
	if "%~1"==".vbs" (
		rem %windir%\system32\reg.exe import "%DKVB_DIR%\default.reg"
		ftype DKVb=
		ftype VBSFile="%%SystemRoot%%\System32\WScript.exe" "%%1" %%*
		assoc .vbs=VBSFile
	)
	
	
	
%endfunction%


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_uninstall
%endfunction%
