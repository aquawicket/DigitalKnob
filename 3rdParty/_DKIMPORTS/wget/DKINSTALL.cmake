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


############ wget ############
# https://www.gnu.org/software/wget
# https://cosmo.zip/pub/cosmos/bin/wget
#
function(DKINSTALL)

	dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
	set(wget "${DKTOOLS_DIR}/wget")
	message("wget = ${wget}")
	
	message("wget_Url = ${wget_Url}")
	dk_download("${wget_Url}" "${wget}/wget")
#	dk_installPackage(wget)

#	### Msys2 ###
#	if(MSYSTEM)
#		dk_findProgram(wget_exe wget "${msys2}/usr/bin")
#	endif()

#	### Tiny Core Linux ###
#	if(TINYCORE)
#		#dk_exec(tce-load -wi wget)
#		dk_findProgram(wget_exe wget)
#	endif()
endfunction()