if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_keyboard){ $dk_keyboard = 1 } else{ return }

##################################################################################
# dk_keyboard()
#
#
function Global:dk_keyboard() {
	dk_debugFunc
	if($(__ARGC__) -lt 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
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








function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_keyboard
}