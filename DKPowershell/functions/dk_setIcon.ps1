if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_setIcon_ps1){ $dk_setIcon_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_setIcon()
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_setIcon() {
	dk_debugFunc 1;

	$w=Add-Type -ReferencedAssemblies System.Drawing -Name WAPI -PassThru -MemberDefinition '
	[DllImport("kernel32.dll")] static extern bool AllocConsole();
	[DllImport("kernel32.dll")] static extern System.IntPtr GetConsoleWindow();
	[DllImport("user32.dll", CharSet = System.Runtime.InteropServices.CharSet.Auto)]
	static extern System.IntPtr SendMessage(System.IntPtr hWnd, int Msg, int wParam, System.IntPtr lParam);
	public static void SetIcon(string icon_path) {
		System.Drawing.Icon icon = new System.Drawing.Icon(icon_path);
		System.IntPtr handle = GetConsoleWindow();
		if(handle == System.IntPtr.Zero) { AllocConsole(); }
		System.IntPtr result01 = SendMessage(handle, 0x0080, 0, icon.Handle);
		System.IntPtr result02 = SendMessage(handle, 0x0080, 1, icon.Handle);
		System.IntPtr result03 = SendMessage(handle, 0x0080, 2, icon.Handle);
	}'
	$w::SetIcon($args[0])
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	dk_call dk_echo "setting console icon ...";
	dk_call dk_setIcon "icon.ico";
}
