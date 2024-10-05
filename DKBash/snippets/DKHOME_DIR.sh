#!/bin/sh

### remove_CR(var, rtn_var)
remove_CR() {
	if [ -n "$2" ]; then 
		eval "$2='${1//$'\r'}'"
	else
		echo "${1//$'\r'}"
	fi
}


clear

[ ! -e "${WSLPATH_EXE}" ]	&& export WSLPATH_EXE=$(command -v "wslpath")
[ ! -e "${WSLPATH_EXE}" ]	&& echo "ERROR: WSLPATH_EXE:${WSLPATH_EXE} not found"
[   -e "${WSLPATH_EXE}" ]	&& echo "WSLPATH_EXE = ${WSLPATH_EXE}"

[ ! -e "${CYGPATH_EXE}" ]	&& export CYGPATH_EXE=$(command -v "cygpath")
[ ! -e "${CYGPATH_EXE}" ]	&& echo "ERROR: CYGPATH_EXE not found @ ${CYGPATH_EXE}"
[   -e "${CYGPATH_EXE}" ]	&& echo "CYGPATH_EXE = ${CYGPATH_EXE}"

[ ! -e "${MNT}" ]			&& export MNT="/mnt/c/Users/Administrator"
[   -n "${MNT}" ]			&& echo "MNT = ${MNT}"
[ ! -e "${MNT}" ]			&& echo "ERROR: MNT not found @ ${MNT}"

[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE=$(command -v cmd.exe)
[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE="/mnt/c/Windows/System32/cmd.exe"
[ ! -e "${CMD_EXE}" ]		&& echo "ERROR: CMD_EXE not found @ ${CMD_EXE}"
[   -e "${CMD_EXE}" ]		&& echo "CMD_EXE = ${CMD_EXE}"

#[ ! -n "${USERPROFILE}" ]	&& export USERPROFILE=$(${WSLPATH_EXE} $(${CMD_EXE} /C "echo %USERPROFILE%" 2>/dev/null | tr -d '\r'))
[ ! -n "${USERPROFILE}" ]	&& export USERPROFILE=$(${CMD_EXE} /C "echo %USERPROFILE%") 

#USERPROFILE=${USERPROFILE//$'\r'}
remove_CR $USERPROFILE USERPROFILE
#USERPROFILE=$(remove_CR $USERPROFILE)
[ ! -n "${USERPROFILE}" ]	&& echo "ERROR: USERPROFILE:${USERPROFILE} undefined"
#[ ! -e "${USERPROFILE}" ]	&& echo "ERROR: USERPROFILE:${USERPROFILE} not found"
[   -n "${USERPROFILE}" ]	&& echo "USERPROFILE = ${USERPROFILE}"


[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=$(${WSLPATH_EXE} ${USERPROFILE})														# from USERPROFILE
#[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=$(${WSLPATH_EXE} $(${CMD_EXE} /C "echo %USERPROFILE%" 2>/dev/null | tr -d '\r'))		# from windows USERPROFILE directly
[ ! -e "${DKHOME_DIR}" ]	&& echo "ERROR: DKHOME_DIR:${DKHOE_DIR} not found"
[   -n "${DKHOME_DIR}" ]	&& echo "DKHOME_DIR = ${DKHOME_DIR}"



