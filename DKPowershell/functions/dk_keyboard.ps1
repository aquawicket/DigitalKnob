if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_keyboard){ $dk_keyboard = 1 } else{ return }

##################################################################################
# dk_keyboard()
#
#
function Global:dk_keyboard() {
	dk_debugFunc 0
	
	Keyboard_Loop
}

function Global:Keyboard_Loop() {
	Write-Host 0;
	while ($key -ne 27) {
		$keyCode = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode;
		Write-Host keyCode = $keyCode
		if(${keyCode} -eq 27){
			dk_exit
		}
		#    if %keyCode% equ 13 echo "Enter"
		#    if %keyCode% equ 27 echo "Esc" 
		#    if %keyCode% equ 35 echo "End" 
		#    if %keyCode% equ 36 echo "Home" 
		#    if %keyCode% equ 37 echo "LeftArrow" 
		#    if %keyCode% equ 39 echo "RightArrow"
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_keyboard
}