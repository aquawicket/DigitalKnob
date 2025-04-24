<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_test){ $dk_test = 1 } else{ return }
=======
. ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1
if(!$dk_test){ $dk_test = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_test()
#
#
function GLOBAL:dk_test() {
<<<<<<< HEAD
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
=======
	#dk_debugFunc 0 99

    $all_args = $PsBoundParameters.Values + ${args}
    
    Write-Host "####################### dk_test.ps1 #######################"
    Write-Host "                          0 = $0"
    Write-Host "                          * = $*"
    Write-Host "                   __TIME__ = $(__TIME__)"
    Write-Host "                 __CALLER__ = $(__CALLER__)"
    Write-Host "                   __FILE__ = $(__FILE__)"
    Write-Host "                   __LINE__ = $(__LINE__)"
    Write-Host "               __FUNCTION__ = $(__FUNCTION__ 1)"
    Write-Host "                   __ARGC__ = $(__ARGC__ 1)"
    Write-Host "                   __ARGV__ = $(__ARGV__ 1)"
	Write-Host "                   all_args = $all_args"
	Write-Host "                       args = $args"
	Write-Host "                    args[0] = $($args[0])"
	Write-Host "                    args[1] = $($args[1])"
	Write-Host "                    args[2] = $($args[2])"
	Write-Host "                    args[3] = $($args[3])"
	Write-Host "                    args[4] = $($args[4])"
	Write-Host "                    args[5] = $($args[5])"
    Write-Host "              DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
    Write-Host "               DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
    Write-Host "              DKSCRIPT_NAME = ${DKSCRIPT_NAME}"
    Write-Host "               DKSCRIPT_EXT = ${DKSCRIPT_EXT}"
    Write-Host "              DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}"
    Write-Host "                 DKHOME_DIR = ${DKHOME_DIR}"
    Write-Host "                DKCACHE_DIR = ${DKCACHE_DIR}"
    Write-Host "              DKDESKTOP_DIR = ${DKDESKTOP_DIR}"
    Write-Host "                DIGITALKNOB = ${DIGITALKNOB}"
    Write-Host "            DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}"
    Write-Host "             DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR}"
    Write-Host "                DKTOOLS_DIR = ${DKTOOLS_DIR}"
    Write-Host "                   DKBRANCH = ${DKBRANCH}"
    Write-Host "               DKBRANCH_DIR = ${DKBRANCH_DIR}"
    Write-Host "             DK3RDPARTY_DIR = ${DK3RDPARTY_DIR}"
    Write-Host "                 DKCPP_APPS_DIR = ${DKCPP_APPS_DIR}"
    Write-Host "                 DKBASH_DIR = ${DKPOWERSHELL_DIR}"
    Write-Host " DKPOWERSHELL_FUNCTIONS_DIR = ${DKPOWERSHELL_FUNCTIONS_DIR}"
    Write-Host "DKPOWERSHELL_FUNCTIONS_DIR_ = ${DKPOWERSHELL_FUNCTIONS_DIR_}"
    
    #dk_call setGlobal GLOBAL_VAR "This is a global variable"
	${global:GLOBAL_VAR}="This is a global variable"
	#dk_call setReturn RETURN_VAR "This is a return variable"
	${global:RETURN_VAR}="This is a return variable"
	
	Write-Host "GLOBAL_VAR = ${GLOBAL_VAR}"
	Write-Host "RETURN_VAR = ${RETURN_VAR}"
>>>>>>> Development
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
<<<<<<< HEAD
	dk_debugFunc 0
	
	$rtn_var = dk_call dk_test "arg 1" "arg 2"
	dk_call dk_echo "rtn_var = ${rtn_var}"
	
	return
=======
    #dk_call dk_debugFunc 0

    dk_call dk_test "from DKTEST()" "to dk_test()"
	Write-Host ""
	Write-Host "GLOBAL_VAR = ${GLOBAL_VAR}"
	Write-Host "RETURN_VAR = ${RETURN_VAR}"
	
	dk_call Test:dk_test "from DKTEST()" "to Test/dk_test()"
	Write-Host ""
	Write-Host "GLOBAL_VAR = ${GLOBAL_VAR}"
	Write-Host "RETURN_VAR = ${RETURN_VAR}"
	
	dk_call Test:Test:dk_test "from DKTEST()" "to Test/Test/dk_test()"
	Write-Host ""
	Write-Host "GLOBAL_VAR = ${GLOBAL_VAR}"
	Write-Host "RETURN_VAR = ${RETURN_VAR}"
>>>>>>> Development
}
