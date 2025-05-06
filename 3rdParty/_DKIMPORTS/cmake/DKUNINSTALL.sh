#!/usr/bin/env sh
##################################################################################
[ -z "${DK_SH-}" ] && . ../../../DKBash/functions/DK.sh
##################################################################################


####################################################################
# DKUNINSTALL()
#
DKUNINSTALL() {
	dk_debugFunc 0
	
	########## kill cmake.exe process #########
	#dk_call dk_killProcess cmake.exe

	########## kill cmake-gui.exe process #########
	#dk_call dk_killProcess cmake-gui.exe
	
	dk_source dk_dirname
	_dk_dirname=$(dk_call dk_dirname ${0})
	dk_call dk_printVar _dk_dirname
	
	dk_call dk_getFileParams 		"${_dk_dirname}/dkconfig.txt"
	dk_call dk_validate host_triple "dk_call dk_host_triple"
	[ "${host_triple}" = "linux_arm64" ] 	&& CMAKE_IMPORT=${CMAKE_LINUX_AARCH64_IMPORT}
	[ "${host_triple}" = "linux_x86_64" ] 	&& CMAKE_IMPORT=${CMAKE_LINUX_X86_64_IMPORT}
	[ "${host_triple}" = "mac_x86_64" ] 	&& CMAKE_IMPORT=${CMAKE_MAC_UNIVERSAL_IMPORT}
	[ "${host_triple}" = "win_arm64" ] 		&& CMAKE_IMPORT=${CMAKE_WIN_ARM64_IMPORT}
	[ "${host_triple}" = "win_x86_64" ] 	&& CMAKE_IMPORT=${CMAKE_WIN_X86_64_IMPORT}
	[ "${host_triple}" = "win_x86" ] 		&& CMAKE_IMPORT=${CMAKE_WIN_X86_IMPORT}
	dk_call dk_assertVar CMAKE_IMPORT
	
	CMAKE_CURRENT_LIST_DIR="${_dk_dirname}"
	
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	dk_call dk_importVariables ${CMAKE_IMPORT} NAME cmake ROOT ${DKTOOLS_DIR}
	
	dk_call dk_assertVar CMAKE
	dk_call dk_delete 	"${CMAKE}"	
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call DKUNINSTALL
}