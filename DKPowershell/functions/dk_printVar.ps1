if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

####################################################################
# dk_printVar(variable)
#
#
function Global:dk_printVar($var) {
	dk_debugFunc 1
	
	if($var -and (Test-Path variable:$var)){
		$name = (Get-Item variable:$var).Name
		$variable = Get-Variable -Name ($name) -ValueOnly
	}
	else{
		$name = $(Get-PSCallStack)[0].InvocationInfo.Line.Split(' ')[1] -replace "`n|`r"
		if($name[0] -eq "$"){ $variable = $var }
		if(($name[1] -eq "$") -and ($name[1] -eq "$")){ $variable = $var }
	}
	
	if(($variable -is [array]) -or ($variable -is [System.Collections.ArrayList])){ 
		if($variable.count){
			for($i=0; $i -lt $variable.count; $i++) {
				if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
				dk_call dk_echo "${cyan}$name[$i] = ${blue}'$($variable[$i])'${clr}";
			}
		}
		else{
			if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
			dk_call dk_echo "${cyan}$name = ${yellow}EMPTY${clr}"
		}
	} elseif($variable){
		if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
		dk_call dk_echo "${cyan}$name = ${blue}'$variable'${clr}"
	} else{
		if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
		dk_call dk_echo "${cyan}$name = ${red}UNDEFINED${clr}"
	}
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	$string = "a simple variable"
	dk_call dk_printVar string
	dk_call dk_printVar $string
	dk_call dk_printVar "string"
	dk_call dk_printVar "$string"
	
	$spaceString = " "
	dk_call dk_printVar spaceString
	dk_call dk_printVar $spaceString
	dk_call dk_printVar "spaceString"
	dk_call dk_printVar "$spaceString"
	
	$number = 7
	dk_call dk_printVar number
	dk_call dk_printVar $number
	dk_call dk_printVar "number"
	dk_call dk_printVar "$number"
	
	$numbers = 123456
	dk_call dk_printVar numbers
	dk_call dk_printVar $numbers
	dk_call dk_printVar "numbers"
	dk_call dk_printVar "$numbers"
	
	$array = ('a','b','c')
	dk_call dk_printVar array
	dk_call dk_printVar $array
	dk_call dk_printVar "array"
	dk_call dk_printVar "$array"
	
	$singleArray = ('a')
	dk_call dk_printVar singleArray
	dk_call dk_printVar $singleArray
	dk_call dk_printVar "singleArray"
	dk_call dk_printVar "$singleArray"
	
	$emptyArray = @()
	dk_call dk_printVar emptyArray
	dk_call dk_printVar $emptyArray
	dk_call dk_printVar "emptyArray"
	dk_call dk_printVar "$emptyArray"
	
	$arrayList = [System.Collections.ArrayList]('a', 'b', 'c')
	dk_call dk_printVar arrayList
	dk_call dk_printVar $arrayList
	dk_call dk_printVar "arrayList"
	dk_call dk_printVar "$arrayList"
	
	$singleArrayList = [System.Collections.ArrayList]::new()
	$singleArrayList.Add('A')
	dk_call dk_printVar singleArrayList
	dk_call dk_printVar $singleArrayList
	dk_call dk_printVar "singleArrayList"
	dk_call dk_printVar "$singleArrayList"
	
	$emptyArrayList = New-Object -TypeName System.Collections.ArrayList
	dk_call dk_printVar emptyArrayList
	dk_call dk_printVar $emptyArrayList
	dk_call dk_printVar "emptyArrayList"
	dk_call dk_printVar "$emptyArrayList"
	
	dk_call dk_printVar NonExistent
	dk_call dk_printVar $NonExistent
	dk_call dk_printVar "NonExistent"
	dk_call dk_printVar "$NonExistent"
}
