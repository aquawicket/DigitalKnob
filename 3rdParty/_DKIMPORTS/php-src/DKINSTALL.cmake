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


############ php-src ############
# https://github.com/php/php-src.git
# https://www.php.net
# https://windows.php.net/downloads/releases
# https://www.php.net/downloads.php
# https://windows.php.net/downloads/releases/php-8.4.13-Win32-vs17-x86.zip
# https://windows.php.net/downloads/releases/php-8.4.13-Win32-vs17-x64.zip

if(NOT Windows_Host)
	dk_disable(php-src)
	dk_return()
endif()

### DEPEND ###
dk_depend(vc_redist) #for VCRUNTIME140.dll

### IMPORT ###
dk_import()

### Copy VCRUNTIME library to php-src folder
if(Windows_Host)
	if(NOT EXISTS "${php-src}/vcruntime140.dll")
		if(Windows_X86_Host)
			if(EXISTS "${VCRUNTIME140_X86_DEBUG_DLL}")
				dk_copy("${VCRUNTIME140_X86_DEBUG_DLL}" "${php-src}/vcruntime140.dll") #rename
			elseif(EXISTS "${VCRUNTIME140_X86_DLL}")
				dk_copy("${VCRUNTIME140_X86_DLL}" "${php-src}/vcruntime140.dll")
			endif()
		elseif(Windows_X86_64_Host)
			if(EXISTS "${VCRUNTIME140_X86_64_DEBUG_DLL}")
				dk_copy("${VCRUNTIME140_X86_64_DEBUG_DLL}" "${php-src}/vcruntime140.dll") # rename
			elseif(EXISTS "${VCRUNTIME140_X86_64_DLL}")
				dk_copy("${VCRUNTIME140_X86_64_DLL}" "${php-src}/vcruntime140.dll")
			endif()
		endif()
		dk_assertPath("${php-src}/vcruntime140.dll")
	endif()
endif()
