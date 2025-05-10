#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")

set(CYGWIN 1)
############ cgywin ############
# https://www.cygwin.com
# https://cygwin.com/faq/faq.html#faq.setup.cli
if(CYGWIN)
	dk_validate(Host_Triple "dk_Host_Triple()")
	if(NOT WIN_HOST)
		dk_undepend(cygwin)
		return()
	endif()

	dk_set(CYGWIN_DL https://www.cygwin.com/setup-x86_64.exe)
	dk_importVariables(${CYGWIN_DL})
	dk_set(CYGWIN_EXE "${CYGWIN_DIR}/Cygwin.bat")

	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")

	if(NOT EXISTS "${CYGWIN_DIR}/bin/${CYGWIN_DL_FILE}")
		dk_echo("Installing ${CYGWIN_FOLDER}")
		
		### Download ###
		dk_download(${CYGWIN_DL} $ENV{DKDOWNLOAD_DIR})
		
		### FirewallAllow ###
		dk_firewallAllow("Cygwin_Setup" "$ENV{DKDOWNLOAD_DIR}/setup-x86_64.exe")
		
		### Install Cygwin ###
		dk_command("$ENV{DKDOWNLOAD_DIR}/${CYGWIN_DL_FILE}" --quiet-mode --root ${CYGWIN_DIR})
		
		### Install Packages ###
		dk_command("$ENV{DKDOWNLOAD_DIR}/${CYGWIN_DL_FILE}" -a x86_64 -d -q -P "tar,wget,gcc-core,gcc-g++,binutils,make,cmake,automake,autoconf,git,patch,unzip,flex,bison,gperf,help2man,libtool,gettext,libgmp10,libgmp-devel,libmpfr6,libmpfr-devel,libmpc3,libmpc-devel,libncurses-devel,libintl-devel")
		
		### Copy Setup exe to /bin ###
		dk_copy("$ENV{DKDOWNLOAD_DIR}/${CYGWIN_DL_FILE}" "${CYGWIN_DIR}/bin/${CYGWIN_DL_FILE}")   # copy the installer to use as a package manager
	endif()	

	#if(NOT EXISTS "???")
	dk_info("running install_crosstool.cmd")
	dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
	dk_validate(CMD_EXE "dk_CMD_EXE()")
	dk_nativePath("${CMD_EXE}" CMD_EXE)
	set(INSTALL_CROSSTOOL_CMD "$ENV{DKIMPORTS_DIR}/cygwin/install_crosstool.cmd")
	execute_process(COMMAND ${CMD_EXE} /c "${INSTALL_CROSSTOOL_CMD}")
	
	#execute_process(COMMAND ${CYGWIN_EXE} & crosstool-ng-build.sh)
	#endif	
		
	# Install Packages
	# setup-x86.exe -q -P <packagename>
endif()