#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################

echo "echo line 1..."
echo "echo line 2..."
echo "echo line 3..."

echo e- "echo e- line 1..."
echo e- "echo e- line 2..."
echo e- "echo e- line 3..."

dk_echo "dk_echo line 1..."
dk_echo "dk_echo line 2..."
dk_echo "dk_echo line 3..."

dk_todo "dk_todo line 1..."
dk_todo "dk_todo line 2..."
dk_todo "dk_todo line 3..."

dk_fixme "dk_fixme line 1..."
dk_fixme "dk_fixme line 2..."
dk_fixme "dk_fixme line 3..."

dk_verbose "dk_verbose line 1..."
dk_verbose "dk_verbose line 2..."
dk_verbose "dk_verbose line 3..."

dk_debug "dk_debug line 1..."
dk_debug "dk_debug line 2..."
dk_debug "dk_debug line 3..."

dk_info "dk_info line 1..."
dk_info "dk_info line 2..."
dk_info "dk_info line 3..."

dk_warning "dk_warning line 1..."
dk_warning "dk_warning line 2..."
dk_warning "dk_warning line 3..."

dk_error "dk_error line 1..."
dk_error "dk_error line 2..."
dk_error "dk_error line 3..."

dk_exit