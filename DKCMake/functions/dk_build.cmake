include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_build(path, target) NO_HALT
#
#	TODO
#
#	path 				- path to the library root 	 I.E. ${MyLibrary_Dir} 
#	target (optional)	- The target of the project to build
#
function(dk_build path) #target NO_HALT
	dk_debugFunc(${ARGV})
	
	if(NOT QUEUE_BUILD)
		return()
	endif()
	dk_getOption(NO_HALT ${ARGV})
	
	if(NOT EXISTS ${path})
		dk_error("dk_build(${path}) path does not exist")
	endif()
	
	set(target ${ARGV1})
	
	# If we are in MULTI_CONFIG mode, we need to do a second pass to check for build files in SINGLE_CONFIG mode. Some libraries are
	# still built in SINGLE_CONFIG mode event though the main project isn't 
	#if(MULTI_CONFIG)
	#	list(APPEND BUILD_MODE multi_config)
	#endif()
	#list(APPEND BUILD_MODE single_config)
		
		dk_cd(${path}/${BUILD_DIR})

		# Build with CMake		(multi_config / single_config)
		if(EXISTS ${path}/${BUILD_DIR}/cmake_install.cmake)
			dk_info("Building with CMake")
			if(${ARGC} GREATER 1)
				#dk_fileAppend(${PWD}/DKBUILD.log "${CMAKE_EXE} --build . --config Debug --target ${target} \n\n")
				DEBUG_dk_command(${CMAKE_EXE} --build . --config Debug --target ${target})# ${NO_HALT} OUTPUT_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				#dk_fileAppend(${PWD}/DKBUILD.log "${echo_output}\n\n\n")
				
				RELEASE_dk_command(${CMAKE_EXE} --build . --config Release --target ${target})# ${NO_HALT})
			else()
				#dk_fileAppend(${PWD}/DKBUILD.log "${CMAKE_EXE} --build . --config Debug --target ${target} \n\n")
				DEBUG_dk_command(${CMAKE_EXE} --build . --config Debug)# ${NO_HALT} OUTPUT_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				#dk_fileAppend(${PWD}/DKBUILD.log "${echo_output}\n\n\n")
				
				RELEASE_dk_command(${CMAKE_EXE} --build . --config Release)# ${NO_HALT})
			endif()
			return()
		endif()
		if(MULTI_CONFIG)
			if(DEBUG)
				if(EXISTS ${path}/${OS}/${DEBUG_DIR}/cmake_install.cmake)
					dk_cd(${path}/${OS}/${DEBUG_DIR})
					dk_info("Building with CMake")
					if(${ARGC} GREATER 1)
						DEBUG_dk_command(${CMAKE_EXE} --build . --config Debug --target ${target})# ${NO_HALT})
					else()
						DEBUG_dk_command(${CMAKE_EXE} --build . --config Debug)# ${NO_HALT})
					endif()
					dk_cd(${path}/${BUILD_DIR})
					return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${OS}/${RELEASE_DIR}/cmake_install.cmake)
					dk_cd(${path}/${OS}/${RELEASE_DIR})
					dk_info("Building with CMake")
					if(${ARGC} GREATER 1)
						RELEASE_dk_command(${CMAKE_EXE} --build . --config Release --target ${target})# ${NO_HALT})
					else()
						RELEASE_dk_command(${CMAKE_EXE} --build . --config Release)# ${NO_HALT})
					endif()
					dk_cd(${path}/${BUILD_DIR})
					return()
				endif()
			endif()
		endif()
		
		# Build with MSBuild		(multi_config)
		file(GLOB sln "${path}/${BUILD_DIR}/*.sln")
		if(sln)
			dk_info("Building with MSBuild")
			dk_visualStudio(${ARGV})
			return()
		endif()
		
		# Build with XCode			(multi_config)
		file(GLOB xcodeproj "${path}/${BUILD_DIR}/*.xcodeproj")
		if(xcodeproj)
			dk_info("Building with XCode")
			dk_xcode(${ARGV})
			return()
		endif()
		
		
		# Build with make			(single_config)
		if(EXISTS ${path}/${BUILD_DIR}/Makefile)
			dk_info("Building with make")
			dk_make(${ARGV})
			return()
		endif()
		if(MULTI_CONFIG)
			if(DEBUG)
				if(EXISTS ${path}/${OS}/${DEBUG_DIR}/Makefile)
					dk_cd(${path}/${OS}/${DEBUG_DIR})
					dk_info("Building with make")
					dk_make(${ARGV})
					dk_cd(${path}/${BUILD_DIR})
					return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${OS}/${RELEASE_DIR}/Makefile)
					dk_cd(${path}/${OS}/${RELEASE_DIR})
					dk_info("Building with make")
					dk_make(${ARGV})
					dk_cd(${path}/${BUILD_DIR})
					return()
				endif()
			endif()
		endif()
		
		
		# Build with Android NDK	(single_config)
		if(EXISTS ${path}/${BUILD_DIR}/AndroidManifest.xml)
			dk_info("Building with Android NDK")
			dk_ndk(${ARGV})
			return()
		endif()
		if(MULTI_CONFIG)
			if(DEBUG)
				if(EXISTS ${path}/${OS}/${DEBUG_DIR}/AndroidManifest.xml)
					dk_cd(${path}/${OS}/${DEBUG_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_cd(${path}/${BUILD_DIR})
					return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${OS}/${RELEASE_DIR}/AndroidManifest.xml)
					dk_cd(${path}/${OS}/${RELEASE_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_cd(${path}/${BUILD_DIR})
					return()
				endif()
			endif()
		endif()
		
		
	#endforeach()
	
	dk_error("dk_build(): ${path}/${BUILD_DIR} has no buildable files")
endfunction()
dk_createOsMacros("dk_build")







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()