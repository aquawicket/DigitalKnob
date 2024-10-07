#!/bin/sh
export HDK="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions/DK.sh"
export DKF="${HOME}/digitalknob/Development/DKBash/functions"
[ -e "${DKF}" ] 			|| export DKF="${HOME}/.dk/DKBash/functions"
[ -e "${HOME}" ] 			|| echo "ERROR: HOME environment variable is invalid" || exit 1
[ -e "${HOME}/.dk" ] 		|| mkdir "${HOME}/.dk"
[ -e "${HOME}/.dk/DKBash" ] || mkdir "${HOME}/.dk/DKBash"
[ -e "${DKF}" ] 			|| mkdir "${DKF}"

export DK="${DKF}/DK.sh"
[ -e "${DK}" ] || [ -n "$(command -v "wget")" ] && wget -P "${DKF}" "${HDK}"
[ -e "${DK}" ] || [ -n "$(command -v "curl")" ] && curl -Lo "${DK}" "${HDK}"
[ -e "${DK}" ] && chmod 777 "${DK}"
[ -e "${DK}" ] && . "${DK}"
#"${DK}" $0 $*

#####################
dk_call dk_buildMain
