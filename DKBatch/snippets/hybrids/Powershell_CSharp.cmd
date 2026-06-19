<# ::
@echo off
powershell -c "iex ((Get-Content '%~f0') -join [Environment]::Newline); iex 'main %*'"
set exit_code=%ERRORLEVEL%
echo exit_code = %exit_code%
pause
exit /b %exit_code%

.SYNOPSIS
This is a hybrid Batch/PowerShell script that embeds C# within PowerShell.
This is a simpler approach than the hybrid-csharp.bat because there's less up-front
scripting and the C# compilation is done in-memory.

.DESCRIPTION
The top of the script begins with <#:: which is a batch redirection direcctive
meaning that <#: will be parsed as :<# which looks like a label in a batch script
but <# is also a valid powershell comment opener.

The next line turns off echo for batch scripts but remember we're now in a PowerShell
comment block so this is meaningless when the script is loaded by PowerShell.

And the last important line is the third line which invokes powershell.exe, loading
the current script. Note also that it invokes the 'main' function in the content
so we must implement a 'main' function below. Finally, we pass %* into the main
function which is the command-line argument collection for the batch script.
#>

### POWERSHELL ###
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

### POWERSHELL ###
Add-Type -TypeDefinition $code -ReferencedAssemblies @('System.Drawing') -Language CSharp
[ConsoleWindow]::Main("icon.ico")
}
