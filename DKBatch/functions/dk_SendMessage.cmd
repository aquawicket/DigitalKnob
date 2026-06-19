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
rem # dk_SendMessage(IntPtr hWnd, int Msg, int wParam, IntPtr lParam)
rem #
rem #		Sends a message and waits until the procedure which is responsible for the message finishes.
rem #
:dk_SendMessage
%setlocal%

	rem set "hwnd=%~1"
	rem set "Msg=%~2"
	rem set "wParam=%~3"
	rem set "lParam=%~4"
	
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
	set PS_SendMessage=%powershell.exe% -NoProfile -ExecutionPolicy Bypass -Command ^"^
	$dk=Add-Type -ReferencedAssemblies System.Drawing -Name WAPI -PassThru -MemberDefinition '^
	[System.Runtime.InteropServices.DllImport(\"user32.dll\", CharSet = System.Runtime.InteropServices.CharSet.Auto)]^
	   public static extern System.IntPtr SendMessage(System.IntPtr hWnd, int Msg, int wParam, System.IntPtr lParam);';^
	$SendMessage = $dk::SendMessage(%~1, %~2, %~3, %~4);"
	
	for /F "tokens=*" %%G IN ('%PS_SendMessage%') do (set "dk_SendMessage=%%~G")
	if not defined dk_SendMessage (set dk_SendMessage=%errorlevel%)
	
	:return
	endlocal & (
		set "dk_SendMessage=%dk_SendMessage%"
		if "%~1" neq "" (
			set "%~1=%dk_SendMessage%"
		) else (
			rem echo %dk_SendMessage%
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_fileVariables "%DKIMPORTS_DIR%/WindowsMessages/dkconfig.txt"
	
	%dk_call% dk_SendMessage %HWND_BROADCAST% %WM_SYSCOMMAND% %SC_MONITORPOWER% 	 2	&rem ### Turn Off Screen
	rem %dk_call% dk_SendMessage %HWND_BROADCAST% %WM_SYSCOMMAND% %SC_MONITORPOWER%	-1	&rem ### Turn On Screen
	rem %dk_call% dk_SendMessage %HWND_BROADCAST% %WM_SYSCOMMAND% %SC_MONITORPOWER% 	-1	&rem ### Put screen in low power mode
	rem %dk_call% dk_SendMessage %HWND_BROADCAST% %WM_SYSCOMMAND% %SC_SCREENSAVE%  	 0 	&rem ### Start screen saver
%endfunction%