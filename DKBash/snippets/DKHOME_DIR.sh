#!/bin/sh
clear

if [ ! -e "${DKHOME_DIR}" ]; then
	[ ! -e "${DRIVE}" ]			&& export DRIVE="/c"
	[ ! -e "${DRIVE}" ]			&& export DRIVE="/mnt/c"
	[   -e "${DRIVE}" ]			&& echo "DRIVE = ${DRIVE}"

	[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE=$(command -v cmd.exe)
	[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE="${DRIVE}/Windows/System32/cmd.exe"
	[   -e "${CMD_EXE}" ]		&& echo "CMD_EXE = ${CMD_EXE}"

	[ ! -e "${CYGPATH_EXE}" ]	&& export CYGPATH_EXE=$(command -v "cygpath")
	[   -e "${CYGPATH_EXE}" ]	&& echo "CYGPATH_EXE = ${CYGPATH_EXE}"
	[   -e "${CYGPATH_EXE}" ]	&& export USERPROFILE=$(${CYGPATH_EXE} -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))
	
	[ ! -e "${WSLPATH_EXE}" ]	&& export WSLPATH_EXE=$(command -v "wslpath")
	[   -e "${WSLPATH_EXE}" ]	&& echo "WSLPATH_EXE = ${WSLPATH_EXE}"
	[   -e "${WSLPATH_EXE}" ]	&& export USERPROFILE=$(${WSLPATH_EXE} -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))
	
	[   -n "${USERPROFILE}" ]	&& echo "USERPROFILE = ${USERPROFILE}"
	[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=${USERPROFILE}
	[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=${HOME}
	[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=${PWD}
	[   -n "${DKHOME_DIR}" ]	&& echo "DKHOME_DIR = ${DKHOME_DIR}"	
fi
[ ! -e "${DKHOME_DIR}" ] && echo "ERROR: DKHOME_DIR:${DKHOE_DIR} not found" && exit 13


[ ! -e "${DKCACHE_DIR}" ] && export DKCACHE_DIR="${DKHOME_DIR}/.dk"
[ ! -e "${DKCACHE_DIR}" ] && mkdir "${DKCACHE_DIR}"
[ ! -e "${DKCACHE_DIR}" ] && echo "ERROR: DKCACHE_DIR:${DKCACHE_DIR} not found" && exit 13

[ ! -e "${DIGITALKNOB_DIR}" ] && export DIGITALKNOB_DIR="${DKHOME_DIR}/digitalknob"
[ ! -e "${DIGITALKNOB_DIR}" ] && mkdir "${DIGITALKNOB_DIR}"
[ ! -e "${DIGITALKNOB_DIR}" ] && echo "ERROR: DIGITALKNOB_DIR:${DIGITALKNOB_DIR} not found" && exit 13

read -rp ''

