if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_SendMessage_ps1){ $dk_SendMessage_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_SendMessage(<hwnd> <message> <wParam> <lParam>)
#
#
function Global:dk_SendMessage($hwnd, $message, $wParam, $lParam) {
	dk_debugFunc 4;
	
	# https://www.autohotkey.com/docs/v1/lib/SendMessage.htm
	# https://www.autohotkey.com/docs/v1/misc/SendMessageList.htm
	# https://superuser.com/a/1792178/600216
	dk_call dk_depend WindowsMessages
	
	(Add-Type "[DllImport(""user32.dll"")] public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);" -Name "Win32SendMessage" -Namespace Win32Functions -PassThru)::SendMessage($hwnd, $message, $wParam, $lParam)
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_validate env:DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_fileVariables "${env:DKIMPORTS_DIR}/WindowsMessages/dkconfig.txt"
	
	dk_call dk_SendMessage ${HWND_BROADCAST} ${WM_SYSCOMMAND} ${SC_MONITORPOWER} 	2	  # Turn Off Screen
	#dk_call dk_SendMessage ${HWND_BROADCAST} ${WM_SYSCOMMAND} ${SC_MONITORPOWER}	-1	# Turn On Screen
	#dk_call dk_SendMessage ${HWND_BROADCAST} ${WM_SYSCOMMAND} ${SC_MONITORPOWER} 	-1	# Put screen in low power mode
	#dk_call dk_SendMessage ${HWND_BROADCAST} ${WM_SYSCOMMAND} ${SC_SCREENSAVE}  	 0 	# Start screen saver
	

}
