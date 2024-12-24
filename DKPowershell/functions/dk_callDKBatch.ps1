if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

##################################################################################
# dk_callDKBatch(func) args
#
#
function Global:dk_callDKBatch() {
	dk_debugFunc 2 99
	
    ### get required variables ###
    #dk_validate CMD_EXE "??"
    #dk_validate DKBATCH_FUNCTIONS_DIR "dk_DKBRANCH_DIR()"
    
    
    ### get ALL_BUT_FIRST_ARGS ###
    ### get LAST_ARG ###
    
    
    ### Call DKPowershell function ###
	#cmd /c call "dk_messageBox.cmd" rtn_var ${ARGN} 
	
   
    ### process the return value ###
    #dk_debug "output_variable = ${output_variable}"
	#$2="${output_variable}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_callDKBatch dk_debug "Testing dk_messageBox"
	#dk_debug "rtn_var = ${rtn_var}"
}
