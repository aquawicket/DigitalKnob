#!/bin/sh
export HDK="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions/DK.sh"

(command -v sudo) && export SUDO_EXE="sudo" || export SUDO_EXE=" "

###### WSL ######
[ ! -e "${WSLPATH_EXE-}" ]	&& export WSLPATH_EXE=$(command -v "wslpath") || $(true)
if [ -n "${WSLPATH_EXE-}" ]; then	
	${SUDO_EXE} rm /etc/resolv.conf
	${SUDO_EXE} sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
	${SUDO_EXE} sh -c 'echo "[network]" > /etc/wsl.conf'
	${SUDO_EXE} sh -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
	${SUDO_EXE} chattr +i /etc/resolv.conf
fi

###### CMD_EXE ######
[ ! -e "${CMD_EXE-}" ]	&& export CMD_EXE=$(command -v cmd.exe)
[ ! -e "${CMD_EXE}" ]	&& export CMD_EXE="/mnt/c/Windows/System32/cmd.exe"
[ ! -e "${CMD_EXE}" ]	&& unset CMD_EXE
[   -e "${CMD_EXE-}" ]	&& echo "CMD_EXE = ${CMD_EXE}"
	
######  USERPROFILE -> WSLPATH_EXE -> DKHOME_DIR ######
[   -e "${WSLPATH_EXE}" ]	&& export USERPROFILE=$(${WSLPATH_EXE} -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))
[ ! -e "${WSLPATH_EXE}" ]	&& unset WSLPATH_EXE
[   -e "${WSLPATH_EXE-}" ]	&& echo "WSLPATH_EXE = ${WSLPATH_EXE}"
[   -e "${WSLPATH_EXE-}" ]	&& export DKHOME_DIR=$(wslpath -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))
	
######  USERPROFILE -> CYGPATH_EXE -> DKHOME_DIR ######
[ ! -e "${CYGPATH_EXE-}" ]	&& export CYGPATH_EXE=$(command -v "cygpath") || $(true)
[   -e "${CYGPATH_EXE}" ]	&& export USERPROFILE=$(${CYGPATH_EXE} -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))
[ ! -e "${CYGPATH_EXE}" ]	&& unset CYGPATH_EXE
[   -e "${CYGPATH_EXE-}" ]	&& echo "CYGPATH_EXE = ${CYGPATH_EXE}"
[   -e "${CYGPATH_EXE-}" ]	&& export DKHOME_DIR=$(cygpath -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))

### HOME -> DKHOME_DIR ###
[ ! -e "${DKHOME_DIR-}" ] 	&& export DKHOME_DIR="${HOME}"
[ ! -e "${DKHOME_DIR}" ] 	&& echo "ERROR: DKHOME_DIR not found"
echo "DKHOME_DIR = ${DKHOME_DIR}"


export DKF="${DKHOME_DIR}/digitalknob/Development/DKBash/functions"
[ -e "${DKF}" ] 					|| export DKF="${DKHOME_DIR}/.dk/DKBash/functions"
[ -e "${DKHOME_DIR}" ] 				|| echo "ERROR: DKHOME_DIR environment variable is invalid" || exit 1
[ -e "${DKHOME_DIR}/.dk" ] 			|| mkdir "${DKHOME_DIR}/.dk"
[ -e "${DKHOME_DIR}/.dk/DKBash" ] 	|| mkdir "${DKHOME_DIR}/.dk/DKBash"
[ -e "${DKF}" ] 					|| mkdir "${DKF}"
[ -e "${DKF}" ] 					|| echo "DKF:${DKF} does not exist" || exit 1

export DK="${DKF}/DK.sh"
[ ! -e "${DK}" ] && (command -v wget &>/dev/null) && wget -P "${DKF}" "${HDK}"
[ ! -e "${DK}" ] && (command -v curl &>/dev/null) && curl -Lo "${DK}" "${HDK}"
[ ! -e "${DK}" ] && echo "DK:${DK} does not exist" && exit 1

${SUDO_EXE} chmod 777 "${DK}"
. "${DK}"
#"${DK}" $0 $*

#####################
dk_call dk_buildMain
