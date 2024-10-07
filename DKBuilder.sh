#!/bin/sh
export HDK="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions/DK.sh"
export DKF="${HOME}/digitalknob/Development/DKBash/functions"
[ -e "${DKF}" ] 			|| export DKF="${HOME}/.dk/DKBash/functions"
[ -e "${HOME}" ] 			|| echo "ERROR: HOME environment variable is invalid" || exit 1
[ -e "${HOME}/.dk" ] 		|| mkdir "${HOME}/.dk"
[ -e "${HOME}/.dk/DKBash" ] || mkdir "${HOME}/.dk/DKBash"
[ -e "${DKF}" ] 			|| mkdir "${DKF}"
[ -e "${DKF}" ] 			|| echo "DKF:${DKF} does not exist" || exit 1

export DK="${DKF}/DK.sh"
[ ! -e "${DK}" ] && $(command -v wget) && wget -P "${DKF}" "${HDK}"
[ ! -e "${DK}" ] && $(command -v curl) && curl -Lo "${DK}" "${HDK}"
[ ! -e "${DK}" ] && echo "DK:${DK} does not exist" && exit 1

chmod 777 "${DK}"
. "${DK}"
#"${DK}" $0 $*

#####################
dk_call dk_buildMain
