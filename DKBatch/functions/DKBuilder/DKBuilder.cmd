@rem shebang
@echo off&:###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	set "curl.exe=!curl.exe:%SystemRoot%\System32\curl.exe!=!"
  if NOT EXIST "!curl.exe!" (for /F "tokens=*" %%G IN ('dir /b/s/a:-d "%SystemDrive%\curl.exe"') do (set "curl.exe=%%~fG"))
	if NOT EXIST "!curl.exe!" (copy "D:\DigitalKnob\download\curl.exe" "%USERPROFILE%\Digital Knob\DKTools\curl.exe")
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT EXIST "!DK.cmd!" (for /F "tokens=*" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
    start "" /b /wait /min "!curl.exe:/=\!" --silent --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "!curl.exe:/=\!" --create-dirs --output "!DK.cmd!" file:///D:/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	pause
	exit /b %errorlevel%
)
::#################################################################################################################################################


:DKTEST
 	call :DKBuilder
exit /b %errorlevel%
rem ########### In oreder of importance #########################################
rem ###### Crucial to run cmd.exe ###############################################
rem (set ProgramFiles(x86)=)		&rem 	C:\Program Files (x86)
rem (set CommonProgramFiles(x86)=)	&rem 	C:\Program Files (x86)\Common Files
rem (set SystemRoot=)				&rem 	C:\Windows
rem ###### Needed by DigitalKnob ################################################
rem (set Path=)			&rem	C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\
rem (set PATHEXT=)					&rem	.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.RB;.RBW;.;
rem (set ComSpec=)					&rem	C:\Windows\System32\cmd.exe
rem (set USERPROFILE=)				&rem 	C:\Users\Administrator
rem (set SystemDrive=)				&rem	C:
rem (set USERNAME=)					&rem	Administrator
rem (set PROCESSOR_ARCHITECTURE=)	&rem	AMD64
rem (set OS=)						&rem	Windows_NT	
rem (set HOMEDRIVE=)				&rem	C:
rem (set PROMPT=)					&rem	$P$G
rem (set HOMEPATH=)					&rem	\Users\Administrator
rem (set ProgramFiles=)				&rem	C:\Program Files
rem (set PSModulePath=)				&rem	C:\Program Files\WindowsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules
rem (set COMPUTERNAME=)				&rem	WIN-31SRRG2M2LD
rem (set windir=)					&rem	C:\Windows
rem ########## Safe to Disable ########################
rem (set ProgramW6432=)					&rem	C:\Program Files
rem (set TMP=)							&rem	C:\Users\ADMINI~1\AppData\Local\Temp
rem (set TEMP=)							&rem	C:\Users\ADMINI~1\AppData\Local\Temp
rem (set SESSIONNAME=)					&rem	Console
rem (set ZES_ENABLE_SYSMAN=)			&rem	1
rem (set USERDOMAIN_ROAMINGPROFILE=)	&rem	WIN-31SRRG2M2LD
rem (set USERDOMAIN=)					&rem	WIN-31SRRG2M2LD
rem (set PUBLIC=)						&rem	C:\Users\Public
rem (set ProgramData=)					&rem	C:\ProgramData
rem (set PROCESSOR_REVISION=)			&rem	8e09
rem (set PROCESSOR_LEVEL=)				&rem	6
rem (set PROCESSOR_IDENTIFIER=)			&rem	Intel64 Family 6 Model 142 Stepping 9, GenuineIntel
rem (set NUMBER_OF_PROCESSORS=)			&rem	4
rem (set LOGONSERVER=)					&rem	\\WIN-31SRRG2M2LD
rem (set LOCALAPPDATA=)					&rem	C:\Users\Administrator\AppData\Local
rem (set DriverData=)					&rem	C:\Windows\System32\Drivers\DriverData
rem (set CommonProgramW6432=)			&rem	C:\Program Files\Common Files
rem (set CommonProgramFiles=)			&rem	C:\Program Files\Common Files
rem (set APPDATA=)						&rem	C:\Users\Administrator\AppData\Roaming
rem (set ALLUSERSPROFILE=)				&rem	C:\ProgramData

:DKBuilder
	rem ###### https://learn.microsoft.com/en-us/dotnet/standard/io/file-path-formats
	rem ###### https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file#win32-file-namespaces
	rem 
	rem                  C:\Users\Administrator\Digital Knob\Development\README.md	Windows
	rem              \\?\C:\Users\Administrator\Digital Knob\Development\README.md	Windows (file namespace)
	rem				 \\.\C:\Users\Administrator\Digital Knob\Development\README.md	Windows (device namespace)
	rem                  /c/Users/Administrator/Digital Knob/Development/README.md	Msys2
	rem              /mnt/c/Users/Administrator/Digital Knob/Development/README.md	Wsl
	rem          file:///C:/Users/Administrator/Digital%20Knob/Development/README.md	file://
	rem file://localhost/C:/Users/Administrator/Digital%20Knob/Development/README.md	file:// (localhost)
	rem                   http://aquawicket.com/Digital%20Knob/Development/README.md	http://
	rem  ftp://access912915170.webspace-data.io/Digital%20Knob/Development/README.md	 ftp://
	rem sftp://access912915170.webspace-data.io/Digital%20Knob/Development/README.md	sftp://

rem	rem ############ extract DK.cmd from DigitalKnob.tar.gz ############
rem		rem takeown /F %DKF% /R /D "Y"	
rem	)
	
	%dk_call% DKBuilder/main
%endfunction%


:dk_download url destination
setlocal enableDelayedExpansion
	set "url=%~1"
	set "dest=%~2"
	rem ############ download w/ curl ############
	if NOT EXIST "%dest%" (
		if NOT EXIST "%curl.exe%" (set "curl.exe=%SystemRoot:\=/%/System32/curl.exe")
		call :dk_firewallAllow "!curl.exe!"
		"!curl.exe:/=\!" --silent --show-error --location --create-dirs --output "%dest:/=\%" %url%
	)
	
	rem ############ download w/ certutil ############
	if NOT EXIST "%dest%" (
		if NOT EXIST "%certutil.exe%" (set "certutil.exe=%SystemRoot:\=/%/System32/certutil.exe")
		call :dk_firewallAllow "!certutil.exe!"
		"!certutil.exe:/=\!" -urlcache -split -f "%url%" "%dest:/=\%"
	)
	
	rem ############ download w/ powershell ############
	if NOT EXIST "%dest%" (
		if NOT EXIST "%powershell.exe%" (set "powershell.exe=%SystemRoot:\=/%/System32/WindowsPowershell/v1.0/powershell.exe")
		call :dk_firewallAllow "!powershell.exe!"
		"!powershell.exe:/=\!" -c "(New-Object Net.WebClient).DownloadFile('%url%','%dest:/=\%')"
	)
	
	rem ############ download w/ bitsadmin ############
	if NOT EXIST "%dest%" (
		if NOT EXIST "%bitsadmin.exe%" (set "bitsadmin.exe=%SystemRoot:\=/%/System32/bitsadmin.exe")
		call :dk_firewallAllow "!bitsadmin.exe!"
		"!bitsadmin.exe:/=\!" /transfer /Download /priority Foreground "%url%" "%dest:/=\%"
	)

	if NOT EXIST "%dest%" (echo ERROR: DK.cmd download Failed & pause & exit 1)
exit /b %errorlevel%


:dk_registryContains regPath find
setlocal enableDelayedExpansion
	set "regPath=%~1"
	set "find=%~2"
	if NOT EXIST "%reg.exe%" (set "reg.exe=%SystemRoot:\=/%/System32/reg.exe")
	for /f "usebackq delims=" %%a in (`"%reg.exe:/=\%" query "%regPath:/=\%" 2^>nul`) do (
		set "line=%%a"
		if "x!line:%find%=!x" equ "x%%ax" (exit /b 1)
	)
exit /b %errorlevel%


:dk_firewallAllow filepath
	set "filepath=%~1"
	call :dk_registryContains "HKLM/SYSTEM/ControlSet001/Services/SharedAccess/Parameters/FirewallPolicy/FirewallRules" "%filepath:/=\%" && exit /b %errorlevel%
	rem ###### netsh ######
	if NOT EXIST "%netsh.exe%" (set "netsh.exe=%SystemRoot:\=/%/System32/netsh.exe")
	if EXIST "%netsh.exe%" ("%netsh.exe:/=\%" advfirewall firewall add rule name="%~n1" dir=in action=allow program="%filepath:/=\%" enable=yes profile=any)
	if EXIST "%netsh.exe%" ("%netsh.exe:/=\%" advfirewall firewall add rule name="%~n1" dir=out action=allow program="%filepath:/=\%" enable=yes profile=any)
	rem ###### Windows Firewall Control ######
	if NOT EXIST "%WFC_APP%" (set "WFC_APP=%ProgramFiles:\=/%/Malwarebytes/Windows Firewall Control/wfc.exe")
	if NOT EXIST "%WFC_APP%" (set "WFC_APP=%ProgramFiles:\=/%/Malwarebytes/Windows Firewall Control/wfcUI.exe")
	if EXIST "%WFC_APP%" ("%WFC_APP:/=\%" -allow "%filepath:/=\%")
exit /b %errorlevel%


