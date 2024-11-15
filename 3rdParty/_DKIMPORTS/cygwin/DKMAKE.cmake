#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ cgywin ############
# https://www.cygwin.com
# https://cygwin.com/faq/faq.html#faq.setup.cli

dk_host_triple()
if(NOT WIN_HOST)
	dk_undepend(cygwin)
	continue()
endif()



dk_set(CYGWIN_DL https://www.cygwin.com/setup-x86_64.exe)
dk_importVariables(${CYGWIN_DL})
dk_set(CYGWIN_EXE "${CYGWIN_DIR}/Cygwin.bat")

dk_validate(DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR()")

if(NOT EXISTS ${CYGWIN_EXE})
	dk_echo("Installing ${CYGWIN_FOLDER}")
	dk_download(${CYGWIN_DL} ${DKDOWNLOAD_DIR})
	dk_command("${DKDOWNLOAD_DIR}/${CYGWIN_DL_FILE}" --quiet-mode --root ${CYGWIN_DIR})
	dk_copy("${DKDOWNLOAD_DIR}/${CYGWIN_DL_FILE}" "${CYGWIN_DIR}/bin/${CYGWIN_DL_FILE}")   # copy the installer to use as a package manager
endif()	

# Install Packages
# setup-x86.exe -q -P <packagename>
