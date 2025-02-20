if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_callDKPowershell){ $dk_callDKPowershell = 1 } else{ return } #include guard

##################################################################################
# dk_callDKPowershell(func) args
#
#
function Global:dk_callDKPowershell() {
	dk_debugFunc 2
	
    ### get required variables ###
    
    ### get ALL_BUT_FIRST_ARGS ###
    
    ### get LAST_ARG ###
    
    ### Call DKPowershell function ###
    
    ### process the return value ###

}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0
	
	#dk_callDKPowershell dk_messageBox rtn_var "MessageBox Title" "Testing dk_messageBox"
	#dk_debug "rtn_var = ${rtn_var}"
}
