if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$@FUNCTION_NAME@){ $@FUNCTION_NAME@ = 1 } else{ return } #include guard


################################################################################
# @FUNCTION_NAME@(@ARGS@)
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:@FUNCTION_NAME@() {
	dk_debugFunc 0 99

	# $all_args = $PsBoundParameters.Values + ${args};
	# arg1 = $($args[0]);
	# arg2 = $($args[1]);
	
	# TODO
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call @FUNCTION_NAME@ @ARGS@
}
