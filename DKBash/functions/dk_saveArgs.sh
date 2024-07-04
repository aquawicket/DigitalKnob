#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_saveArgs(<args..>)
#
# reference: https://www.etalabs.net/sh_tricks.html
#
# usage:
#   set -- One Two Three Four
#   myarrayA=$(dk_saveArgs "$@")
#   eval "set -- $myarrayA"
#	echo "$1 $2 $3 $4"
#
dk_saveArgs (){
	dk_debugFunc

	for i do 
		printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/"
	done
	echo " "
}


test_func (){

	dk_echo
	dk_echo "test_func \${1} = ${1-}"
	dk_echo "test_func \${2} = ${2-}"
	dk_echo "test_func \${3} = ${3-}"
	dk_echo "test_func \${4} = ${4-}"
	dk_echo "test_func \${*} = ${*-}"
	
	dk_echo
	dk_echo "altering arguments"
	args[0]="a"
	args[1]="b"
	args[2]="c"
	args[3]="d"
	dk_echo "test_func \${args[0]} = ${args[0]-}"
	dk_echo "test_func \${args[1]} = ${args[1]-}"
	dk_echo "test_func \${args[2]} = ${args[2]-}"
	dk_echo "test_func \${args[3]} = ${args[3]-}"
	dk_echo "test_func \${args[*]} = ${args[*]-}"
	
#	dk_echo
#	dk_echo "saving return variable before altering it '_rtn_val_=\${2}'"
#	_rtn_val_=${2-}
#	dk_echo "_rtn_val_ = ${_rtn_val_-}"
	
	dk_echo
	dk_echo "assigning args to function from array   'args=\${!1}; set -- \${args[@]}'"
	args=${!1-}
	set -- ${args[@]-}
	dk_echo "test_func \${1} = ${1-}"
	dk_echo "test_func \${2} = ${2-}"
	dk_echo "test_func \${3} = ${3-}"
	dk_echo "test_func \${4} = ${4-}"
	dk_echo "test_func \${*} = ${*-}"

#	dk_echo
#	dk_echo "returning args to calling function  'eval \$2=(\${args[@]})'"
#	eval "$2=(${args[@]})"
	
#	dk_echo
#	dk_echo "returning args with saved rtn variable to calling function  'eval \${_rtn_val_}=(\${args[@]})'"
#	eval "${_rtn_val_-}=(${args[@]})"
	
	dk_echo
	dk_echo "returning args to calling function  'dk_return \${args[@]}'"
	dk_return "${args[@]}"; return
	
}


DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_echo
	dk_echo "clearing positional args 'set --'"
	set --
	dk_echo "\${1} = ${1-}"
	dk_echo "\${2} = ${2-}"
	dk_echo "\${3} = ${3-}"
	dk_echo "\${4} = ${4-}"
	dk_echo "\${*} = ${*-}"
	
	dk_echo
	dk_echo "setting positional args 'set -- One Two Three Four'"
	set -- One Two Three Four
	dk_echo "\${1} = ${1-}"
	dk_echo "\${2} = ${2-}"
	dk_echo "\${3} = ${3-}"
	dk_echo "\${4} = ${4-}"
	dk_echo "\${*} = ${*-}"
	
	dk_echo
	dk_echo "saving positional args to an array 'myArray=(\"\${@}\")'"
	myArray=("${@-}")
	dk_echo "\${myArray[0]} = ${myArray[0]-}"
	dk_echo "\${myArray[1]} = ${myArray[1]-}"
	dk_echo "\${myArray[2]} = ${myArray[2]-}"
	dk_echo "\${myArray[3]} = ${myArray[3]-}"
	dk_echo "\${myArray[*]} = ${myArray[*]-}"

	dk_echo
	dk_echo "clearing positional args 'set --'"
	set --
	dk_echo "\${1} = ${1-}"
	dk_echo "\${2} = ${2-}"
	dk_echo "\${3} = ${3-}"
	dk_echo "\${4} = ${4-}"
	dk_echo "\${*} = ${*-}"
	
	dk_echo
	dk_echo "restoring array to positional arguments 'set -- \${myArray[@]}'"
	set -- ${myArray[@]-}
	dk_echo "\${1} = ${1-}"
	dk_echo "\${2} = ${2-}"
	dk_echo "\${3} = ${3-}"
	dk_echo "\${4} = ${4-}"
	dk_echo "\${*} = ${*-}"
	
	dk_echo
	dk_echo "sending array to another function  'test_func myArray[@] rtn_var'"
	#test_func myArray[@] rtn_var
	rtn_args=($(test_func myArray[@]))
	
	dk_echo "returned from second function with return args"
	dk_echo "\${rtn_args[0]} = ${rtn_args[0]-}"
	dk_echo "\${rtn_args[1]} = ${rtn_args[1]-}"
	dk_echo "\${rtn_args[2]} = ${rtn_args[2]-}"
	dk_echo "\${rtn_args[3]} = ${rtn_args[3]-}"
	dk_echo "\${rtn_args[*]} = ${rtn_args[*]-}"
	

}