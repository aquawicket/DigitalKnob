if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_color){ $dk_color = 1 } else{ return }

dk_load dk_echo
#####################################################################
## dk_color()
##
## https://evotec.xyz/powershell-how-to-format-powershell-write-host-with-multiple-colors/
## https://duffney.io/usingansiESCapesequencespowershell/
##
function Global:dk_color() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$global:ESC="$([char]27)"

    ###### STYLES ######
    $global:clr = "${ESC}[0m"
    $global:bold = "${ESC}[1m"
    $global:underline = "${ESC}[4m"
    $global:inverse = "${ESC}[7m"

    #### Foreground Colors ####
    $global:black = "${ESC}[30m"
    $global:red = "${ESC}[31m"
    $global:green = "${ESC}[32m"
    $global:yellow = "${ESC}[33m"
    $global:blue = "${ESC}[34m"
    $global:magenta = "${ESC}[35m"
    $global:cyan = "${ESC}[36m"
    $global:white = "${ESC}[37m"
	
	## Background Colors
	$global:bg_black = "${ESC}[40m"
	$global:bg_red = "${ESC}[41m"
	$global:bg_green = "${ESC}[42m"
	$global:bg_yellow = "${ESC}[43m"
	$global:bg_blue = "${ESC}[44m"
	$global:bg_magenta = "${ESC}[45m"
	$global:bg_cyan = "${ESC}[46m"
	$global:bg_white = "${ESC}[47m"

	## Foreground Colors (Bright)
	$global:Black = "${ESC}[90m"
	$global:Red = "${ESC}[91m"
	$global:Green = "${ESC}[92m"
	$global:Yellow = "${ESC}[93m"
	$global:Blue = "${ESC}[94m"
	$global:Magenta = "${ESC}[95m"
	$global:Cyan = "${ESC}[96m"
	$global:White = "${ESC}[97m"

	## Background Colors (Bright)
	$global:BG_Black = "${ESC}[100m"
	$global:BG_Red = "${ESC}[101m"
	$global:BG_Green = "${ESC}[102m"
	$global:BG_Yellow = "${ESC}[103m"
	$global:BG_Blue = "${ESC}[104m"
	$global:BG_Magenta = "${ESC}[105m"
	$global:BG_Cyan = "${ESC}[106m"
	$global:BG_White = "${ESC}[107m"
}

function Global:DKTEST() { ####################################################################
	dk_debugFunc
	
	
	dk_color
}
