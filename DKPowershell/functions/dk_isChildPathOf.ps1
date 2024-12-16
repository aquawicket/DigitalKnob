if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_isChildPathOf){ $dk_isChildPathOf = 1 } else{ return }

################################################################################
# dk_isChildPathOf(haystack, needle, rtn_var)
#
#   https://en.wikipedia.org/wiki/Dirname
#
function Global:dk_isChildPathOf() {
    dk_debugFunc 0;

	$all_args = $PsBoundParameters.Values + ${args};
	$_haystack_ = "$($args[0])";
	$_haystack_ = $_haystack_ -replace "\\", "/";
	$_haystack_ = $_haystack_ -replace ":", "";
	dk_call dk_printVar _haystack_;
#   if "%_haystack_:~0,1%" equ "\" set "_haystack_=%_haystack_:~1%"		&:: remove first character if it's a '\'

	
	$_needle_ = "$($args[1])";
	$_needle_ = $_needle_ -replace "\\", "/";
	$_needle_ = $_needle_ -replace ":", "";
	dk_call dk_printVar _needle_;
#    if "%_needle_:~0,1%" equ "\" set "_needle_=%_needle_:~1%"
  
	if($_haystack_ -like "*$_needle_*"){
		#if "%~3" neq "" (endlocal & set "%3=true")
		#set "_haystack_="
		#set "_needle_="
		return 1;
	} 
	
	return 0;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
    dk_call dk_echo
    $childPath = "C:/Program Files/Internet Explorer/en-US"
    $parentPath = "C:/Program Files"
    if(dk_call dk_isChildPathOf $childPath $parentPath){
		dk_call dk_echo "the path is a child of the parentPath" 
	} else {
		dk_call dk_echo "the path is NOT a child of the parentPath"
	}
	
	
	
	 dk_call dk_echo
    $childPath = "C:/Program Files/Internet Explorer/en-US"
    $parentPath = "C:/NonExistent"
    if(dk_call dk_isChildPathOf $childPath $parentPath){
		dk_call dk_echo "the path is a child of the parentPath" 
	} else {
		dk_call dk_echo "the path is NOT a child of the parentPath"
	}
}
