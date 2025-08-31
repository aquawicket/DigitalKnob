<# ::
@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_setIcon(icon_path)
::#
::#
:dk_setIcon
%setlocal%
	%dk_call% dk_debugFunc 1
	
	powershell -c "iex ((Get-Content '%~f0') -join [Environment]::Newline); iex 'main %*'"
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
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
