@echo off
call DK


::##################################################################################
::# dk_removeFromFile(string <file>)
::#
::#
:dk_removeFromFile () {
	call dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"

	sed -i -e "/$1/d" $2
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_removeFromFile
}