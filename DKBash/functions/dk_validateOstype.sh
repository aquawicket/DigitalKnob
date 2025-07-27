#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_validateOstype()
#
#
#dk_validateOstype() {
#	dk_debugFunc 0
#	
#	if [ -e /proc/device-tree/model ]; then
#		MODEL=$(tr -d '\0' </proc/device-tree/model)
#	fi
#
#	if [ "$OSTYPE" = "linux-gnu"* ]; then
#		DIGITALKNOB_DIR="/home/$USER/DigitalKnob"
#	elif [ "$OSTYPE" = "darwin"* ]; then
#		DIGITALKNOB_DIR="/Users/$USER/DigitalKnob"
#	elif [ "$OSTYPE" = "cygwin" ]; then
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/DigitalKnob"
#	elif [ "$OSTYPE" = "msys" ]; then
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/DigitalKnob"
#	elif [ "$OSTYPE" = "win32" ]; then #I'm not sure this can happen
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/DigitalKnob" 
#	elif [ "$OSTYPE" = "freebsd"* ]; then
#		dk_call dk_error "TODO: freebsd builder incomplete"
#	elif [ "$OSTYPE" = "linux-android" ]; then
#		DIGITALKNOB_DIR="/data/data/com.termux/files/home/DigitalKnob"
#	else
#		dk_call dk_error "UNKNOWN OS ($OSTYPE)"
#	fi
#}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validateOstype
}
