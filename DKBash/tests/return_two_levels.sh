clear

alias dk_return='ret_val "${ret_val-}"'
ret_val() {
	if [ "${1-}" = "" ]; then
		builtin echo "${2-}"
	else
		eval "${ret_val-}='${2-}'"
		unset ret_val
	fi
	exit
}

pause(){
	read -rp "Press enter to continue..."
}

MyFunc(){
	[ -n ${1} ] && echo "1"
	#[ -n ${1} ] && eval ${1}=ret_val_value && return
	dk_return "dk_return_value"; return

	echo "SHOULD NOT SEE THIS!"
}

MyMain(){
	MyFunc ret_val
	echo "MyFunc rtn_valB       returned  ${rtn_val}"
	pause "28"
	
	rtn_val=$(MyFunc)
	echo "rtn_val=\$(MyFunc)      returned  ${rtn_val}"
	pause "32"

}
MyMain