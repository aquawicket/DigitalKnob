#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ xquartz ############
# https://www.xquartz.org/
# https://www.xquartz.org/releases/index.html
# https://github.com/XQuartz/XQuartz/releases/download/XQuartz-2.8.1/XQuartz-2.8.1.dmg
#
function(DKINSTALL)
	if(NOT Mac)
		dk_disable(xquartz)
		dk_return()
	endif()

	dk_depend(homebrew)

	### INSTALL ###
	#if(NOT EXISTS ${XQUARTZ})
		#dk_exec(brew install --cask xquartz)
		dk_installPackage(xquartz)
		dk_include(/opt/X11/include)
	#endif()

	# Other install methods
	# dk_validate(sudo_exe "dk_depend(sudo_exe)")
	# ${sudo_exe} port -v install xorg-server
	# or
	# dk_validate(sudo_exe "dk_depend(sudo_exe)")
	# ${sudo_exe} port -v install xorg
	# or
	# brew install --cask xquartz

	# Build fill library method
	#dk_set(XQUARTZ_VERSION 2.8.1)
	#dk_set(XQUARTZ_NAME XQuartz-${XQUARTZ_VERSION})
	#dk_set(XQUARTZ_DL https://github.com/XQuartz/XQuartz/releases/download/${XQUARTZ_NAME}/${XQUARTZ_NAME}.dmg)
	#dk_set(XQUARTZ FIXME)

	### INSTALL ###
	#if(NOT EXISTS ${XQUARTZ})
	#	dk_download(${XQUARTZ_DL} ${DKDOWNLOAD_DIR}/${XQUARTZ_NAME}.dmg)
	#	Mac_dk_exec(${DKDOWNLOAD_DIR}/${XQUARTZ_NAME}.dmg)
	#ENDIF()
endfunction()

