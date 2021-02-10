#####################################################################
###################         DKFUNCTIONS()         ###################
#####################################################################

SET(UPX ON)

########################
#FUNCTION(DKLOG text lvl)
#	IF(${lvl} STREQUAL "DKINFO")
#		MESSAGE(STATUS ${text})
#	ELSEIF(${lvl} STREQUAL "DKERROR")
#		MESSAGE(FATAL_ERROR ${text})
#	ENDIF()
#ENDFUNCTION()
	
########################
FUNCTION(DKSET arg arg2)
	SET(extra_args ${ARGN})
	LIST(LENGTH extra_args num_extra_args)
	IF(${num_extra_args} GREATER 0)
		LIST(GET extra_args 0 arg3)
		SET(${arg} ${arg2} ${extra_args} CACHE INTERNAL "")
	ELSE()
		SET(${arg} ${arg2} CACHE INTERNAL "")
	ENDIF()
ENDFUNCTION()

##########################
FUNCTION(DKPATHEXISTS arg)
	##TODO
ENDFUNCTION()

#######################
FUNCTION(DKSETPATH arg)
	DKSET(CURRENT_DIR ${arg})
	IF(NOT EXISTS ${CURRENT_DIR})
		FILE(MAKE_DIRECTORY ${CURRENT_DIR})
	ENDIF()
ENDFUNCTION()

########################
FUNCTION(DKDOWNLOAD arg)
	##https://cmake.org/pipermail/cmake/2012-September/052205.html/
	GET_FILENAME_COMPONENT(filename ${arg} NAME)
	IF(NOT EXISTS ${CURRENT_DIR}/${filename})
		MESSAGE(STATUS "downloading... ${filename}")
		FILE(DOWNLOAD ${arg} ${CURRENT_DIR}/${filename} SHOW_PROGRESS 
		#no TIMEOUT
		STATUS status 
		#no LOG
		)
		
		LIST(GET status 0 status_code) 
		LIST(GET status 1 status_string)
		
		IF(NOT status_code EQUAL 0)
			DKREMOVE(${CURRENT_DIR}/${filename})
			MESSAGE(" ")
			MESSAGE("*********************************************")
			MESSAGE("CMAKE SOMETIMES FAILS TO DOWNLOAD LARGE FILES")
			MESSAGE("PLEASE DOWNLOAD THE FILE TO THE digitalknob/Download direcotry")
			MESSAGE("THE URL IS: ${arg}") 
			MESSAGE("*********************************************")
			MESSAGE(" ")
			## TODO - copy the url to the clipboard and notify the user
			MESSAGE(FATAL_ERROR "error: downloading ${filename} status_code: ${status_code} status_string: ${status_string}")
			
			##Download with DKCurl
			##MESSAGE("Attempting to download with DKCurl...")
			##DKSET(QUEUE_BUILD ON)
			##WIN_COMMAND("${DIGITALKNOB}/DKCMake/DKCurl.exe ${arg} ${CURRENT_DIR}/${filename}")
		ELSE()
			MESSAGE(STATUS "downloading... done")
		ENDIF() 
	ENDIF()
ENDFUNCTION()

############################
FUNCTION(DKEXTRACT arg path)
	##TODO:  extract to a location.
	IF(NOT EXISTS ${path})
		FILE(MAKE_DIRECTORY ${path})
	ENDIF()
	EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E tar xvf ${arg} WORKING_DIRECTORY ${path})
ENDFUNCTION()

###################
FUNCTION(DKZIP arg)
	MESSAGE("Zipping: ${arg}")
	EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E tar "cfv" "${DKPROJECT}/assets.zip" --format=zip "." WORKING_DIRECTORY ${arg}/)
ENDFUNCTION()

###################################
FUNCTION(DKCOPY arg arg2 overwrite)
	##MESSAGE("DKCOPY ${arg} ${arg2} ${overwrite}")
	IF(EXISTS ${arg})
		IF(IS_DIRECTORY ${arg})
			FILE(GLOB_RECURSE allfiles RELATIVE "${arg}/" "${arg}/*")
			FOREACH(each_file ${allfiles})
				SET(sourcefile "${arg}/${each_file}")
				SET(destinationfile "${arg2}/${each_file}")
				IF(overwrite)
					execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
					MESSAGE("COPIED: ${sourcefile} to ${destinationfile}")
				ELSEIF(NOT EXISTS ${destinationfile})
					execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
					MESSAGE("COPIED: ${sourcefile} to ${destinationfile}")
				ENDIF()
			ENDFOREACH()
		ELSE()
			IF(overwrite)
				execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${arg} ${arg2})
				MESSAGE("COPIED: ${arg} to ${arg2}")
			ELSEIF(NOT EXISTS ${arg2})
				EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E copy ${arg} ${arg2})
				MESSAGE("COPIED: ${arg} to ${arg2}")
			ENDIF()
		ENDIF()
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(DKRENAME arg arg2)
	MESSAGE("Renameing ${arg} to ${arg2}")
	IF(EXISTS ${arg})
		IF(EXISTS ${arg2})
			RETURN()
		ENDIF()
		FILE(RENAME ${arg} ${arg2})
	ENDIF()
ENDFUNCTION()

######################
FUNCTION(DKREMOVE arg)
	IF(EXISTS ${arg})
		IF(IS_DIRECTORY ${arg})
			EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove_directory ${arg})
		ELSE()
			EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove ${arg})
		ENDIF()
	ENDIF()
ENDFUNCTION()

######################
FUNCTION(DKENABLE arg)
	DKSET(${arg} ON)
	DKDEFINE(USE_${arg})
ENDFUNCTION()

###########################
FUNCTION(UPX_COMPRESS file)
	IF(WIN32)
	IF(UPX)
		MESSAGE("UPX compressing ${file}...")
		MESSAGE("Please wait...")
		##MESSAGE("${3RDPARTY}/upx392w/upx.exe -9 -v ${file}")
		EXECUTE_PROCESS(COMMAND cmd /c "${3RDPARTY}/upx392w/upx.exe -9 -v ${file}")
	ENDIF()
	ENDIF()
ENDFUNCTION()

######################
FUNCTION(DKDEFINE arg)
	STRING(FIND "${DKDEFINES}" "LOCAL_CPPFLAGS += -D${arg}" _indexa)
	IF(${_indexa} GREATER -1)
		RETURN() ## already exists
	ENDIF()
	STRING(FIND "${DKDEFINES}" "ADD_DEFINITIONS(-D${arg})" _indexa)
	IF(${_indexa} GREATER -1)
		RETURN() ## already exists
	ENDIF()
	
	IF(ANDROID)
		DKSET(DKDEFINES ${DKDEFINES} "LOCAL_CPPFLAGS += -D${arg}\n")
	ELSE()
		DKSET(DKDEFINES "${DKDEFINES}ADD_DEFINITIONS(-D${arg})\n")
		#DKSET(DKDEFINES "${DKDEFINES}ADD_DEFINITIONS(-D${arg})")
		ADD_DEFINITIONS(-D${arg})
	ENDIF()
ENDFUNCTION()

#######################
FUNCTION(DKINCLUDE arg)
	STRING(FIND "${DKINCLUDES}" "LOCAL_C_INCLUDES += ${arg}" _indexa)
	IF(${_indexa} GREATER -1)
		RETURN() ## already exists
	ENDIF()
	STRING(FIND "${DKINCLUDES}" "INCLUDE_DIRECTORIES(${arg})" _indexa)
	IF(${_indexa} GREATER -1)
		RETURN() ## already exists
	ENDIF()
	
	IF(ANDROID)
		DKSET(DKINCLUDES ${DKINCLUDES} "LOCAL_C_INCLUDES += ${arg}\n")
	ELSE()
		DKSET(DKINCLUDES "${DKINCLUDES}INCLUDE_DIRECTORIES(${arg})\n")
		#DKSET(DKINCLUDES "${DKINCLUDES}INCLUDE_DIRECTORIES(${arg})")
		INCLUDE_DIRECTORIES(${arg})
	ENDIF()
ENDFUNCTION()

#######################
FUNCTION(DKLINKDIR arg)
	STRING(FIND "${DKLINKDIRS}" "LINK_DIRECTORIES(${arg})" _indexa)
	IF(${_indexa} GREATER -1)
		RETURN() ## already exists
	ENDIF()
	
	IF(ANDROID)
		#DKSET(DKLINKDIRS ${DKLINKDIRS} "LOCAL_LINK_INCLUDES += ${arg}\n")
	ELSE()
		DKSET(DKLINKDIRS "${DKLINKDIRS}LINK_DIRECTORIES(${arg})\n")
		#DKSET(DKLINKDIRS "${DKLINKDIRS}LINK_DIRECTORIES(${arg})")
		LINK_DIRECTORIES(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(DKINSTALL url folder_name)
	IF(EXISTS ${3RDPARTY}/${folder_name})
		###
	ELSE()
		DKSET(CURRENT_DIR ${DIGITALKNOB}/Download)
		DKDOWNLOAD(${url})
		GET_FILENAME_COMPONENT(filename ${url} NAME)
		DKEXTRACT(${DIGITALKNOB}/Download/${filename} ${3RDPARTY})
	ENDIF()
		FILE(MAKE_DIRECTORY ${3RDPARTY}/${folder_name}/${OS})
		FILE(COPY ${DKIMPORTS}/${folder_name}/ DESTINATION ${3RDPARTY}/${folder_name})
ENDFUNCTION()






###############################################################
#############   Platform specific functions 
##############################################################
FUNCTION(WIN_COMMAND arg)
	IF(WIN AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MESSAGE("COMMAND-> ${arg2}")
		EXECUTE_PROCESS(COMMAND cmd /c ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	ENDIF()	
ENDFUNCTION()

###########################
FUNCTION(WIN32_COMMAND arg)
	IF(WIN_32 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		WIN_COMMAND(${arg2})
	ENDIF()	
ENDFUNCTION()

###########################
FUNCTION(WIN64_COMMAND arg)
	IF(WIN_64 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		WIN_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

########################
FUNCTION(WIN_BASH arg)
	IF(WIN AND QUEUE_BUILD)
		MESSAGE("BASH-> ${arg}")
		FILE(WRITE ${3RDPARTY}/mingw/msys/temp ${arg})
		EXECUTE_PROCESS(COMMAND cmd /c ${3RDPARTY}/mingw/msys/bin/bash /${MSYS}/temp)
	ENDIF()
ENDFUNCTION()

########################
FUNCTION(WIN32_BASH arg)
	IF(WIN_32 AND QUEUE_BUILD)
		WIN_BASH(${arg})
	ENDIF()
ENDFUNCTION()

########################
FUNCTION(WIN64_BASH arg)
	IF(WIN_64 AND QUEUE_BUILD)
		WIN_BASH(${arg})
	ENDIF()
ENDFUNCTION()

#########################
FUNCTION(MAC_COMMAND arg)
	IF(MAC AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MESSAGE("COMMAND-> ${arg2}")
		EXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(MAC_DEBUG_COMMAND arg)
	IF(MAC AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MAC_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(MAC_RELEASE_COMMAND arg)
	IF(MAC AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MAC_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(MAC32_COMMAND arg)
	IF(MAC_32 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MAC_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(MAC64_COMMAND arg)
	IF(MAC_64 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MAC_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#########################
FUNCTION(IOS_COMMAND arg)
	IF(IOS AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MESSAGE("COMMAND-> ${arg2}")
		EXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(IOS_DEBUG_COMMAND arg)
	IF(IOS AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		IOS_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(IOS_RELEASE_COMMAND arg)
	IF(IOS AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		IOS_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(IOS32_COMMAND arg)
	IF(IOS_32 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		IOS_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(IOS64_COMMAND arg)
	IF(IOS_64 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		IOS_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

############################
FUNCTION(IOSSIM_COMMAND arg)
	IF(IOSSIM AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MESSAGE("COMMAND-> ${arg2}")
		EXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	ENDIF()
ENDFUNCTION()

##################################
FUNCTION(IOSSIM_DEBUG_COMMAND arg)
	IF(IOSSIM AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		IOSSIM_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

####################################
FUNCTION(IOSSIM_RELEASE_COMMAND arg)
	IF(IOSSIM AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		IOSSIM_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

##############################
FUNCTION(IOSSIM32_COMMAND arg)
	IF(IOSSIM_32 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		IOSSIM_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

##############################
FUNCTION(IOSSIM64_COMMAND arg)
	IF(IOSSIM_64 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		IOSSIM_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(LINUX_COMMAND arg)
	IF(LINUX AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MESSAGE("COMMAND-> ${arg2}")
		EXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(LINUX_DEBUG_COMMAND arg)
	IF(LINUX AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		LINUX_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(LINUX_RELEASE_COMMAND arg)
	IF(LINUX AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		LINUX_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(LINUX32_COMMAND arg)
	IF(LINUX_32 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		LINUX_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(LINUX32_DEBUG_COMMAND arg)
	IF(LINUX_32 AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		LINUX_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(LINUX32_RELEASE_COMMAND arg)
	IF(LINUX_32 AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		LINUX_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(LINUX64_COMMAND arg)
	IF(LINUX_64 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		LINUX_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(LINUX64_DEBUG_COMMAND arg)
	IF(LINUX_64 AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		LINUX_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(LINUX64_RELEASE_COMMAND arg)
	IF(LINUX_64 AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		LINUX_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()


#############################
FUNCTION(ANDROID_COMMAND arg)
	IF(ANDROID AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MESSAGE("COMMAND-> ${arg2}")
		EXECUTE_PROCESS(COMMAND cmd /c ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(ANDROID_DEBUG_COMMAND arg)
	IF(ANDROID AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		ANDROID_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(ANDROID_RELEASE_COMMAND arg)
	IF(ANDROID AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		ANDROID_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(ANDROID32_COMMAND arg)
	IF(ANDROID_32 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		ANDROID_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(ANDROID64_COMMAND arg)
	IF(ANDROID_64 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		ANDROID_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

##########################
FUNCTION(ANDROID_BASH arg)
	IF(ANDROID AND QUEUE_BUILD)
		MESSAGE("BASH-> ${arg}")
		FILE(WRITE ${3RDPARTY}/mingw/msys/temp ${arg})
		EXECUTE_PROCESS(COMMAND cmd /c ${3RDPARTY}/mingw/msys/bin/bash /${MSYS}/temp)
	ENDIF()
ENDFUNCTION()

############################
FUNCTION(ANDROID32_BASH arg)
	IF(ANDROID_32 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		ANDROID_BASH(${arg2})
	ENDIF()
ENDFUNCTION()

############################
FUNCTION(ANDROID64_BASH arg)
	IF(ANDROID_64 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		ANDROID_BASH(${arg2})
	ENDIF()
ENDFUNCTION()




###############################
FUNCTION(RASPBERRY_COMMAND arg)
	IF(RASPBERRY AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		MESSAGE("COMMAND-> ${arg2}")
		EXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(RASPBERRY_DEBUG_COMMAND arg)
	IF(RASPBERRY AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		RASPBERRY_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#######################################
FUNCTION(RASPBERRY_RELEASE_COMMAND arg)
	IF(RASPBERRY AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		RASPBERRY_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(RASPBERRY32_COMMAND arg)
	IF(RASPBERRY_32 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		RASPBERRY_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#######################################
FUNCTION(RASPBERRY32_DEBUG_COMMAND arg)
	IF(RASPBERRY_32 AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		RASPBERRY_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#########################################
FUNCTION(RASPBERRY32_RELEASE_COMMAND arg)
	IF(RASPBERRY_32 AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		RASPBERRY_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(RASPBERRY64_COMMAND arg)
	IF(RASPBERRY_64 AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		RASPBERRY_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#######################################
FUNCTION(RASPBERRY64_DEBUG_COMMAND arg)
	IF(RASPBERRY_64 AND DEBUG AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		RASPBERRY_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()

#########################################
FUNCTION(RASPBERRY64_RELEASE_COMMAND arg)
	IF(RASPBERRY_64 AND RELEASE AND QUEUE_BUILD)
		SET(arg2 ${arg} ${ARGN}) # Merge them together
		RASPBERRY_COMMAND(${arg2})
	ENDIF()
ENDFUNCTION()





#################################
FUNCTION(WIN32_VS_DEBUG arg arg2)
	IF(WIN_32 AND QUEUE_BUILD)
	IF(DEBUG)
		IF(NOT EXISTS ${3RDPARTY}/${arg}/${OS}/${arg2})
			MESSAGE(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${arg}/${OS}/${arg2}" )
		ENDIF()
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg3)
			SET(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /t:${arg3} /p:Configuration=Debug)
		ELSE()
			SET(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /p:Configuration=Debug)
		ENDIF()
		EXECUTE_PROCESS(COMMAND cmd /c ${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
	ENDIF()
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(WIN32_VS_RELEASE arg arg2)
	IF(WIN_32 AND QUEUE_BUILD)
	IF(RELEASE)
		IF(NOT EXISTS ${3RDPARTY}/${arg}/${OS}/${arg2})
			MESSAGE(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${arg}/${OS}/${arg2}" )
		ENDIF()
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg3)
			SET(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /t:${arg3} /p:Configuration=Release)
		ELSE()
			SET(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /p:Configuration=Release)
		ENDIF()
		EXECUTE_PROCESS(COMMAND cmd /c ${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
	ENDIF()	
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(WIN64_VS_DEBUG arg arg2)
	IF(WIN_64 AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg3)
			SET(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /t:${arg3} /p:Configuration=Debug)
		ELSE()
			SET(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /p:Configuration=Debug)
		ENDIF()
		EXECUTE_PROCESS(COMMAND cmd /c ${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
	ENDIF()
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(WIN64_VS_RELEASE arg arg2)
	IF(WIN_64 AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg3)
			SET(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /t:${arg3} /p:Configuration=Release)
		ELSE()
			SET(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /p:Configuration=Release)
		ENDIF()
		EXECUTE_PROCESS(COMMAND cmd /c ${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
	ENDIF()
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(MAC_XCODE_DEBUG arg)
	IF(MAC AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()	
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(MAC_XCODE_RELEASE arg)
	IF(MAC AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(MAC32_XCODE_DEBUG arg)
	IF(MAC_32 AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(MAC32_XCODE_RELEASE arg)
	IF(MAC_32 AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(MAC64_XCODE_DEBUG arg)
	IF(MAC_64 AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(MAC64_XCODE_RELEASE arg)
	IF(MAC_64 AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(IOS_XCODE_DEBUG arg)
	IF(IOS AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(IOS_XCODE_RELEASE arg)
	IF(IOS AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(IOS32_XCODE_DEBUG arg)
	IF(IOS_32 AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(IOS32_XCODE_RELEASE arg)
	IF(IOS_32 AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(IOS64_XCODE_DEBUG arg)
	IF(IOS_64 AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(IOS64_XCODE_RELEASE arg)
	IF(IOS64 AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

##################################
FUNCTION(IOSSIM_XCODE_DEBUG arg)
	IF(IOSSIM AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

####################################
FUNCTION(IOSSIM_XCODE_RELEASE arg)
	IF(IOSSIM AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

##################################
FUNCTION(IOSSIM32_XCODE_DEBUG arg)
	IF(IOSSIM_32 AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

####################################
FUNCTION(IOSSIM32_XCODE_RELEASE arg)
	IF(IOSSIM_32 AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

##################################
FUNCTION(IOSSIM64_XCODE_DEBUG arg)
	IF(IOSSIM_64 AND QUEUE_BUILD)
	IF(DEBUG)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

####################################
FUNCTION(IOSSIM64_XCODE_RELEASE arg)
	IF(IOSSIM_64 AND QUEUE_BUILD)
	IF(RELEASE)
		SET(extra_args ${ARGN})
		LIST(LENGTH extra_args num_extra_args)
		IF(${num_extra_args} GREATER 0)
			LIST(GET extra_args 0 arg2)
			EXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ELSE()
			EXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(ANDROID_NDK_DEBUG arg)
	IF(ANDROID AND QUEUE_BUILD)
	IF(DEBUG)
	IF(NOT UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r10d/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
	ENDIF()
	IF(UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r16b/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
	ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(ANDROID_NDK_RELEASE arg)
	IF(ANDROID AND QUEUE_BUILD)
	IF(RELEASE)
	IF(NOT UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r10d/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
	ENDIF()
	IF(UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r16b/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
	ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(ANDROID32_NDK_DEBUG arg)
	IF(ANDROID_32 AND QUEUE_BUILD)
	if(DEBUG)
	IF(NOT UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r10d/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
	ENDIF()
	IF(UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r16b/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
	ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(ANDROID32_NDK_RELEASE arg)
	IF(ANDROID_32 AND QUEUE_BUILD)
	IF(RELEASE)
	IF(NOT UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r10d/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
	ENDIF()
	IF(UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r16b/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
	ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(ANDROID64_NDK_DEBUG arg)
	IF(ANDROID_64 AND QUEUE_BUILD)
	IF(DEBUG)
	IF(NOT UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r10d/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
	ENDIF()
	IF(UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r16b/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
	ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(ANDROID64_NDK_RELEASE arg)
	IF(ANDROID_64 AND QUEUE_BUILD)
	IF(RELEASE)
	IF(NOT UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r10d/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
	ENDIF()
	IF(UNIX)
		EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r16b/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
	ENDIF()
	ENDIF()
	ENDIF()
ENDFUNCTION()



#########################
FUNCTION(DKDEBUG_LIB arg)
	IF(DEBUG)
		DKSET(LIBLIST ${LIBLIST} ${arg}) ## used for double checking
		IF(NOT EXISTS ${arg})
			MESSAGE("MISSING: ${arg}")
			DKSET(QUEUE_BUILD ON)
			DKSET(ALL_LIBS ON) ##turn on the ALL_LIBS flag to make sure everything is built in the library 
		ENDIF()
		IF(ANDROID)
			STRING(FIND "${DKLIBRARIES}" "${arg}" _indexa)
			IF(${_indexa} EQUAL -1)
				DKSET(DKLIBRARIES "LOCAL_LDFLAGS += ${arg}\n" ${DKLIBRARIES})
			ENDIF()
		ELSEIF(LINUX)
			STRING(FIND "${DEBUG_LIBS}" "${arg}" _indexa)
			IF(${_indexa} EQUAL -1)
				DKSET(DEBUG_LIBS debug ${arg} ${DEBUG_LIBS})  #Add to list
			ENDIF()
		ELSEIF(RASPBERRY)
			STRING(FIND "${DEBUG_LIBS}" "${arg}" _indexa)
			IF(${_indexa} EQUAL -1)
				DKSET(DEBUG_LIBS debug ${arg} ${DEBUG_LIBS})  #Add to list
			ENDIF()	
		ELSE()
			STRING(FIND "${DEBUG_LIBS}" "${arg}" _indexa)
			IF(${_indexa} EQUAL -1)
				DKSET(DEBUG_LIBS ${DEBUG_LIBS} debug ${arg})  #Add to list
			ENDIF()
		ENDIF()
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(DKRELEASE_LIB arg)
	IF(RELEASE)
		##MESSAGE("DKRELEASE_LIB(${arg})")
		DKSET(LIBLIST ${LIBLIST} ${arg}) ## used for double checking
		IF(NOT EXISTS ${arg})
			MESSAGE("MISSING: ${arg}")
			DKSET(QUEUE_BUILD ON)
		ENDIF()
		IF(ANDROID)
			STRING(FIND "${DKLIBRARIES}" "${arg}" _indexa)
			IF(${_indexa} EQUAL -1)
				DKSET(DKLIBRARIES "LOCAL_LDFLAGS += ${arg}\n" ${DKLIBRARIES})
			ENDIF()
		ELSEIF(LINUX)
			STRING(FIND "${RELEASE_LIBS}" "${arg}" _indexa)
			IF(${_indexa} EQUAL -1)
				DKSET(RELEASE_LIBS optimized ${arg} ${RELEASE_LIBS})  #Add to list
			ENDIF()
		ELSEIF(RASPBERRY)
			STRING(FIND "${RELEASE_LIBS}" "${arg}" _indexa)
			IF(${_indexa} EQUAL -1)
				DKSET(RELEASE_LIBS optimized ${arg} ${RELEASE_LIBS})  #Add to list
			ENDIF()	
		ELSE()
			STRING(FIND "${RELEASE_LIBS}" "${arg}" _indexa)
			IF(${_indexa} EQUAL -1)
				DKSET(RELEASE_LIBS ${RELEASE_LIBS} optimized ${arg})  #Add to list
			ENDIF()
		ENDIF()
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(WIN_DEBUG_LIB arg)
	IF(WIN)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(WIN_RELEASE_LIB arg)
	IF(WIN)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(WIN32_DEBUG_LIB arg)
	IF(WIN_32)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(WIN32_RELEASE_LIB arg)
	IF(WIN_32)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(WIN64_DEBUG_LIB arg)
	IF(WIN_64)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(WIN64_RELEASE_LIB arg)
	IF(WIN_64)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(APPLE_DEBUG_LIB arg)
	IF(APPLE)
	IF(NOT ANDROID)
		DKDEBUG_LIB(${arg})
	ENDIF()
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(APPLE_RELEASE_LIB arg)
	IF(APPLE)
	IF(NOT ANDROID)
		DKRELEASE_LIB(${arg})
	ENDIF()
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(MAC_DEBUG_LIB arg)
	IF(MAC)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(MAC_RELEASE_LIB arg)
	IF(MAC)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(MAC32_DEBUG_LIB arg)
	IF(MAC_32)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(MAC32_RELEASE_LIB arg)
	IF(MAC_32)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(MAC64_DEBUG_LIB arg)
	IF(MAC_64)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(MAC64_RELEASE_LIB arg)
	IF(MAC_64)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(IOS_DEBUG_LIB arg)
	IF(IOS)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(IOS_RELEASE_LIB arg)
	IF(IOS)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(IOS32_DEBUG_LIB arg)
	IF(IOS_32)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(IOS32_RELEASE_LIB arg)
	IF(IOS_32)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(IOS64_DEBUG_LIB arg)
	IF(IOS_64)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(IOS64_RELEASE_LIB arg)
	IF(IOS_64)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

##############################
FUNCTION(IOSSIM_DEBUG_LIB arg)
	IF(IOSSIM)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

################################
FUNCTION(IOSSIM_RELEASE_LIB arg)
	IF(IOSSIM)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

##############################
FUNCTION(IOSSIM32_DEBUG_LIB arg)
	IF(IOSSIM_32)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

################################
FUNCTION(IOSSIM32_RELEASE_LIB arg)
	IF(IOSSIM_32)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(LINUX_DEBUG_LIB arg)
	IF(LINUX AND DEBUG)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(LINUX_RELEASE_LIB arg)
	IF(LINUX AND RELEASE)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(LINUX32_DEBUG_LIB arg)
	IF(LINUX32 AND DEBUG)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(LINUX32_RELEASE_LIB arg)
	IF(LINUX32 AND RELEASE)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(LINUX64_DEBUG_LIB arg)
	IF(LINUX64 AND DEBUG)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(LINUX64_RELEASE_LIB arg)
	IF(LINUX64 AND RELEASE)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(ANDROID_DEBUG_LIB arg)
	IF(ANDROID AND DEBUG)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(ANDROID_RELEASE_LIB arg)
	IF(ANDROID AND RELEASE)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(ANDROID32_DEBUG_LIB arg)
	IF(ANDROID_32 AND DEBUG)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(ANDROID32_RELEASE_LIB arg)
	IF(ANDROID_32 AND RELEASE)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(ANDROID64_DEBUG_LIB arg)
	IF(ANDROID_64 AND DEBUG)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(ANDROID64_RELEASE_LIB arg)
	IF(ANDROID_64 AND RELEASE)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()


#################################
FUNCTION(RASPBERRY_DEBUG_LIB arg)
	IF(RASPBERRY AND DEBUG)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(RASPBERRY_RELEASE_LIB arg)
	IF(RASPBERRY AND RELEASE)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(RASPBERRY32_DEBUG_LIB arg)
	IF(RASPBERRY32 AND DEBUG)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(RASPBERRY32_RELEASE_LIB arg)
	IF(RASPBERRY32 AND RELEASE)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(RASPBERRY64_DEBUG_LIB arg)
	IF(RASPBERRY64 AND DEBUG)
		DKDEBUG_LIB(${arg})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(RASPBERRY64_RELEASE_LIB arg)
	IF(RASPBERRY64 AND RELEASE)
		DKRELEASE_LIB(${arg})
	ENDIF()
ENDFUNCTION()



#########################
FUNCTION(WIN_INCLUDE arg)
	IF(WIN)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(WIN32_INCLUDE arg)
	IF(WIN_32)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(WIN64_INCLUDE arg)
	IF(WIN_64)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(APPLE_INCLUDE arg)
	IF(APPLE)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#########################
FUNCTION(MAC_INCLUDE arg)
	IF(MAC)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(MAC32_INCLUDE arg)
	IF(MAC_32)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(MAC64_INCLUDE arg)
	IF(MAC_64)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#########################
FUNCTION(IOS_INCLUDE arg)
	IF(IOS)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(IOS32_INCLUDE arg)
	IF(IOS_32)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(IOS64_INCLUDE arg)
	IF(IOS_64)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

############################
FUNCTION(IOSSIM_INCLUDE arg)
	IF(IOSSIM)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

##############################
FUNCTION(IOSSIM32_INCLUDE arg)
	IF(IOSSIM_32)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

##############################
FUNCTION(IOSSIM64_INCLUDE arg)
	IF(IOSSIM_64)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###########################
FUNCTION(LINUX_INCLUDE arg)
	IF(LINUX)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(LINUX32_INCLUDE arg)
	IF(LINUX_32)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(LINUX64_INCLUDE arg)
	IF(LINUX_64)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(LINUX_DEBUG_INCLUDE arg)
	IF(DEBUG)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(LINUX_RELEASE_INCLUDE arg)
	IF(RELEASE)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(LINUX32_DEBUG_INCLUDE arg)
	IF(LINUX_32 AND DEBUG)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(LINUX32_RELEASE_INCLUDE arg)
	IF(LINUX_32 AND RELEASE)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(LINUX64_DEBUG_INCLUDE arg)
	IF(LINUX_64 AND DEBUG)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(LINUX64_RELEASE_INCLUDE arg)
	IF(LINUX_64 AND RELEASE)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(ANDROID_INCLUDE arg)
	IF(ANDROID)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(ANDROID32_INCLUDE arg)
	IF(ANDROID_32)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###############################
FUNCTION(ANDROID64_INCLUDE arg)
	IF(ANDROID_64)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(ANDROID_DEBUG_INCLUDE arg)
	IF(DEBUG)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(ANDROID_RELEASE_INCLUDE arg)
	IF(RELEASE)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(ANDROID32_DEBUG_INCLUDE arg)
	IF(ANDROID_32 AND DEBUG)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#######################################
FUNCTION(ANDROID32_RELEASE_INCLUDE arg)
	IF(ANDROID_32 AND RELEASE)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()



###########################
FUNCTION(RASPBERRY_INCLUDE arg)
	IF(RASPBERRY)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(RASPBERRY32_INCLUDE arg)
	IF(RASPBERRY_32)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#############################
FUNCTION(RASPBERRY64_INCLUDE arg)
	IF(RASPBERRY_64)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(RASPBERRY_DEBUG_INCLUDE arg)
	IF(DEBUG)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(RASPBERRY_RELEASE_INCLUDE arg)
	IF(RELEASE)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(RASPBERRY32_DEBUG_INCLUDE arg)
	IF(RASPBERRY_32 AND DEBUG)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(RASPBERRY32_RELEASE_INCLUDE arg)
	IF(RASPBERRY_32 AND RELEASE)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

###################################
FUNCTION(RASPBERRY64_DEBUG_INCLUDE arg)
	IF(RASPBERRY_64 AND DEBUG)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()

#####################################
FUNCTION(RASPBERRY64_RELEASE_INCLUDE arg)
	IF(RASPBERRY_64 AND RELEASE)
		DKINCLUDE(${arg})
	ENDIF()
ENDFUNCTION()






######################
FUNCTION(DKPLUGIN arg)
	#MESSAGE("DKPLUGIN(${arg})")
	DKSETPATHTOPLUGIN(${arg})
	IF(NOT PATHTOPLUGIN)
		RETURN()
	ENDIF()
	
	IF(ANDROID)
		DKSET(ANDROID_LIBMK ${ANDROID_LIBMK}
			"LOCAL_PATH:= $(call my-dir)\n"
			"include $(CLEAR_VARS)\n"
			"LOCAL_MODULE := ${arg}\n"
			"ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)\n"
			"    ARM_NEON := true\n"
			"endif\n"
			"LOCAL_SRC_FILES := $(wildcard ${PATHTOPLUGIN}/*.cpp)\n"
			"LOCAL_SRC_FILES += $(wildcard ${PATHTOPLUGIN}/*.c)\n\n"
			"LOCAL_CPPFLAGS := -DANDROID\n"
			"LOCAL_CPPFLAGS += -std=gnu++11\n"
			"LOCAL_LDFLAGS :=\n\n")
		DKINCLUDE(${PATHTOPLUGIN})

	ELSE()
		##DKINCLUDE(${PATHTOPLUGIN})
		##DKINCLUDE(${DIGITALKNOB}/3rdParty)	
		DKINCLUDE(${DIGITALKNOB}/DKPlugins)
		##DKINCLUDE(${DIGITALKNOB}/DKPlugins/DK)
		##Create CmakeLists.txt file
		DKSET(CMAKE_FILE "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###")
		DKSET(CMAKE_FILE "### ${arg} ###\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}CMAKE_MINIMUM_REQUIRED(VERSION 3.0)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}CMAKE_POLICY(SET CMP0054 NEW)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/FUNCTIONS.cmake)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/OPTIONS.cmake)\n")
		IF(IOS)
			DKSET(CMAKE_FILE "${CMAKE_FILE}SET(IOS_PLATFORM OS)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/iOS.cmake)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-DIOS)\n")
		ENDIF()
		IF(IOSSIM)
			DKSET(CMAKE_FILE "${CMAKE_FILE}SET(IOS_PLATFORM SIMULATOR)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/iOS.cmake)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-DIOS)\n")
		ENDIF()
		DKSET(CMAKE_FILE "${CMAKE_FILE}SET(CMAKE_CXX_STANDARD 14)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}PROJECT(${arg})\n")
		##DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE_DIRECTORIES(${PATHTOPLUGIN})\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}${DKINCLUDES}")
		DKSET(CMAKE_FILE "${CMAKE_FILE}${DKDEFINES}")
		DKSET(CMAKE_FILE "${CMAKE_FILE}${DKLINKDIRS}\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}FILE(GLOB DK_SRC \n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}	   ${PATHTOPLUGIN}/*.h\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.c\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.cpp\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.rc\n")
		IF(IOS OR IOSSIM)
			DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.mm\n")
		ENDIF()
		DKSET(CMAKE_FILE "${CMAKE_FILE})\n")
		IF(STATIC)
			DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_LIBRARY(${arg} STATIC \${DK_SRC})\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_COMPILE_OPTIONS(${arg} PRIVATE ${FLAGS})\n")
		ENDIF()
		IF(DYNAMIC)
			#IF(${arg} STREQUAL DK)
			#	DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_LIBRARY(${arg} STATIC \${DK_SRC})\n")
			#ELSE()
				DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_LIBRARY(${arg} SHARED \${DK_SRC})\n")
			#ENDIF()
			DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-D_WIN32_WINNT=0x0600)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}SET_TARGET_PROPERTIES(${arg} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}target_compile_options(${arg} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
			IF(DEBUG_LIBS)
				string(REPLACE "debug" " debug " DLL_DEBUG_LIBS ${DEBUG_LIBS})
			ENDIF()
			IF(RELEASE_LIBS)
				string(REPLACE "optimized" " optimized " DLL_RELEASE_LIBS ${RELEASE_LIBS})
			ENDIF()
			IF(WIN_LIBS)
				string(REPLACE ".lib" ".lib " DLL_WIN_LIBS ${WIN_LIBS})
			ENDIF()
			IF(DLL_DEBUG_LIBS AND DLL_RELEASE_LIBS)
				#DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_LINK_LIBRARIES(${arg} debug ${DKPLUGINS}/DK/${OS}/${DEBUG}/DK.lib optimized ${DKPLUGINS}/DK/${OS}/${RELEASE}/DK.lib) \n")
				DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_LINK_LIBRARIES(${arg} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_WIN_LIBS}) \n")
			ENDIF()
		ENDIF()
		DKSET(CMAKE_FILE "${CMAKE_FILE}IF(WIN32)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}    SET_TARGET_PROPERTIES(${arg} PROPERTIES LINKER_LANGUAGE CPP)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}ENDIF()\n")	
	ENDIF()
	
	DKSET(DKCPPPLUGS ${DKCPPPLUGS} ${arg})  #Add to list
	
	##add headers to DKPlugins.h
	IF(${arg} STREQUAL DK OR STATIC)
		FILE(GLOB HEADER_FILES RELATIVE ${DIGITALKNOB}/DKPlugins ${PATHTOPLUGIN}/*.h)
		FOREACH(header ${HEADER_FILES})
			STRING(FIND "${PLUGINS_FILE}" "${header}" _indexa)
			IF(${_indexa} EQUAL -1)
				MESSAGE("Adding ${header} to header file.")
				DKSET(PLUGINS_FILE ${PLUGINS_FILE} "#include \"${header}\"\\n")
			ENDIF()
		ENDFOREACH()
	ENDIF()
ENDFUNCTION()

###################
FUNCTION(DKDLL arg)
	#MESSAGE("DKDLL(${arg})")
	DKSETPATHTOPLUGIN(${arg})
	IF(NOT PATHTOPLUGIN)
		RETURN()
	ENDIF()
	
	DKINCLUDE(${PATHTOPLUGIN})
			
	##Create CmakeLists.txt file
	DKSET(CMAKE_FILE "### ${arg} ###\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}CMAKE_MINIMUM_REQUIRED(VERSION 3.0)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/FUNCTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/OPTIONS.cmake)\n")
	IF(IOS)
		DKSET(CMAKE_FILE "${CMAKE_FILE}SET(IOS_PLATFORM OS)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/iOS.cmake)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-DIOS)\n")
	ENDIF()
	IF(IOSSIM)
		DKSET(CMAKE_FILE "${CMAKE_FILE}SET(IOS_PLATFORM SIMULATOR)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/iOS.cmake)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-DIOS)\n")
	ENDIF()
	DKSET(CMAKE_FILE "${CMAKE_FILE}PROJECT(${arg})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE_DIRECTORIES(${PATHTOPLUGIN})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}${DKINCLUDES}")
	DKSET(CMAKE_FILE "${CMAKE_FILE}${DKDEFINES}")
	DKSET(CMAKE_FILE "${CMAKE_FILE}${DKLINKDIRS}\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}FILE(GLOB DK_SRC \n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}	   ${PATHTOPLUGIN}/*.h\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.c\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.cpp\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.rc\n")
	IF(IOS OR IOSSIM)
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.mm\n")
	ENDIF()
	DKSET(CMAKE_FILE "${CMAKE_FILE})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_LIBRARY(${arg} SHARED \${DK_SRC})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-D_WIN32_WINNT=0x0600)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}SET_TARGET_PROPERTIES(${arg} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}target_compile_options(${arg} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
	IF(DEBUG_LIBS)
		string(REPLACE "debug" " debug " DLL_DEBUG_LIBS ${DEBUG_LIBS})
	ENDIF()
	IF(RELEASE_LIBS)
		string(REPLACE "optimized" " optimized " DLL_RELEASE_LIBS ${RELEASE_LIBS})
	ENDIF()
	IF(WIN_LIBS)
		string(REPLACE ".lib" ".lib " DLL_WIN_LIBS ${WIN_LIBS})
	ENDIF()
	IF(DLL_DEBUG_LIBS AND DLL_RELEASE_LIBS)
		#DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_LINK_LIBRARIES(${arg} debug ${DKPLUGINS}/DK/${OS}/${DEBUG}/DK.lib optimized ${DKPLUGINS}/DK/${OS}/${RELEASE}/DK.lib) \n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_LINK_LIBRARIES(${arg} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_WIN_LIBS}) \n")
	ENDIF()
	DKSET(CMAKE_FILE "${CMAKE_FILE}IF(WIN32)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    SET_TARGET_PROPERTIES(${arg} PROPERTIES LINKER_LANGUAGE CPP)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}ENDIF()\n")	
	DKSET(DKCPPPLUGS ${DKCPPPLUGS} ${arg})  #Add to list	
ENDFUNCTION()


############################
FUNCTION(DKEXECUTABLE arg)
	##Create CmakeLists.txt file
	DKSETPATHTOPLUGIN(${arg})
	IF(NOT PATHTOPLUGIN)
		RETURN()
	ENDIF()
	
	DKINCLUDE(${PATHTOPLUGIN})
	DKSET(CMAKE_FILE "### ${arg} ###\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}CMAKE_MINIMUM_REQUIRED(VERSION 3.0)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/FUNCTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/OPTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}PROJECT(${arg})\n")
ENDFUNCTION()

############################
FUNCTION(DKAPPEND_CMAKE arg)
	DKSET(CMAKE_FILE "${CMAKE_FILE} ${arg}")
ENDFUNCTION()

########################
SET(ASSETS 
	PATTERN *.h EXCLUDE
	PATTERN *.c EXCLUDE
	PATTERN *.cpp EXCLUDE
	PATTERN *.mm EXCLUDE
	PATTERN *.plist EXCLUDE
	PATTERN *.rc EXCLUDE
	PATTERN DKCMake.txt EXCLUDE
	PATTERN CMakeLists.txt EXCLUDE
	PATTERN temp.txt EXCLUDE
	PATTERN win32 EXCLUDE
	PATTERN win64 EXCLUDE
	PATTERN mac32 EXCLUDE
	PATTERN mac64 EXCLUDE
	PATTERN ios32 EXCLUDE
	PATTERN ios64 EXCLUDE
	PATTERN iossim32 EXCLUDE
	PATTERN iossim64 EXCLUDE
	PATTERN linux32 EXCLUDE
	PATTERN linux64 EXCLUDE
	PATTERN android32 EXCLUDE
	PATTERN android64 EXCLUDE
	PATTERN raspberry32 EXCLUDE
	PATTERN raspberry64 EXCLUDE
	PATTERN cefchild EXCLUDE
	PATTERN dktest EXCLUDE)
	##PATTERN README.txt EXCLUDE)

FUNCTION(DKASSETS arg)
	DKSETPATHTOPLUGIN(${arg})
	IF(NOT PATHTOPLUGIN)
		RETURN()
	ENDIF()
	MESSAGE("Importing assets...")
	FILE(COPY ${PATHTOPLUGIN} DESTINATION ${DKPROJECT}/assets ${ASSETS})
ENDFUNCTION()

## FIXME: This only works on DK/3rdParty/_DKIMPORT, it needs to work on sibling folders as well
## I.E.  MyApps/3rdParty/_DKIMPORT/libSomething_1.2b
FUNCTION(DKSETPATHTOPLUGIN arg)
	DKSET(PATHTOPLUGIN "")
	IF(EXISTS ${DKPLUGINS}/${arg}/DKCMake.txt)
		DKSET(PATHTOPLUGIN "${DKPLUGINS}/${arg}")
		MESSAGE("FOUND ${arg} DKPlugin at ${PATHTOPLUGIN}")
		RETURN()
	ELSEIF(EXISTS ${DKIMPORTS}/${arg}/DKCMake.txt)
		DKSET(PATHTOPLUGIN "${DKIMPORTS}/${arg}")
		MESSAGE("FOUND ${arg} DKImport at ${PATHTOPLUGIN}")
		RETURN()
	ENDIF()
	
	FILE(GLOB children RELATIVE ${DIGITALKNOB}/../ ${DIGITALKNOB}/../*)
  	FOREACH(child ${children})
		IF(EXISTS ${DIGITALKNOB}/../${child}/DKPlugins/${arg}/DKCMake.txt)
			DKSET(PATHTOPLUGIN "${DIGITALKNOB}/../${child}/DKPlugins/${arg}")
			MESSAGE("FOUND ${arg} Plugin at ${PATHTOPLUGIN}")
			RETURN()
    	ENDIF()
  	ENDFOREACH()
	
	MESSAGE(FATAL_ERROR "Could not find ${arg} Plugin.")   ## FIXME - we only seem to look in the DK/3rdParty/_DKIMPORT for plugins
ENDFUNCTION()


### This is the current way to build the dependency list 
### After the list is orginized, the DKCMake.txt files will be run in order.
### This first method, finds the DKCMake.txt file and searches for DKDEPEND() comands.
### This loop will orginize them from top to bottom, then they will be run.
### This is more of a brute-force method, but it also ensures too many libraries will be included
### (LARGER EXECUTABLE FILE)

### The second method.
### "Strip everything from the file but DKDEPEND() commands."
### "As well as, IF(), ELSE(), ENDIF(), RETURN() and any other needed commands"
### "When the file is striped down to only those lines, the file can be run normaly without fear of other commands."
### "This give's us more control over the DKDEPEND()'s inside IF() commands"
### This is the relaxed method and should only add the libraries neccesary
### (smaller executable file)
###
### This also means that any library with more than one sub library must be given wrapping IF() commands
### It's up to the DKCmake.txt file to decide how to handle this. 
### Say for instance you only want OSG's gif plugin..  
###    DKDEPEND(OpenScenGraph osgdb_gif)  "The osgdb_gif library should be wrapped in an IF(osgdb_gif)
### And also I.E, a DKDEPEND(giflib-5.1.1) command should be contained in that IF(osgdb_gif) command.
### This is so they don't get called unless that variable is set. This is the whole purpose of method 2.

######################
FUNCTION(DKDEPEND arg)
	#MESSAGE("DKDEPEND(${arg})")
	## If DKDEPEND had second variable, set that variable to ON
	SET(extra_args ${ARGN})
	LIST(LENGTH extra_args num_extra_args)
	IF(${num_extra_args} GREATER 0)
		LIST(GET extra_args 0 arg2)
		#DKENABLE(${arg2})
		## If the library is already in the list, return.
		LIST(FIND DKPLUGS "${arg} ${args}" _index)
		IF(${_index} GREATER -1)
			return()
		ENDIF()
		DKRUNDEPENDS(${arg} ${arg2}) ##strip everything out of the file except IF() ELSE() ENDIF() and DKDEPEND() and include it
		#DKBRUTEDEPENDS(${arg} ${arg2}) ##USE Brute force to search the files for DKDEPENDS() commands  -ignores IF(), ELSE().. and all commands
	ELSE()
		## If the library is already in the list, return.
		LIST(FIND DKPLUGS "${arg}" _index)
		IF(${_index} GREATER -1)
			return()
		ENDIF()
		DKRUNDEPENDS(${arg}) ##strip everything out of the file except IF() ELSE() ENDIF() and DKDEPEND() and include it
		#DKBRUTEDEPENDS(${arg}) ##USE Brute force to search the files for DKDEPENDS() commands  -ignores IF(), ELSE().. and all commands
	ENDIF()
ENDFUNCTION()


## This function would like to remove everthing but,
## DKDEPEND() IF() ELSE() and ENDIF() commands from the DKCmake.txt file
##########################
FUNCTION(DKRUNDEPENDS arg)
	DKSETPATHTOPLUGIN(${arg})
	IF(NOT PATHTOPLUGIN)
		RETURN()
	ENDIF()
	
	FILE(STRINGS ${PATHTOPLUGIN}/DKCMake.txt lines)
	UNSET(ModifiedContents)
	UNSET(_indexa)
	FOREACH(line ${lines})
		STRING(FIND "${line}" "IF(" _indexa)
		IF(${_indexa} GREATER -1)
			SET(ModifiedContents "${ModifiedContents}${line}\n")
		ENDIF()
		
		STRING(FIND "${line}" "ELSE(" _indexa)
		IF(${_indexa} GREATER -1)
			SET(ModifiedContents "${ModifiedContents}${line}\n")
		ENDIF()
		
		STRING(FIND "${line}" "DKDEPEND(" _indexa)
		IF(${_indexa} GREATER -1)
			SET(ModifiedContents "${ModifiedContents}${line}\n")
		ENDIF()
		
		STRING(FIND "${line}" "RETURN(" _indexa)
		IF(${_indexa} GREATER -1)
			SET(ModifiedContents "${ModifiedContents}${line}\n")
		ENDIF()
		
		STRING(FIND "${line}" "DKENABLE(" _indexa)
		IF(${_indexa} GREATER -1)
			SET(ModifiedContents "${ModifiedContents}${line}\n")
		ENDIF()	
	ENDFOREACH()

	SET(extra_args ${ARGN})
	LIST(LENGTH extra_args num_extra_args)
	IF(${num_extra_args} GREATER 0)
		LIST(GET extra_args 0 arg2)
	ENDIF()
	
	IF(ModifiedContents)
		FILE(WRITE ${PATHTOPLUGIN}/temp.txt "${ModifiedContents}")
		IF(${num_extra_args} GREATER 0)
			DKENABLE(${arg2})
		ENDIF()
		INCLUDE(${PATHTOPLUGIN}/temp.txt)
		IF(${num_extra_args} GREATER 0)
			DKSET(${arg2} OFF)
		ENDIF()
	ENDIF()
	
	IF(${num_extra_args} GREATER 0)
		DKSET(DKPLUGS ${DKPLUGS} "${arg} ${arg2}")  #Add to list
	ELSE()
		DKSET(DKPLUGS ${DKPLUGS} ${arg})  #Add to list
	ENDIF()	
ENDFUNCTION()

############################
FUNCTION(DKBRUTEDEPENDS arg)
	################################################################
	## USE Brute force to search the file for DKDEPENDS() commands
	DKSETPATHTOPLUGIN(${arg})
	IF(NOT PATHTOPLUGIN)
		RETURN()
	ENDIF()
	
	FILE(READ ${PATHTOPLUGIN}/DKCMake.txt data) ## read the file into a variable
	SET(_index 0)
	STRING(FIND "${data}" "DKDEPEND(" _index) ## look for the first DKDEPEND( command
	WHILE(${_index} GREATER -1)
		STRING(SUBSTRING ${data} ${_index} -1 data2)
		#MESSAGE("DKDEPEND(${arg})")
		STRING(FIND ${data2} ")" _index)
		MATH(EXPR _index "${_index}-9")
		STRING(SUBSTRING ${data2} 9 ${_index} data3)
		
		#MESSAGE("CHILD ${data3}")
		#IF ${data3} contains a space, split variable
		SET(_space 0)
		STRING(FIND ${data3} " " _space)
		IF(${_space} GREATER -1)
			STRING(SUBSTRING ${data3} 0 ${_space} firstvar)
			#MESSAGE(${firstvar})
			MATH(EXPR _space "${_space}+1")
			STRING(SUBSTRING ${data3} ${_space} -1 secondvar)
			#MESSAGE(${secondvar})
			DKDEPEND(${firstvar} ${secondvar})
		ELSE()
			DKDEPEND(${data3})
		ENDIF()

		MATH(EXPR _index "${_index}+10")
		STRING(SUBSTRING ${data2} ${_index} -1 data)
		STRING(FIND ${data} "DKDEPEND(" _index)
	ENDWHILE()
	
	SET(extra_args ${ARGN})
	LIST(LENGTH extra_args num_extra_args)
	IF(${num_extra_args} GREATER 0)
		LIST(GET extra_args 0 arg2)
	ENDIF()
	
	IF(${num_extra_args} GREATER 0)
		DKSET(DKPLUGS ${DKPLUGS} "${arg} ${arg2}")  #Add to list
	ELSE()
		DKSET(DKPLUGS ${DKPLUGS} ${arg})  #Add to list
	ENDIF()
ENDFUNCTION()

#######################
FUNCTION (DKDEPEND_ALL)
	##TODO - get a list of all DKPlugins and call DKPEPEND(DKPlugin) for each of them.
ENDFUNCTION()

###################################
FUNCTION(DKUPDATE_ANDROID_NAME arg)
	
	MESSAGE("Updating Android App name in files...")
	STRING(TOLOWER ${arg} arg)
	FILE(READ ${DKPROJECT}/Android.h android_H)
	STRING(REPLACE "_dkapp_" "_${arg}_" android_H "${android_H}")
	STRING(REPLACE "\"dkapp\"" "\"${arg}\"" android_H "${android_H}")
	FILE(WRITE ${DKPROJECT}/Android.h "${android_H}")

	IF(ANDROID AND DEBUG)
		## update all .xml and .java files recursivley
		FILE(GLOB_RECURSE allfiles RELATIVE "${DKPROJECT}/${OS}/${DEBUG}/" "${DKPROJECT}/${OS}/${DEBUG}/*.xml" "${DKPROJECT}/${OS}/${DEBUG}/*.java")
		FOREACH(each_file ${allfiles})
			SET(thefile "${DKPROJECT}/${OS}/${DEBUG}/${each_file}")
			FILE(READ ${thefile} filestring)
			STRING(REPLACE "dkapp" "${arg}" filestring "${filestring}")
			FILE(WRITE ${thefile} "${filestring}")
		ENDFOREACH()
		
		DKREMOVE(${DKPROJECT}/${OS}/${DEBUG}/src/digitalknob/${arg})
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG}/src/digitalknob/dkapp ${DKPROJECT}/${OS}/${DEBUG}/src/digitalknob/${arg})
	ENDIF()
	IF(ANDROID AND RELEASE)
		## update all .xml and .java files recursivley
		FILE(GLOB_RECURSE allfiles RELATIVE "${DKPROJECT}/${OS}/${RELEASE}/" "${DKPROJECT}/${OS}/${RELEASE}/*.xml" "${DKPROJECT}/${OS}/${RELEASE}/*.java")
		FOREACH(each_file ${allfiles})
			SET(thefile "${DKPROJECT}/${OS}/${RELEASE}/${each_file}")
			MESSAGE(${thefile})
			FILE(READ ${thefile} filestring)
			STRING(REPLACE "dkapp" "${arg}" filestring "${filestring}")
			FILE(WRITE ${thefile} "${filestring}")
		ENDFOREACH()
		
		DKREMOVE(${DKPROJECT}/${OS}/${RELEASE}/src/digitalknob/${arg})
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE}/src/digitalknob/dkapp ${DKPROJECT}/${OS}/${RELEASE}/src/digitalknob/${arg})
	ENDIF()
ENDFUNCTION()

#################################
FUNCTION(DKUPDATE_INFO_PLIST arg)
	IF(MAC)
		## FIXME
		MESSAGE("Updating MAC info.plist . . .")
		IF(DEBUG)
			IF(EXISTS ${DKPROJECT}/${OS}/${DEBUG}/${arg}.app/Contents/info.plist)
				FILE(READ ${DKPROJECT}/${OS}/${DEBUG}/${arg}.app/Contents/info.plist plist)
				STRING(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				STRING(REPLACE "<string>logo</string>" "" plist ${plist})
				STRING(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				FILE(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG}/${arg}.app/Contents/info.plist)
			ENDIF()
		ENDIF()
		
		IF(RELEASE)
			IF(EXISTS ${DKPROJECT}/${OS}/${RELEASE}/${arg}.app/Contents/info.plist)
				FILE(READ ${DKPROJECT}/${OS}/${RELEASE}/${arg}.app/Contents/info.plist plist)
				STRING(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				STRING(REPLACE "<string>logo</string>" "" plist ${plist})
				STRING(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				FILE(WRITE "${plist}" ${DKPROJECT}/${OS}/${RELEASE}/${arg}.app/Contents/info.plist)
			ENDIF()	
		ENDIF()
	ENDIF()
	IF(IOS OR IOSSIM)
		MESSAGE("Updating IOS Info.plist . . .")
		MESSAGE("CHECKING FOR... ${DKPROJECT}/${OS}/${DEBUG}/${arg}.app/Info.plist")
		IF(EXISTS ${DKPROJECT}/${OS}/${DEBUG}/${arg}.app/Info.plist)
			MESSAGE("Updating IOS Debug Info.plist . . .")
			FILE(READ ${DKPROJECT}/${OS}/${DEBUG}/${arg}.app/Info.plist plist)
			STRING(REPLACE "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist ${plist})
			FILE(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG}/${arg}.app/Info.plist)
		ENDIF()
	ENDIF()
ENDFUNCTION()




# Function to wrap a given string into multiple lines at the given column position.
# Parameters:
#   VARIABLE    - The name of the CMake variable holding the string.
#   AT_COLUMN   - The column position at which string will be wrapped.
function(WRAP_STRING)
    set(oneValueArgs VARIABLE AT_COLUMN)
    cmake_parse_arguments(WRAP_STRING "${options}" "${oneValueArgs}" "" ${ARGN})

    string(LENGTH ${${WRAP_STRING_VARIABLE}} stringLength)
    math(EXPR offset "0")

    while(stringLength GREATER 0)

        if(stringLength GREATER ${WRAP_STRING_AT_COLUMN})
            math(EXPR length "${WRAP_STRING_AT_COLUMN}")
        else()
            math(EXPR length "${stringLength}")
        endif()

        string(SUBSTRING ${${WRAP_STRING_VARIABLE}} ${offset} ${length} line)
        set(lines "${lines}\n${line}")

        math(EXPR stringLength "${stringLength} - ${length}")
        math(EXPR offset "${offset} + ${length}")
    endwhile()

    set(${WRAP_STRING_VARIABLE} "${lines}" PARENT_SCOPE)
endfunction()



## https://gist.github.com/sivachandran/3a0de157dccef822a230#file-bin2h-cmake
# Function to embed contents of a file as byte array in C/C++ header file(.h). The header file
# will contain a byte array and integer variable holding the size of the array.
# Parameters
#   SOURCE_FILE     - The path of source file whose contents will be embedded in the header file.
#   VARIABLE_NAME   - The name of the variable for the byte array. The string "_SIZE" will be append
#                     to this name and will be used a variable name for size variable.
#   HEADER_FILE     - The path of header file.
#   APPEND          - If specified appends to the header file instead of overwriting it
#   NULL_TERMINATE  - If specified a null byte(zero) will be append to the byte array. This will be
#                     useful if the source file is a text file and we want to use the file contents
#                     as string. But the size variable holds size of the byte array without this
#                     null byte.
# Usage:
#   bin2h(SOURCE_FILE "Logo.png" HEADER_FILE "Logo.h" VARIABLE_NAME "LOGO_PNG")
function(BIN2H)
    set(options APPEND NULL_TERMINATE)
    set(oneValueArgs SOURCE_FILE VARIABLE_NAME HEADER_FILE)
    cmake_parse_arguments(BIN2H "${options}" "${oneValueArgs}" "" ${ARGN})

    # reads source file contents as hex string
    file(READ ${BIN2H_SOURCE_FILE} hexString HEX)
    string(LENGTH ${hexString} hexStringLength)

    # appends null byte if asked
    if(BIN2H_NULL_TERMINATE)
        set(hexString "${hexString}00")
    endif()

    # wraps the hex string into multiple lines at column 32(i.e. 16 bytes per line)
    ##wrap_string(VARIABLE hexString AT_COLUMN 32)
    math(EXPR arraySize "${hexStringLength} / 2")

    # adds '0x' prefix and comma suffix before and after every byte respectively
    ##string(REGEX REPLACE "([0-9a-f][0-9a-f])" "\\1" arrayValues ${hexString})
    # removes trailing comma
    ##string(REGEX REPLACE ", $" "" arrayValues ${arrayValues})

    # converts the variable name into proper C identifier
    string(MAKE_C_IDENTIFIER "${BIN2H_VARIABLE_NAME}" BIN2H_VARIABLE_NAME)
    string(TOUPPER "${BIN2H_VARIABLE_NAME}" BIN2H_VARIABLE_NAME)

    # declares byte array and the length variables
    set(arrayDefinition "std::string ${BIN2H_VARIABLE_NAME} = \"${hexString}\";")
    set(arraySizeDefinition "size_t ${BIN2H_VARIABLE_NAME}_SIZE = ${arraySize};")

    set(declarations "${arrayDefinition}\n\n${arraySizeDefinition}\n\n")
    if(BIN2H_APPEND)
        file(APPEND ${BIN2H_HEADER_FILE} "${declarations}")
    else()
        file(WRITE ${BIN2H_HEADER_FILE} "${declarations}")
    endif()
endfunction()
