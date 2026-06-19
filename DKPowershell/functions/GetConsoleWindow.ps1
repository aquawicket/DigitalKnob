if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$GetConsoleWindow_ps1){ $GetConsoleWindow_ps1 = 1; } else{ return; } #include guard

################################################################################
# GetConsoleWindow()
#
#
function Global:GetConsoleWindow(){
	dk_debugFunc 0 1;
	
	$dk=Add-Type -Name Conole -PassThru -MemberDefinition '
	[System.Runtime.InteropServices.DllImport("kernel32.dll")] public static extern bool AllocConsole();
	[System.Runtime.InteropServices.DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
	public static IntPtr CS_GetConsoleWindow() {
		System.IntPtr handle = GetConsoleWindow();
		if(handle == System.IntPtr.Zero) { AllocConsole(); }
		return handle;
	}'

	###### return ######
	${global:GetConsoleWindow} = $dk::CS_GetConsoleWindow();
	if($args[0]) {
		dk_call dk_set $args[0] ${GetConsoleWindow};
	} else {
		#return ${GetConsoleWindow};
	}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call GetConsoleWindow;
	dk_call dk_debug "GetConsoleWindow = ${GetConsoleWindow}";
}