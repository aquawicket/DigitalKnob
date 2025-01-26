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
	(call :DKUninstallExt .css)
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
	::%dk_call% dk_registryDeleteKey "HKCR\Applications\bash.exe"
	::%dk_call% dk_registryDeleteKey "HKCU\Software\Classes\Applications\bash.exe"
	::%dk_call% dk_registryDeleteKey "HKCR\Local Settings\Software\Microsoft\Windows\Shell\MuiCache\???"
	::Computer\HKEY_CURRENT_USER\Software\Caphyon
	::Computer\HKEY_CURRENT_USER\Software\Kitware
	::Computer\HKEY_CURRENT_USER\Software\Microsoft\Installer\Products\FD405F5A9DE2D2A42A3FD97205DD246D
	::Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\App Paths\Python.exe
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Cygwin
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{A5F504DF-2ED9-4A2D-A2F3-9D2750DD42D6}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{DAC6B921-1A83-4E0C-9201-69F1C21CA5BD}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{F2A5C4B0-156F-42A6-84E2-37A5F1055E2C}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{F5796163-6EC6-488A-B2DE-E1E94477F6AD}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{0312181A-61FD-4243-9A1E-136130D65400}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{0460C87B-7F4C-3170-FAC9-B7A6AE5CE4E9}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{1851460E-0E63-4117-B5BA-25A2F045801B}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{49727420-70BA-4495-9405-31F8D711CB5A}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{5DB1904E-A0D2-488A-8E10-C94264FCD295}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{731F33C3-7B4A-405C-86FA-DD6FCAB2C4A3}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{88FCEC0E-C47D-47BA-BC19-144AFBF375FB}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{B1AAC1B5-CF8F-4A55-9F96-D74E9D5847C0}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{B362C26A-A729-4FCD-B603-204D66F065D7}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{B75F3157-7A65-4666-B62F-1E29EFC683C9}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{D07657AA-968C-4629-BD6C-1B52AF825EA7}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{D1B99412-81F4-4A2C-8D65-F974A64ACBF9}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{D78E4A11-26C4-4357-AB0D-2B51EEE8C8F2}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{D9782C75-3472-4C8E-B443-8F06DE7EDBF5}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{DC32F9F4-12C7-4219-96D6-3ECD348B4C25}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{ECD9D149-549D-4E0F-9900-B1CB3DDAE9E0}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{F17112B4-706F-4FED-8C99-3443572EB9D2}
	::Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{F408B665-3667-4FCE-9EF3-A61B159AED56}
	
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
