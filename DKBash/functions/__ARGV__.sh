#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# __ARGV__(<frame>)
#
__ARGV__() {
	#dk_debugFunc
	[ -z ${1-} ] && local frame=0 || local frame=${1}
	
	local marker=0
	for (( i=0; i<frame; i++ )); do
		marker=$(($marker + ${BASH_ARGC[${i}]-}))
	done

	local argv=()	
	local argc=${BASH_ARGC[${frame}]-}
	local begin=$(($marker+$argc-1))
	for (( i=$begin; i>((begin-argc)); i-- )); do
		argv+=(${BASH_ARGV[${i}]-})
	done
	
	local argv_string=${argv[@]}
	dk_return "${argv_string}"; return
}





test_function(){
	#dk_debugFunc
	
	echo "ARGV = $(__ARGV__ 1)"					# as a string
	ARGV=($(__ARGV__ 1))						# as an array
	for ((i=0; i < ${#ARGV[@]}; i++ )); do 
		echo "ARGV[$i] = ${ARGV[$i]}";
	done
}

DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	#dk_debugFunc
	
	test_function abc 123
}