<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_installGit()
#
#
dk_installGit() {
	dk_debugFunc 0
	dk_call dk_echo "dk_installGit()"
	
	if ! dk_call dk_commandExists git; then
		dk_call dk_echo "dk_installPackage()"
		dk_call dk_installPackage git
	fi
	
	GIT_EXE=$(command -v git)
	[ -e "${GIT_EXE}" ] || dk_call dk_error "GIT_EXE is invalid"
	
<<<<<<< HEAD
=======
#	dk_call dk_firewallAllow "Git" "C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\mingw64\libexec\git-core\git-remote-https.exe"
	
>>>>>>> Development
	dk_call dk_printVar GIT_EXE
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installGit
}
