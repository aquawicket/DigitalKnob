rem shebang
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


rem ############ pwsh ############
rem # https://github.com/PowerShell/PowerShell/releases
rem # https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm32.tar.gz
rem # https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-arm64.tar.gz
rem # https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-linux-x64.tar.gz
rem # https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-arm64.tar.gz
rem # https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell-7.2.19-osx-x64.tar.gz
rem # https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm32.zip
rem # https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-arm64.zip
rem # https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x86.zip
rem # https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/PowerShell-7.2.19-win-x64.zip

:DKINSTALL
%setlocal%
	
	%dk_call% dk_import
	
	%dk_call% dk_validate Host_Os %dk_call% dk_Host_Os
	echo Host_Os = %Host_Os%
	if /i "%Host_Os%" equ "Windows" ( 
		set "pwsh_exe=%pwsh_Install_Path%/pwsh.exe"
	) else ( 
		set "pwsh_exe=%pwsh_Install_Path%/pwsh"
	)	
	echo pwsh_exe = %pwsh_exe%
	%dk_call% dk_assertPath "%pwsh_exe%"
	%dk_call% dk_firewallAllow "%pwsh_exe%"

	rem if EXIST "%pwsh_exe%" (%dk_call% dk_success "pwsh install complete") else (%dk_call% dk_error "pwsh install failed")
	
	:return
	endlocal & (
		set "Host_Os=%Host_Os%"
		set "pwsh_exe=%pwsh_exe%"
		set "pwsh=%pwsh%"
	)
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate pwsh_exe    %dk_call% dk_depend pwsh
	%dk_call% dk_debug "pwsh = %pwsh%"
	%dk_call% dk_debug "pwsh_exe = %pwsh_exe%"
	 
%endfunction%

