#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


###############################################################################
# dk_validate(<variable> <code>)
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid.
#
dk_validate (){
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	#_var_=${1}
	#_code_=${2}
	[ -n "${!1+x}" ] && return 0
	
	#echo "2 = ${2}"
	
	[ -e ${DKBASH_FUNCTIONS_DIR}/${2}.sh ] && dk_load ${2}
	eval "${2}"
	
	[ -n "${!1+x}" ] || dk_error "dk_validate(): ${1} is invalid"
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	myVarA="a valid variable"
	dk_validate myVarA fill_myVarA
	echo "myVarA = ${myVarA}"
		
	dk_validate myVarB fill_myVarB
	echo "myVarB = ${myVarB}"
	
	dk_validate myVarC "myVarC='a string value'"
	echo "myVarC = ${myVarC}"
	
	dk_validate myVarD "echo 'this will not fill myVarD'"
	echo "myVarD = ${myVarD}"
}

fill_myVarA (){
	myVarA="myVarA has a string value"
}

fill_myVarB (){
	myVarB="myVarB has a string value"
}