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
rem # SetWindowIcon(hwnd, icon)
rem #
:SetWindowIcon
%setlocal%
	rem set "hwnd=%~1"
	rem set "icon=%~2"
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
	set PS_SetWindowIcon=%powershell.exe% -NoProfile -ExecutionPolicy Bypass -Command ^"^
	$dk=Add-Type -ReferencedAssemblies System.Drawing -Name WAPI -PassThru -MemberDefinition '^
	[System.Runtime.InteropServices.DllImport(\"user32.dll\", CharSet = System.Runtime.InteropServices.CharSet.Auto)]^
	   public static extern System.IntPtr SendMessage(System.IntPtr hWnd, int Msg, int wParam, System.IntPtr lParam);^
	public static void CS_SetWindowIcon(System.IntPtr hwnd, System.String ico) {^
		System.Drawing.Icon icon = new System.Drawing.Icon(ico);^
		System.IntPtr result01 = SendMessage(hwnd, 0x0080, 0, icon.Handle);^
		System.IntPtr result02 = SendMessage(hwnd, 0x0080, 1, icon.Handle);^
		System.IntPtr result03 = SendMessage(hwnd, 0x0080, 2, icon.Handle);^
	}';^
	$dk::CS_SetWindowIcon(%~1, \"%~2\");"
	
	for /F "tokens=*" %%G IN ('%PS_SetWindowIcon%') do (set "SetWindowIcon=%%~G")
	if not defined SetWindowIcon (set SetWindowIcon=%errorlevel%)
	
	:return
	endlocal & (
		set "SetWindowIcon=%SetWindowIcon%"
		if "%~1" neq "" (
			set "%~1=%SetWindowIcon%"
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% GetConsoleWindow
	%dk_call% dk_debug "GetConsoleWindow = %GetConsoleWindow%"
	
	%dk_call% SetWindowIcon %GetConsoleWindow% "%CD:\=/%/icon.ico"
	%dk_call% dk_debug "SetWindowIcon = %SetWindowIcon%"	
%endfunction%