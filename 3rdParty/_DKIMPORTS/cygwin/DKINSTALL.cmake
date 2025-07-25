#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ cgywin ############
# https://www.cygwin.com
# https://cygwin.com/faq/faq.html#faq.setup.cli

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Windows_Host)
	dk_undepend(cygwin)
	return()
endif()

dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_importVariables("${cygwin_${Host_Tuple}_Import}")
dk_assertVar(CYGWIN)
message("CYGWIN = ${CYGWIN}")
dk_set(CYGWIN_EXE "${CYGWIN}/Cygwin.bat")


if(NOT EXISTS "${CYGWIN}/bin/${CYGWIN_IMPORT_FILE}")
	dk_echo("Installing ${CYGWIN_FOLDER}")
		
	### Download ###
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_download(${CYGWIN_URL} "$ENV{DKDOWNLOAD_DIR}/${CYGWIN_IMPORT_FILE}")
		
	### FirewallAllow ###
	dk_firewallAllow("Cygwin_Setup" "$ENV{DKDOWNLOAD_DIR}/${CYGWIN_IMPORT_FILE}")
		
	### Install Cygwin ###
	# "C:\Users\Administrator\DigitalKnob\download\setup-x86_64.exe" --quiet-mode --root C:\Users\Administrator\DigitalKnob\Development\3rdParty\cygwin-setup-x86_64
	#dk_exec("$ENV{DKDOWNLOAD_DIR}/${CYGWIN_IMPORT_FILE}" --quiet-mode --site https://mirrors.163.com/cygwin/ --root ${CYGWIN})
	dk_exec("$ENV{DKDOWNLOAD_DIR}/${CYGWIN_IMPORT_FILE}" --root ${CYGWIN})
		
	### Install Packages ###
	dk_exec("$ENV{DKDOWNLOAD_DIR}/${CYGWIN_IMPORT_FILE}" -a x86_64 -d -q -P "tar,wget,gcc-core,gcc-g++,binutils,make,cmake,automake,autoconf,git,patch,unzip,flex,bison,gperf,help2man,libtool,gettext,libgmp10,libgmp-devel,libmpfr6,libmpfr-devel,libmpc3,libmpc-devel,libncurses-devel,libintl-devel")
		
	### Copy Setup exe to /bin ###
	dk_copy("$ENV{DKDOWNLOAD_DIR}/${CYGWIN_IMPORT_FILE}" "${CYGWIN}/bin/${CYGWIN_IMPORT_FILE}")   # copy the installer to use as a package manager
endif()	

#if(NOT EXISTS "???")
dk_info("running install_crosstool.cmd")
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_validate(CMD_EXE "dk_CMD_EXE()")
dk_nativePath("${CMD_EXE}" CMD_EXE)
set(INSTALL_CROSSTOOL_CMD "$ENV{DKIMPORTS_DIR}/cygwin/install_crosstool.cmd")
dk_exec(${CMD_EXE} /V:ON /c "${INSTALL_CROSSTOOL_CMD}")
	
#execute_process(COMMAND ${CYGWIN_EXE} & crosstool-ng-build.sh)
#endif	
		
# Install Packages
# setup-x86.exe -q -P <packagename>
