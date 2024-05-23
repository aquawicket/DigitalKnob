if (!($DKINIT)){ . $PWD\DK.ps1 }

if ($ENABLE_dk_debugFunc -eq $null)	{ $ENABLE_dk_debugFunc = 1 }
if ($MAX_STACK_LINES -eq $null)		{ $MAX_STACK_LINES = 200 }
#if ($DKSTACK[0].FILE -eq $null)	{ $DKSTACK[0].FILE = %0 }
#if ($DKSTACK[0].FUNCTION -eq $null){ $DKSTACK[0].FUNCTION = main }
#if ($DKSTACK[0].ARGS -eq $null)	{ $DKSTACK[0].ARGS = 0 }
if ($DKSTACK_length -eq $null)		{ $DKSTACK_length = 1 }
if ($DKSTACK_marker -eq $null)		{ $DKSTACK_marker = 1 }
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
		$_value_ = (Get-Item variable:$_varName_).Value
		$args+="$_varName_"
		#$args+="$_varName_`:`"$_value_`""
	}
	
	Write-Output "$FILENAME`:$LINENO --> $FUNCTION($args)"
}