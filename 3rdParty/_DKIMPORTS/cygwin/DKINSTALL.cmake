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


############ cgywin ############
# https://www.cygwin.com
# https://cygwin.com/faq/faq.html#faq.setup.cli
# https://www.cygwin.com/setup-x86_64.exe

if(NOT Windows_Host)
	dk_disable(cygwin)
	return()
endif()

dk_importVariables("${cygwin_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})
dk_assertVar(cygwin)
dk_set(cygwin_exe "${cygwin}/Cygwin.bat")


if(NOT EXISTS "${cygwin}/bin/${cygwin_Url_Filename}")
	dk_echo("Installing ${cygwin_Install_Name}")
		
	### Download ###
	dk_download(${cygwin_Url})
		
	### FirewallAllow ###
	dk_firewallAllow("${dk_download}") # cygwin setup-x86_64.exe
		
	### Install Cygwin ###
	# "C:\Users\Administrator\DigitalKnob\download\setup-x86_64.exe" --quiet-mode --root C:\Users\Administrator\DigitalKnob\Development\3rdParty\cygwin-setup-x86_64
	#dk_exec("${DKDOWNLOAD_DIR}/${cygwin_Import_File}" --quiet-mode --site https://mirrors.163.com/cygwin/ --root ${cygwin})
	dk_exec("${dk_download}" --root ${cygwin})
		
	### Install Packages ###
	dk_exec("${dk_download}" -a x86_64 -d -q -P "tar,wget,gcc-core,gcc-g++,binutils,make,cmake,automake,autoconf,git,patch,unzip,flex,bison,gperf,help2man,libtool,gettext,libgmp10,libgmp-devel,libmpfr6,libmpfr-devel,libmpc3,libmpc-devel,libncurses-devel,libintl-devel")
		
	### Copy Setup exe to /bin ###
	dk_copy("${dk_download}" "${cygwin}/bin/${cygwin_Url_Filename}")   # copy the installer to use as a package manager
endif()	

#if(NOT EXISTS "???")
dk_info("running install_crosstool.cmd")
dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_validate(cmd.exe "dk_depend(cmd.exe)")
set(install_crosstool_cmd "${DKIMPORTS_DIR}/cygwin/install_crosstool.cmd")
dk_exec(${cmd.exe} /V:ON /c "${install_crosstool_cmd}")
	
#execute_process(COMMAND ${cygwin_exe} & crosstool-ng-build.sh)
#endif	
		
# Install Packages
# setup-x86.exe -q -P <packagename>
