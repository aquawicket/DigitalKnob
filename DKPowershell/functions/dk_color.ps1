if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_color){ $dk_color = 1 } else{ return }

dk_load dk_echo
#####################################################################
## dk_color()
##
## https://evotec.xyz/powershell-how-to-format-powershell-write-host-with-multiple-colors/
## https://duffney.io/usingansiescapesequencespowershell/
##
function Global:dk_color() {

    $global:esc="$([char]27)"

    ###### STYLES ######
    $global:clr = "$esc[0m"
    $global:bold = "$esc[1m"
    $global:underline = "$esc[4m"
    $global:inverse = "$esc[7m"

    #### Foreground Colors ####
    $global:black = "$esc[30m"
    $global:red = "$esc[31m"
    $global:green = "$esc[32m"
    $global:yellow = "$esc[33m"
    $global:blue = "$esc[34m"
    $global:magenta = "$esc[35m"
    $global:cyan = "$esc[36m"
    $global:white = "$esc[37m"
	
	## Background Colors
	$global:bg_black = "$esc[40m"
	$global:bg_red = "$esc[41m"
	$global:bg_green = "$esc[42m"
	$global:bg_yellow = "$esc[43m"
	$global:bg_blue = "$esc[44m"
	$global:bg_magenta = "$esc[45m"
	$global:bg_cyan = "$esc[46m"
	$global:bg_white = "$esc[47m"

	## Foreground Colors (Bright)
	$global:Black = "$esc[90m"
	$global:Red = "$esc[91m"
	$global:Green = "$esc[92m"
	$global:Yellow = "$esc[93m"
	$global:Blue = "$esc[94m"
	$global:Magenta = "$esc[95m"
	$global:Cyan = "$esc[96m"
	$global:White = "$esc[97m"

	## Background Colors (Bright)
	$global:BG_Black = "$esc[100m"
	$global:BG_Red = "$esc[101m"
	$global:BG_Green = "$esc[102m"
	$global:BG_Yellow = "$esc[103m"
	$global:BG_Blue = "$esc[104m"
	$global:BG_Magenta = "$esc[105m"
	$global:BG_Cyan = "$esc[106m"
	$global:BG_White = "$esc[107m"
}

function Global:DKTEST() { ####################################################################
	dk_color
}
