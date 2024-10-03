#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR}/DK.sh"

##################################################################################
# dk_test(<arg1> <ret_val>)
#
#
dk_test() {
    dk_debugFunc 0 99

    echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
    echo "DKSCRIPT_DIR  = ${DKSCRIPT_DIR}"
    echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"
    echo "DKSCRIPT_EXT  = ${DKSCRIPT_EXT}"
    echo "__FILE__      = $(__FILE__)"
    echo "__LINE__      = $(__LINE__)"
    echo "__FUNCTION__  = $(__FUNCTION__)"
    echo "__ARGC__      = $(__ARGC__)"
#    echo "__ARGV__      = $(__ARGV__)"
    echo "__CALLER__    = $(__CALLER__)"

    #return "return value from dk_test.ps1"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
    dk_debugFunc 0

    rtn_var=$(dk_call dk_test "arg 1" "arg 2")
    echo "rtn_var = ${rtn_var}"	


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
