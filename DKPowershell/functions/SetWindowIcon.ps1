if(!(${ENV:DKPOWERSHELL_FUNCTIONS_DIR})){ ${ENV:DKPOWERSHELL_FUNCTIONS_DIR} = "${ENV:USERPROFILE}/Digital Knob/Development/DKPowershell/functions" -replace "\\", "/"; }
if(${ENV:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${ENV:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$SetWindowIcon_ps1){ $SetWindowIcon_ps1 = 1; } else{ return; } #include guard

################################################################################
# GetConsoleWindow(hwnd, ico)
#
#
function Global:SetWindowIcon(){
	dk_debugFunc 2;
	
	#$consoleHwnd 	= $($args[0]);
	#$ico 			= $($args[1]);
	
	$dk=Add-Type -ReferencedAssemblies System.Drawing -Name WINUSERAPI -PassThru -MemberDefinition '
	[System.Runtime.InteropServices.DllImport("user32.dll", CharSet = System.Runtime.InteropServices.CharSet.Auto)]
		public static extern System.IntPtr SendMessage(System.IntPtr hWnd, int Msg, int wParam, System.IntPtr lParam);
		public static void CS_SetWindowIcon(System.IntPtr hwnd, System.String ico) {
			System.Drawing.Icon icon = new System.Drawing.Icon(ico);
			System.IntPtr result01 = SendMessage(hwnd, 0x0080, 0, icon.Handle);
			System.IntPtr result02 = SendMessage(hwnd, 0x0080, 1, icon.Handle);
			System.IntPtr result03 = SendMessage(hwnd, 0x0080, 2, icon.Handle);
		}'
	
	$dk::CS_SetWindowIcon($($args[0]), $($args[1]));
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call GetConsoleWindow;
	#dk_call dk_debug "GetConsoleWindow = ${GetConsoleWindow}";
	dk_call SetWindowIcon ${GetConsoleWindow} "${PSScriptRoot}/icon.ico";
	#dk_call dk_debug "SetWindowIcon = ${SetWindowIcon}";
}