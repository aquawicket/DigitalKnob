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


############ bash ############
# https://www.gnu.org/software/bash/
# https://packages.msys2.org/package/bash

#	HOST		SHELL		BASH	Target_Os
#	Android		termux		bash	Android
#	linux		tinycore	bash	Android, Linux
#	Linux		ubuntu		bash	Android, Linux
#	Mac     	osx			bash	Mac, Ios, Iossim
#	Raspbery	pi			bash	Raspbery
#	Windows 	clang32    	bash	Windows
#	Windows 	clang64 	bash	Windows
#	Windows 	clangarm64 	bash	Windows
#	Windows 	git     	bash	Android, Windows
#	Windows 	mingw32 	bash	Windows
#	Windows 	mingw64 	bash	Windows
#	Windows 	msys2  		bash	Android, Windows
#	Windows 	ucrt64		bash	Windows
#	Windows 	wsl_debian	bash	Linux
#	Windows 	wsl_ubuntu	bash	Linux


set(bash_DEFAULT "GIT") #GIT, MSYS2, WSL
####################################################################
# DKINSTALL()
#
function(DKINSTALL)
	###### SET ######
	if(ARGV)
		dk_set(bash_exe "${ARGV0}")
			
	###### GET ######
	elseif(DEFINED ENV{bash_exe})	
		dk_set(bash_exe "$ENV{bash_exe}")

	else()
		### Already found ###
		if(EXISTS "${bash_exe}")
			dk_debug("bash_exe:${bash_exe} already set")
			return()
		endif()

		### from bash_exe environment variable ###
		if(NOT EXISTS "${bash_exe}")
			dk_set(bash_exe "$ENV{bash_exe}")
		endif()

		### from BASH environment variable ###
		if(NOT EXISTS "${bash_exe}")
			if("$ENV{BASH}" MATCHES "/bash")
				set(bash_exe "$ENV{BASH}")
			endif()
		endif()

		### from SHELL environment variable ###
		if(NOT EXISTS "${bash_exe}")
			if("$ENV{SHELL}" MATCHES "/bash")
				set(bash_exe "$ENV{SHELL}")
			endif()
		endif()

		### From command -v ###
		if(NOT EXISTS "${bash_exe}")
			execute_process(COMMAND command -v bash OUTPUT_VARIABLE bash_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()
		
		### from dk_findProgram in Msys2 ###
		if(NOT EXISTS "${bash_exe}")
			dk_depend(msys2)
			dk_findProgram(MSYS2_bash_exe bash "${msys2}/usr/bin")
			set(bash_exe ${msys2_bash_exe})
		endif()
		
		### from dk_findProgram in git ###
		if(NOT EXISTS "${bash_exe}")
			dk_depend(git)
			dk_findProgram(git_bash_exe bash "${git}/bin")
			set(bash_exe ${git_bash_exe})
		endif()
	endif()
		
	### FINALIZE ###
	#file(TO_CMAKE_PATH "${bash_exe}" bash_exe)
	if(NOT EXISTS "${bash_exe}")
		dk_warning("bash_exe:${bash_exe} not found")
	else()
		dk_set(bash_exe "${bash_exe}") # Globalize the variable
	endif()

	dk_debug("bash_exe = ${bash_exe}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	DKINSTALL()
	dk_debug("bash_exe = ${bash_exe}")
endfunction()