if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$__ARGV__){ $__ARGV__ = 1 } else{ return }

dk_load dk_info
##################################################################################
# __ARGV__()
#
#
function GLOBAL:__ARGV__() {
	#dk_debugFunc
	
	$global:__FUNCTION__ = [string]($(Get-PSCallStack)[1].FunctionName).Split(':')[1]
	$global:__ARGS__ = (Get-Command -Name $__FUNCTION__).Parameters;

	$global:ARGV = New-Object System.Collections.Generic.List[System.Object]
	foreach ($key in $__ARGS__.keys){
		$__ARG__ = (get-variable $key).Name
		if(!$__ARGV__){ $__ARGV__ = "$__ARG__" }
		else{ $__ARGV__ = "$__ARGV__`; $__ARG__" }
		$ARGV.Add((get-variable $key).Value)
	}
	return $ARGV
}

