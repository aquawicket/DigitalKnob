if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#TODO #include guard

##################################################################################
# dk_test()
#
#
function GLOBAL:dk_test() {
	dk_debugFunc 0 99

    $all_args = $PsBoundParameters.Values + ${args}
    
    dk_call dk_echo "####################### dk_test.ps1 #######################"
    dk_call dk_echo "                          0 = $0"
    dk_call dk_echo "                          * = $*"
    dk_call dk_echo "                   __TIME__ = $(__TIME__)"
    dk_call dk_echo "                 __CALLER__ = $(__CALLER__)"
    dk_call dk_echo "                   __FILE__ = $(__FILE__)"
    dk_call dk_echo "                   __LINE__ = $(__LINE__)"
    dk_call dk_echo "               __FUNCTION__ = $(__FUNCTION__ 1)"
    dk_call dk_echo "                   __ARGC__ = $(__ARGC__ 1)"
    dk_call dk_echo "                   __ARGV__ = $(__ARGV__ 1)"
	dk_call dk_echo "                   all_args = $all_args"
	dk_call dk_echo "                       args = $args"
	dk_call dk_echo "                    args[0] = $($args[0])"
	dk_call dk_echo "                    args[1] = $($args[1])"
	dk_call dk_echo "                    args[2] = $($args[2])"
	dk_call dk_echo "                    args[3] = $($args[3])"
	dk_call dk_echo "                    args[4] = $($args[4])"
	dk_call dk_echo "                    args[5] = $($args[5])"
    dk_call dk_echo "              DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
    dk_call dk_echo "               DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
    dk_call dk_echo "              DKSCRIPT_NAME = ${DKSCRIPT_NAME}"
    dk_call dk_echo "               DKSCRIPT_EXT = ${DKSCRIPT_EXT}"
    dk_call dk_echo "              DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}"
    dk_call dk_echo "                 DKHOME_DIR = ${DKHOME_DIR}"
    dk_call dk_echo "                DKCACHE_DIR = ${DKCACHE_DIR}"
    dk_call dk_echo "              DKDESKTOP_DIR = ${DKDESKTOP_DIR}"
    dk_call dk_echo "                DIGITALKNOB = ${DIGITALKNOB}"
    dk_call dk_echo "            DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}"
    dk_call dk_echo "             DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR}"
    dk_call dk_echo "                DKTOOLS_DIR = ${DKTOOLS_DIR}"
    dk_call dk_echo "                   DKBRANCH = ${DKBRANCH}"
    dk_call dk_echo "               DKBRANCH_DIR = ${DKBRANCH_DIR}"
    dk_call dk_echo "             DK3RDPARTY_DIR = ${DK3RDPARTY_DIR}"
    dk_call dk_echo "                 DKAPPS_DIR = ${DKAPPS_DIR}"
    dk_call dk_echo "                 DKBASH_DIR = ${DKPOWERSHELL_DIR}"
    dk_call dk_echo " DKPOWERSHELL_FUNCTIONS_DIR = ${DKPOWERSHELL_FUNCTIONS_DIR}"
    dk_call dk_echo "DKPOWERSHELL_FUNCTIONS_DIR_ = ${DKPOWERSHELL_FUNCTIONS_DIR_}"
    
    $return_value="return value from dk_test.ps1"
    
    return "${return_value}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	$rtn_var = dk_call dk_test "arg 1" "arg 2"
	dk_call dk_echo "rtn_var = ${rtn_var}"
	
	return
}
