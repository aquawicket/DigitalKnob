#!/bin/sh
echo "########## dk_test.sh ##########"
echo "                    0 = $0"
echo "                    * = $*"
echo " DKBASH_FUNCTIONS_DIR = ${DKBASH_FUNCTIONS_DIR}"
echo "DKBASH_FUNCTIONS_DIR_ = ${DKBASH_FUNCTIONS_DIR_}"
echo "        DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
echo "         DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
echo "        DKSCRIPT_NAME = ${DKSCRIPT_NAME}"
echo "         DKSCRIPT_EXT = ${DKSCRIPT_EXT}"
echo "        DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}"

[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_test(<arg1> <ret_val>)
#
#
dk_test() {
    dk_debugFunc 0 99
    
	dk_call dk_validate DKHOME_DIR "dk_call dk_DKHOME_DIR"
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
    dk_call dk_echo "################ dk_test.sh ################"
    dk_call dk_echo "                    0 = $0"
    dk_call dk_echo "                    * = $*"
    dk_call dk_echo "             __TIME__ = $(__TIME__)"
    dk_call dk_echo "           __CALLER__ = $(__CALLER__)"
    dk_call dk_echo "             __FILE__ = $(__FILE__)"
    dk_call dk_echo "             __LINE__ = $(__LINE__)"
    dk_call dk_echo "         __FUNCTION__ = $(__FUNCTION__ 1)"
    dk_call dk_echo "             __ARGC__ = $(__ARGC__ 1)"
    dk_call dk_echo "             __ARGV__ = $(__ARGV__ 1)"
    dk_call dk_echo "        DKSCRIPT_PATH = ${DKSCRIPT_PATH-}"
    dk_call dk_echo "         DKSCRIPT_DIR = ${DKSCRIPT_DIR-}"
    dk_call dk_echo "        DKSCRIPT_NAME = ${DKSCRIPT_NAME-}"
    dk_call dk_echo "         DKSCRIPT_EXT = ${DKSCRIPT_EXT-}"
    dk_call dk_echo "        DKSCRIPT_ARGS = ${DKSCRIPT_ARGS-}"
    dk_call dk_echo "           DKHOME_DIR = ${DKHOME_DIR-}"
    dk_call dk_echo "          DKCACHE_DIR = ${DKCACHE_DIR-}"
    dk_call dk_echo "        DKDESKTOP_DIR = ${DKDESKTOP_DIR-}"
    dk_call dk_echo "          DIGITALKNOB = ${DIGITALKNOB-}"
    dk_call dk_echo "      DIGITALKNOB_DIR = ${DIGITALKNOB_DIR-}"
    dk_call dk_echo "       DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR-}"
    dk_call dk_echo "          DKTOOLS_DIR = ${DKTOOLS_DIR-}"
    dk_call dk_echo "             DKBRANCH = ${DKBRANCH-}"
    dk_call dk_echo "         DKBRANCH_DIR = ${DKBRANCH_DIR-}"
    dk_call dk_echo "       DK3RDPARTY_DIR = ${DK3RDPARTY_DIR-}"
    dk_call dk_echo "           DKAPPS_DIR = ${DKAPPS_DIR-}"
    dk_call dk_echo "           DKBASH_DIR = ${DKBASH_DIR-}"
    dk_call dk_echo " DKBASH_FUNCTIONS_DIR = ${DKBASH_FUNCTIONS_DIR-}"
    dk_call dk_echo "DKBASH_FUNCTIONS_DIR_ = ${DKBASH_FUNCTIONS_DIR_-}"
    
    return_value="return value from dk_test.sh"
    
    #dk_return "${return_value}"
    #eval "rtn_var=${return_value}"
    builtin echo "${return_value}"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
    dk_debugFunc 0

    rtn_var="$(dk_call dk_test "arg 1" "arg 2")"
    dk_call dk_echo
    dk_call dk_echo "rtn_var = ${rtn_var}"	


    return
    ### (input:string output:return_var) ###
    dk_call dk_test "1 input:string" output
    echo "output:return_variable = ${output-}"

    ### (input:string output:$(command sub))
    output=$(dk_call dk_test "2 input:string")
    echo "output:command_sub_variable = ${output}"

    ### (input:string_variable_value output:return_var) ###
    input="3 input:string_variable_value"
    dk_call dk_test "${input}" output
    echo "output:return_variable = ${output}"

    ### (input:string_variable_value output:$(command sub))
    input="4 input:string_variable_value"
    output=$(dk_call dk_test "${input}")
    echo "output:command_sub_variable = ${output}"

    ### (input:string_variable output:return_var) ###
    input="4 input:string_variable"
    dk_call dk_test input output
    echo "output:return_variable = ${output}"

    ### (input:string_variable output:return_var) ###
    input="5 input:string_variable"
    output=$(dk_call dk_test input)
    echo "output:return_variable = ${output}"

    ### (input:array_string_value output:return_var) ###
    arryA=("6" "array" "string" "value")
    arryA_str="${arryA[@]}"
    input="${arryA_str}"
    dk_call dk_test input output
    echo "output:return_variable = ${output}"

    ### (input:array_variable[@] output:return_var) ###
    arryA=("7" "array" "variable" "direct")
    dk_call dk_test arryA[@] output
    echo "output:return_variable = ${output}"

    ### (input:array_variable_value output:return_var) ###
    arryB=("8" "array" "variable" "by" "value")
    input=arryB[@]
    dk_call dk_test ${input} output
    echo "output:return_variable = ${output}"

    #####   FIXME   ########
#   ### (input:array_variable_value output:return_var) ###
#   arryC=("7array" "array" "variable" "by" "name")
#   dk_call dk_test $arryC output
#   echo "output:return_variable = ${output}"
}
