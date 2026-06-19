#/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DK.cmake)
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


############ bsdtar_exe ############
# https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_linux_arm64
# https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_linux_amd64
# https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_darwin_arm64
# https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_darwin_amd64
# https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_windows_x86_64.exe
# https://github.com/aspect-build/bsdtar-prebuilt/releases/download/v3.8.1-fix.1/tar_windows_arm64.exe

function(DKINSTALL)
    dk_debugFunc()

    dk_import()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	DKINSTALL()
endfunction()

