<# ::
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


rem ################################################################################
rem # dk_setIcon(icon_path)
rem #
rem #
:dk_setIcon
%setlocal%
	
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
	%powershell.exe% -c "iex ((Get-Content '%~f0') -join [Environment]::Newline); iex 'main %*'"
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_setIcon "icon.ico"
%endfunction%


#>
function main {

$code = @'
public class ConsoleWindow{
	[System.Runtime.InteropServices.DllImport("kernel32.dll")] static extern bool AllocConsole();
	[System.Runtime.InteropServices.DllImport("kernel32.dll")] static extern System.IntPtr GetConsoleWindow();
	[System.Runtime.InteropServices.DllImport("user32.dll", CharSet = System.Runtime.InteropServices.CharSet.Auto)]
	static extern System.IntPtr SendMessage(System.IntPtr hWnd, int Msg, int wParam, System.IntPtr lParam);
	[System.STAThread] public static void Main(string[] args) {
		System.Drawing.Icon icon = new System.Drawing.Icon(args[0]);
		System.IntPtr handle = GetConsoleWindow();
		if(handle == System.IntPtr.Zero) { AllocConsole(); }
		System.IntPtr result01 = SendMessage(handle, 0x0080, 0, icon.Handle);
		System.IntPtr result02 = SendMessage(handle, 0x0080, 1, icon.Handle);
		System.IntPtr result03 = SendMessage(handle, 0x0080, 2, icon.Handle);
	}
}
'@


Add-Type -TypeDefinition $code -ReferencedAssemblies @('System.Drawing') -Language CSharp
[ConsoleWindow]::Main($args[0])
}
