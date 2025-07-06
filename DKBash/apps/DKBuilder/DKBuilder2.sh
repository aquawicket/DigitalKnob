#!/usr/bin/sh



###### DKHOME_DIR ######
DKHOME_DIR(){
	######   DKHOME_DIR($*)  ######
#	[ ! -e "${DKHOME_DIR-}" ] && (command -v wslpath) && (command -v cmd.exe) && (export DKHOME_DIR=$(wslpath -u $(cmd /c echo "%USERPROFILE%" | tr -d '\r'))) 	# Windows subsystem for linux
#	[ ! -e "${DKHOME_DIR-}" ] && (command -v cygpath) && (command -v cmd.exe) && (export DKHOME_DIR=$(cygpath -u $(cmd "/c echo %USERPROFILE% | tr -d '\r'"))) 	# Git for windows
#	[ ! -e "${DKHOME_DIR-}" ] && [ -e "$(ANDROID_SDCARD)" ] && export DKHOME_DIR=$(ANDROID_SDCARD); 															# Android sdcard
	[ ! -e "${DKHOME_DIR-}" ] && [ -e "${HOME}" ] 		 	&& export DKHOME_DIR="${HOME}";
	[   -e "${DKHOME_DIR-}" ] && echo "${DKHOME_DIR-}"   	|| (echo "DKHOME_DIR-NOTFOUND" & exit -1); 
}


export DK="$(DKHOME_DIR)/DigitalKnob/Development/DKBash/functions/DK.sh"
export HDK="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions/DK.sh"
[ ! -e "${DK}" ] && (command -v curl) && curl -Lo "${DK}" "${HDK}"
[ ! -e "${DK}" ] && (command -v wget) && wget -P "${DK}" "${HDK}"
#[ ! -e "${DK}" ] && [ -e "$(CURL_EXE)" ] && dk_call dk_firewallAllow "CURL" "$(CURL_EXE)" && $(CURL_EXE) -Lo "${DK}" "${HDK}"
[ ! -e "${DK}" ] && echo "DK:${DK} does not exist" && exit 1

$(SUDO_EXE) chmod 777 "${DK}"
. "${DK}" $0 $*
#"${DK}" $0 $*




#####################
dk_call dk_buildMain
