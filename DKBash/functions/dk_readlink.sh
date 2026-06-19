#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_readlink(path "-f" rtn_var)
#
#    read the contents of a symbolic link
#
#	 example: dk_return "$(dk_readlink -f "$path")"; return 
#
#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
#    C:     https://pubs.opengroup.org/onlinepubs/9699919799/functions/readlink.html
#	 OSX:   https://www.unix.com/man-page/osx/1/readlink/
#
dk_readlink() {
	dk_debugFunc 1 3
	
	# we expect to use a -f parameter, so use ${2} as the input path.
	[ "${1}" = "-f" ] && local target_file=${2} || local target_file=${1}  
	cd $(dk_dirname $target_file)
	target_file=$(dk_basename $target_file)

	# Iterate down a (possible) chain of symlinks
	while [ -L "$target_file" ]
	do
		target_file=$(readlink $target_file)
		cd $(dk_dirname $TARGET_FILE)
		target_file=$(dk_basename $target_file)
	done

	# Compute the canonicalized name by finding the physical path 
	# for the directory we're in and appending the target file.
	local phys_dir=$(pwd -P)
	local _readlink_=${phys_dir}/${target_file}
		
	###### return ######
	dk_printVar _readlink_
	[ ! "${1}" = "-f" ] && [ ${#} -gt 1 ] && eval "${2}=${_readlink_}" && return  # return value when using rtn_var parameter 
	[ "${1}" = "-f" ] && [ ${#} -gt 2 ] && eval "${3}=${_readlink_}" && return  # return value when using rtn_var parameter 
	dk_return ${_readlink_}; return						   # return value when using command substitution 
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	readlinkA=$(dk_readlink -f "DK.sh")
	dk_echo "readlinkA = ${readlinkA}"
	
	dk_readlink -f "DK.sh" readlinkB
	dk_echo "readlinkB = ${readlinkB}"
	
	readlinkC=$(dk_readlink "DK.sh")
	dk_echo "readlinkC = ${readlinkC}"
	
	dk_readlink "DK.sh" readlinkD
	dk_echo "readlinkD = ${readlinkD}"
}