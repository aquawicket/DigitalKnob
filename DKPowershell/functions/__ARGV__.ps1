if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$DK_ARGV){ $DK_ARGV = 1 } else{ return }

##################################################################################
# __ARGV__()
#
function GLOBAL:__ARGV__($_FRAME_=1) {
	
	$_ARGV_ = New-Object System.Collections.Generic.List[System.Object]
	foreach ($key in (Get-Command -Name $(__FUNCTION__ $($_FRAME_+1))).Parameters.keys){
		#$_ARG_ = (get-variable $key).Name
		$_ARGV_.Add((get-variable $key).Value)
	}
	return $_ARGV_
}