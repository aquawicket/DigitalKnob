if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_debugFunc){ $dk_debugFunc = 1 } else{ return }

if (!$ENABLE_dk_debugFunc)	{ $ENABLE_dk_debugFunc = 1 }
if (!$MAX_STACK_LINES)		{ $MAX_STACK_LINES = 200 }
#if (!$DKSTACK[0].FILE)	    { $DKSTACK[0].FILE = %0 }
#if (!$DKSTACK[0].FUNCTION) { $DKSTACK[0].FUNCTION = main }
#if (!$DKSTACK[0].ARGS)	    { $DKSTACK[0].ARGS = 0 }
if (!$DKSTACK_length)		{ $DKSTACK_length = 1 }
if (!$DKSTACK_marker)		{ $DKSTACK_marker = 1 }
################################################################################
# dk_debugFunc()
#
#
function Global:dk_debugFunc() {

	$lvl = 1
	
	$FILENAME  = [string]($(Get-PSCallStack)[$lvl+1].Location).Split(':')[0]
	#Write-Output "FILENAME = $FILENAME"
	
	$LINENO   = [string]$(Get-PSCallStack)[$lvl+1].ScriptLineNumber
	#Write-Output "LINENO = $LINENO"
	
	$FUNCTION = [string]($(Get-PSCallStack)[$lvl].FunctionName).Split(':')[1]
	#Write-Output "FUNCTION = $FUNCTION"
	
	$ParameterList = (Get-Command -Name $FUNCTION).Parameters;
	#Write-Output "ParameterList = $ParameterList"
	
	foreach ($key in $ParameterList.keys){
		$_varName_ = (get-variable $key).Value
		$_args_+=$_varName_
		#$_value_ = (Get-Item variable:$_varName_).Value
		#$args+="$_varName_`:`"$_value_`""
	}
	#$_args_ = $PsBoundParameters.Values + $args
	$fileLine = "$FILENAME`:$LINENO"
	$funcArgs = "$FUNCTION($_args_)"
	
	#Write-Host -Fore DarkCyan "$FILENAME`:$LINENO --> $FUNCTION($_args_)";
	#Write-Host -Fore DarkCyan -NoNewline "$FILENAME"; Write-Host -Fore Cyan -NoNewline "`:$LINENO"; Write-Host -Fore Blue "          $FUNCTION($_args_)";
	Write-Host -Fore cyan -NoNewline "$FILENAME`:$LINENO".PadLeft(20); Write-Host -Fore blue "   $FUNCTION($_args_)";
	
	#"{0} {1}" -f ($fileLine).PadLeft(20),$funcArgs
	
	#Write-Host -Fore DarkCyan -NoNewline $fileLine.PadLeft(20);, Write-Host -Fore Blue $funcArgs;
	
	


}