if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_screenOff_ps1){ $dk_screenOff_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_screenOff()
#
#
function Global:dk_screenOff() {
	dk_debugFunc 0;
	
	# https://www.autohotkey.com/docs/v1/lib/PostMessage.htm
	# https://www.autohotkey.com/docs/v1/misc/SendMessageList.htm

	
	# ::PostMessage(0xffff, 0x0112, 0xF170, 2)  - Turn Off Screen
	# ::PostMessage(0xffff, 0x0112, 0xF170, -1) - Turn On Screen
	# ::PostMessage(0xffff, 0x0112, 0xF170, -1) - Put screen in low power mode
	# ::PostMessage(0xffff, 0x0112, 0xF140, 0) 	- Start screen saver
	
	
	# 0xffff = no handle
	# 0x0112 = WM_SYSCOMMAND
	# 0xF170 = SC_MONITORPOWER
	# 2  	 = Turn Off Screen
	dk_call dk_PostMessage 0xffff 0x0112 0xF170 2
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_screenOff
}
