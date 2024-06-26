#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __ARGVarray__(frame, rtn_var)
#
__ARGVarray__ (){
	[ -z ${1-} ] && local frame=0 || local frame=$1
	
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
	dk_return "${argv_string}"
	
	#eval "$2=(${argv[@]})"
}



test_function(){
	#__ARGVarray__ 1 arry
	ARGV=($(__ARGVarray__ 1))
	
	for ((i=0; i < ${#ARGV[@]}; i++ )); do 
		echo "ARGV[$i] = ${ARGV[$i]}";
	done
	
	ARGV_STR=${ARGV[@]}
	echo "ARGV_STR = ${ARGV_STR}"
}

DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	test_function abc 123
}