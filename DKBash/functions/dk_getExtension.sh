<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_getExtension(<path> <output>)
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_getExtension(<path> <rtn_var>:optional)
>>>>>>> Development
#
#
dk_getExtension() {
	dk_debugFunc 1 2

<<<<<<< HEAD
	
	_filename_=$(dk_call dk_basename "${1}")
	eval "_extension_=${_filename_##*.}"
=======
	_filename_=$(dk_call dk_basename "${1}")
	eval "dk_getExtension=${_filename_##*.}"
>>>>>>> Development
	
	ext[0]="tar.gz"
	ext[1]="tar.xz"
	ext[2]="7z.exe"
	for i in "${ext[@]}"; do
<<<<<<< HEAD
		[[ "$1" == *"$i" ]] && _extension_="$i"
	done

	### return value ###
	dk_call dk_printVar _extension_
	[ ${#} -gt 1 ] && eval "${2}=${_extension_}" && return  # return value when using rtn_var parameter 
	dk_return ${_extension_}; return						  # return value when using command substitution 
=======
		[[ "$1" == *"$i" ]] && dk_getExtension="$i"
	done

	### return value ###
	#dk_call dk_printVar dk_getExtension
	
	[ ${#} -gt 1 ] && eval "${2}=${dk_getExtension}" && return		# return value when using rtn_var parameter 
	dk_return ${dk_getExtension}; return							# return value when using command substitution 
>>>>>>> Development
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_set myPath "/test/test2/xfile.exten"
<<<<<<< HEAD
    dk_call dk_getExtension "${myPath}" extension
    dk_call dk_printVar extension
	
	dk_call dk_getExtension "test.zip" extension
    dk_call dk_printVar extension
	
	dk_call dk_getExtension "test.tar.gz" extension
    dk_call dk_printVar extension
	
	dk_call dk_getExtension "test.tar.xz.tar.gz.tar.xz" extension
    dk_call dk_printVar extension
=======
    dk_call dk_getExtension "${myPath}"
    dk_call dk_printVar dk_getExtension
	
	dk_call dk_getExtension "test.zip"
	dk_call dk_printVar dk_getExtension
	
	dk_call dk_getExtension "test.tar.gz"
	dk_call dk_printVar dk_getExtension
	
	dk_call dk_getExtension "test.tar.xz.tar.gz.tar.xz"
	dk_call dk_printVar dk_getExtension
>>>>>>> Development
	
	dk_call dk_getExtension "test.tar.x.gz" extension
    dk_call dk_printVar extension
	
	dk_call dk_getExtension "test.tar.xz" extension
    dk_call dk_printVar extension
	
	dk_call dk_getExtension "test.7z.exe.b" extension
    dk_call dk_printVar extension
	
	dk_call dk_getExtension "test.7z.exe" extension
    dk_call dk_printVar extension
}
