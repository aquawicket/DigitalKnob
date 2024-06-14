if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_printVar){ $dk_printVar = 1 } else{ return }

dk_load dk_echo
####################################################################
# dk_printVar()
#
#
function Global:dk_printVar($var) {
	dk_debugFunc
	
	
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
				dk_echo "${blue}$name[$i] = '$($variable[$i])'${clr}";
			}
		}
		else{
			dk_echo "${blue}$name = ${yellow}EMPTY${clr}"
		}
	} elseif($variable){
		dk_echo "${blue}$name = '$variable'${clr}"
	} else{
		dk_echo "${blue}$name = ${red}UNDEFINED${clr}"
	}
}


function Global:DKTEST() { ###########################################################################################
	dk_debugFunc
	
	
	$string = "a simple variable"
	dk_printVar string
	dk_printVar $string
	dk_printVar "string"
	dk_printVar "$string"
	
	$spaceString = " "
	dk_printVar spaceString
	dk_printVar $spaceString
	dk_printVar "spaceString"
	dk_printVar "$spaceString"
	
	$number = 7
	dk_printVar number
	dk_printVar $number
	dk_printVar "number"
	dk_printVar "$number"
	
	$numbers = 123456
	dk_printVar numbers
	dk_printVar $numbers
	dk_printVar "numbers"
	dk_printVar "$numbers"
	
	$array = ('a','b','c')
	dk_printVar array
	dk_printVar $array
	dk_printVar "array"
	dk_printVar "$array"
	
	$singleArray = ('a')
	dk_printVar singleArray
	dk_printVar $singleArray
	dk_printVar "singleArray"
	dk_printVar "$singleArray"
	
	$emptyArray = @()
	dk_printVar emptyArray
	dk_printVar $emptyArray
	dk_printVar "emptyArray"
	dk_printVar "$emptyArray"
	
	$arrayList = [System.Collections.ArrayList]('a', 'b', 'c')
	dk_printVar arrayList
	dk_printVar $arrayList
	dk_printVar "arrayList"
	dk_printVar "$arrayList"
	
	$singleArrayList = [System.Collections.ArrayList]::new()
	$singleArrayList.Add('A')
	dk_printVar singleArrayList
	dk_printVar $singleArrayList
	dk_printVar "singleArrayList"
	dk_printVar "$singleArrayList"
	
	$emptyArrayList = New-Object -TypeName System.Collections.ArrayList
	dk_printVar emptyArrayList
	dk_printVar $emptyArrayList
	dk_printVar "emptyArrayList"
	dk_printVar "$emptyArrayList"
	
	dk_printVar NonExistent
	dk_printVar $NonExistent
	dk_printVar "NonExistent"
	dk_printVar "$NonExistent"
}
