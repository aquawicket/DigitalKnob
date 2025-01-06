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
	::%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\GIT ADD"
	
	echo:
	echo ############ Remove Other registry entries ############
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\Applications\bash.exe"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\Software\Classes\Applications\bash.exe"
	
	echo:
	echo ############ Restore Defaults ############
	%windir%\system32\reg.exe import "%DKBATCH_DIR%\default.reg"
	%windir%\system32\reg.exe import "%DKHTML_DIR%\default.reg"
	%windir%\system32\reg.exe import "%DKJAVASCRIPT_DIR%\default.reg"
	%windir%\system32\reg.exe import "%DKPOWERSHELL_DIR%\default.reg"
	%windir%\system32\reg.exe import "%DKVB_DIR%\default.reg"
	
%endfunction%


:dk_removeFtype ftype_name
	(ftype %~1=)
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\%~1"
%endfunction%

:dk_removeAssoc assoc_ext
	(assoc %~1=)
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\%~1"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%~1"
	call: dk_restoreDefault %~1
%endfunction%

:dk_restoreDefault
	if "%~1"==".cmd" (
		ftype cmdfile="%%1" %%*
		assoc .cmd=cmdfile
	)
%endfunction%


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_uninstall
%endfunction%
