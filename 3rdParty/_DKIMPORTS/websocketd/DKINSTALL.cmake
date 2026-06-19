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


############ websocketd ############
# https://github.com/joewalnes/websocketd.git
# websocketd_Mac_X86_64_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-darwin_amd64.zip
# websocketd_Freebsd_X86_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-freebsd_386.zip
# websocketd_Freebsd_X86_64_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-freebsd_amd64.zip
# websocketd_Linux_X86_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-linux_386.zip
# websocketd_Linux_X86_64_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-linux_amd64.zip
# websocketd_Linux_Arm32_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-linux_arm.zip
# websocketd_Linux_Arm64_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-linux_arm64.zip
# websocketd_Openbsd_X86_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-openbsd_386.zip
# websocketd_Openbsd_X86_64_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-openbsd_amd64.zip
# websocketd_Solaris_X86_64_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-solaris_amd64.zip
# websocketd_Windows_X86_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-windows_386.zip
# websocketd_Windows_X86_64_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-windows_amd64.zip
# websocketd_Amd64_Deb_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1_amd64.deb
# websocketd_X86_Deb_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1_i386.deb
# websocketd_X86_Rpm_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd.0.4.1.i386.rpm
# websocketd_X86_64_Rpm_Import=https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd.0.4.1.x86_64.rpm
# websocketd_Src_Zip_Import=https://github.com/joewalnes/websocketd/archive/refs/tags/v0.4.1.zip
# websocketd_Src_TarGz_Import=https://github.com/joewalnes/websocketd/archive/refs/tags/v0.4.1.tar.gz 
# websocketd_Src_Import=https://github.com/joewalnes/websocketd/archive/8d6da300.zip
#
function(DKINSTALL)
	dk_debugFunc(0)

	dk_import()

	dk_set(websocketd_exe "${websocketd}/websocketd.exe")
	
	dk_debug("websocketd_exe = ${websocketd_exe}")
endfunction()