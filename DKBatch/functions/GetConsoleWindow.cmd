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


rem ####################################################################
rem # GetConsoleWindow()
rem #
:GetConsoleWindow
%setlocal%
	
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
	set PS_GetConsoleWindow=%powershell.exe% -NoProfile -ExecutionPolicy Bypass -Command ^"^
	$dk=Add-Type -Name WAPI -PassThru -MemberDefinition '^
	[System.Runtime.InteropServices.DllImport(\"kernel32.dll\")] static extern bool AllocConsole();^
	[System.Runtime.InteropServices.DllImport(\"kernel32.dll\")] public static extern IntPtr GetConsoleWindow();^
	public static IntPtr CS_GetConsoleWindow() {^
		System.IntPtr handle = GetConsoleWindow();^
		if(handle == System.IntPtr.Zero) { AllocConsole(); }^
		return handle;^
	}';^
	Write-Host $dk::CS_GetConsoleWindow();"

	for /F "tokens=*" %%G IN ('%PS_GetConsoleWindow%') do (set "GetConsoleWindow=%%~G")
	if not defined GetConsoleWindow (set GetConsoleWindow=%errorlevel%)
	
	:return
	endlocal & (
		set "GetConsoleWindow=%GetConsoleWindow%"
		if "%~1" neq "" (
			set "%~1=%GetConsoleWindow%"
		) else (
			rem echo %GetConsoleWindow%
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% GetConsoleWindow
	%dk_call% dk_debug "GetConsoleWindow = %GetConsoleWindow%"
	
	%dk_call% GetConsoleWindow consoleWindow
	%dk_call% dk_debug "consoleWindow = %consoleWindow%"
%endfunction%