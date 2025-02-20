if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_toLower){ $dk_toLower = 1 } else{ return } #include guard

##################################################################################
# dk_toLower(str) -> rtn_val
#
#
function Global:dk_toLower($str) {
	dk_debugFunc 1

	${toLower} = ${str}.ToLower()
	dk_call dk_printVar toLower
	return ${toLower}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	${lowercase} = dk_call dk_toLower "CoNvErT tHiS sTrInG tO aLl LoWeRcAse"
	dk_call dk_echo "lowercase = ${lowercase}"
}
