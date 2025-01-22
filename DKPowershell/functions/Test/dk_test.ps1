if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$Test_dk_test){ $Test_dk_test = 1 } else{ return } #include guard

##################################################################################
# Test:dk_test()
#
#
function GLOBAL:Test:dk_test() {
	#dk_debugFunc 0 99

    $all_args = $PsBoundParameters.Values + ${args}
    
    Write-Host "####################### Test:dk_test.ps1 #######################"
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
    Write-Host "                 DKAPPS_DIR = ${DKAPPS_DIR}"
    Write-Host "                 DKBASH_DIR = ${DKPOWERSHELL_DIR}"
    Write-Host " DKPOWERSHELL_FUNCTIONS_DIR = ${DKPOWERSHELL_FUNCTIONS_DIR}"
    Write-Host "DKPOWERSHELL_FUNCTIONS_DIR_ = ${DKPOWERSHELL_FUNCTIONS_DIR_}"
    
    #dk_call setGlobal GLOBAL_VAR "This is a global variable"
	${global:GLOBAL_VAR}="This is a global variable"
	#dk_call setReturn RETURN_VAR "This is a return variable"
	${global:RETURN_VAR}="This is a return variable"
	
	Write-Host "GLOBAL_VAR = ${GLOBAL_VAR}"
	Write-Host "RETURN_VAR = ${RETURN_VAR}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
    #dk_call dk_debugFunc 0

    dk_call dk_test "from Test/DKTEST()" "to dk_test()"
	Write-Host ""
	Write-Host "GLOBAL_VAR = ${GLOBAL_VAR}"
	Write-Host "RETURN_VAR = ${RETURN_VAR}"
	
	dk_call Test:dk_test "from Test/DKTEST()" "to Test/dk_test()"
	Write-Host ""
	Write-Host "GLOBAL_VAR = ${GLOBAL_VAR}"
	Write-Host "RETURN_VAR = ${RETURN_VAR}"
	
	dk_call Test:Test:dk_test "from Test/DKTEST()" "to Test/Test/dk_test()"
	Write-Host ""
	Write-Host "GLOBAL_VAR = ${GLOBAL_VAR}"
	Write-Host "RETURN_VAR = ${RETURN_VAR}"
}
