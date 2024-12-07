if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_screenOff){ $dk_screenOff = 1 } else{ return }


################################################################################
# dk_screenOff()
#
#
function Global:dk_screenOff() {
	dk_debugFunc 0
	
	# https://superuser.com/a/1792178/600216
	(Add-Type "[DllImport(""user32.dll"")] public static extern int PostMessage(int hWnd, int hMsg, int wParam, int lParam);" -Name "Win32PostMessage" -Namespace Win32Functions -PassThru)::PostMessage(0xffff, 0x0112, 0xF170, 2)
	
	# https://www.autohotkey.com/docs/v1/lib/PostMessage.htm
	# https://www.autohotkey.com/docs/v1/misc/SendMessageList.htm
	# other PostMessage codes
	
	### PostMessage parameter 1
	# 0xffff = no handle
	
	### PostMessage parameter 2
	# 0x0112 = WM_SYSCOMMAND
	# 0x0050 = WM_INPUTLANGCHANGEREQUEST
	
	### PostMessage parameter 3
	# 0xF170 = SC_MONITORPOWER
	# 0xF140 = SC_SCREENSAVE
	
	
	# ::PostMessage(0xffff, 0x0112, 0xF170, 2)  - Turn Off Screen
	# ::PostMessage(0xffff, 0x0112, 0xF170, -1) - Turn On Screen
	# ::PostMessage(0xffff, 0x0112, 0xF170, -1) - Put screen in low power mode
	# ::PostMessage(0xffff, 0x0112, 0xF140, 0) - Start screen saver
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_screenOff
}
