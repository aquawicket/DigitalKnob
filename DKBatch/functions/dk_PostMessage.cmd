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
rem # dk_PostMessage(IntPtr hWnd, int Msg, int wParam, IntPtr lParam)
rem #
rem #		Send a message to the message queue and return immediately.
rem #
:dk_PostMessage
%setlocal%

	rem set "hwnd=%~1"
	rem set "Msg=%~2"
	rem set "wParam=%~3"
	rem set "lParam=%~4"
	
	set pscommand=powershell -NoProfile -ExecutionPolicy Bypass -Command ^"^
	$dk=Add-Type -ReferencedAssemblies System.Drawing -Name WAPI -PassThru -MemberDefinition '^
	[System.Runtime.InteropServices.DllImport(\"user32.dll\", CharSet = System.Runtime.InteropServices.CharSet.Auto)]^
	   public static extern System.IntPtr PostMessage(System.IntPtr hWnd, int Msg, int wParam, System.IntPtr lParam);';^
	$PostMessage = $dk::PostMessage(%~1, %~2, %~3, %~4);"
	
	for /F "tokens=*" %%G IN ('%pscommand%') do (set "dk_PostMessage=%%~G")
	if not defined dk_PostMessage (set dk_PostMessage=%errorlevel%)
	
	:return
	endlocal & (
		set "dk_PostMessage=%dk_PostMessage%"
		if "%~1" neq "" (
			set "%~1=%dk_PostMessage%"
		) else (
			rem echo %dk_PostMessage%
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_fileVariables "%DKIMPORTS_DIR%/WindowsMessages/dkconfig.txt"
	
	%dk_call% dk_PostMessage %HWND_BROADCAST% %WM_SYSCOMMAND% %SC_MONITORPOWER% 	 2	&rem ### Turn Off Screen
	rem %dk_call% dk_PostMessage %HWND_BROADCAST% %WM_SYSCOMMAND% %SC_MONITORPOWER%	-1	&rem ### Turn On Screen
	rem %dk_call% dk_PostMessage %HWND_BROADCAST% %WM_SYSCOMMAND% %SC_MONITORPOWER% 	-1	&rem ### Put screen in low power mode
	rem %dk_call% dk_PostMessage %HWND_BROADCAST% %WM_SYSCOMMAND% %SC_SCREENSAVE%  	 0 	&rem ### Start screen saver
%endfunction%