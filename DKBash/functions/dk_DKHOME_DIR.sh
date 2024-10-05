#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

####################################################################
# dk_DKHOME_DIR()
#
#
dk_DKHOME_DIR() {
    dk_debugFunc 0

    #[ -n "${DKHOME_DIR}" ] && return 0
    
	### DKHOME_DIR ###
	[ ! -e "${DRIVE}" ]			&& export DRIVE="/c"
	[ ! -e "${DRIVE}" ]			&& export DRIVE="/mnt/c"
	[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE=$(command -v cmd.exe)
	[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE="${DRIVE}/Windows/System32/cmd.exe"
	[ ! -e "${CYGPATH_EXE}" ]	&& export CYGPATH_EXE=$(command -v "cygpath") || $(true)
	[   -e "${CYGPATH_EXE}" ]	&& export USERPROFILE=$(${CYGPATH_EXE} -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))
	[ ! -e "${WSLPATH_EXE}" ]	&& export WSLPATH_EXE=$(command -v "wslpath") || $(true)
	[   -e "${WSLPATH_EXE}" ]	&& export USERPROFILE=$(${WSLPATH_EXE} -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))
	[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=${USERPROFILE}
	[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=${HOME}
	[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=${PWD}	
	[ ! -e "${DKHOME_DIR}" ] 	&& dk_call dk_error "dk_DKHOME_DIR(): unable to locate HOME directory"
	
	
	[ -e "${DKHOME_DIR}" ]     || dk_call dk_fatal "DKHOME_DIR not found"
	#dk_call dk_printVar DKHOME_DIR
	
	### DKCACHE_DIR ###
	DKCACHE_DIR="${DKHOME_DIR}/.dk"
	[ -e "${DKCACHE_DIR}" ]    || dk_call dk_makeDirectory "${DKCACHE_DIR}"
	#dk_call dk_printVar DKCACHE_DIR
	
	### DKDESKTOP_DIR ###
	DKDESKTOP_DIR="${DKHOME_DIR}/Desktop"
    [ -e "${DKDESKTOP_DIR}" ]  || dk_call dk_fatal "DKDESKTOP_DIR:${DKDESKTOP_DIR} does not exist"
	#dk_call dk_printVar DKDESKTOP_DIR
	
	### DKTEMP_DIR ###
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_set DKTEMP_DIR "${TMP}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_set DKTEMP_DIR "${TMPDIR}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_set DKTEMP_DIR "${TMP_DIR%}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR" && dk_call dk_set DKTEMP_DIR "${DIGITALKNOB_DIR}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_fatal "unable to set .dk directory"
#	DKTEMP_DIR="${DKTEMP_DIR}/.dk"
#	[ -e "${DKTEMP_DIR}" ] ||  dk_makeDirectory "${DKTEMP_DIR}"

#${DKDEBUG}
	#dk_call dk_printVar DKHOME_DIR
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_DKHOME_DIR
	
    dk_call dk_printVar DKHOME_DIR
	dk_call dk_printVar DKCACHE_DIR
	dk_call dk_printVar DKDESKTOP_DIR
}
