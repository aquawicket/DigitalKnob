include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_importGit(url) #tag #PATCH
#
#	TODO
#
#	@url			- The git url to clone
# 	BRANCH @branch	- OPTIONAL: The branch name to checkout
#   ID @id			- OPTIONAL: The commit-id to checkout
#
function(dk_importGit url) #branch #id #PATCH
	dk_debugFunc(${ARGV})
	
	dk_getOption(PATCH ${ARGV})
	
	dk_load(${DKIMPORTS_DIR}/git/DKMAKE.cmake)
	DKASSERT(GIT_EXE)
	
	string(REPLACE "/" ";" url_list ${url})  #split url path into list
	foreach(item ${url_list})
		dk_verbose(item)
	endforeach()
	
	list(LENGTH url_list url_list_size)
	dk_verbose(url_list_size)

	# GITHUB
	if(${url_list_size} LESS 5)
		dk_error("url_list doesn't contain enough elements to have a 'orginization/library'")
	endif()	
	
	set(branch "master")
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(branch "${ARGV1}")
		endif()
	endif()
	
	if(NOT Lib)
		string(FIND ${url} "github.com" includes)
		if(${includes} EQUAL -1)
		#dk_includes(${url} "github.com" includes)
		#if(NOT ${includes})
			string(FIND ${url} "gitlab.com" includes)
			if(${includes} EQUAL -1)
			#dk_includes(${url} "gitlab.com" includes)
			#if(NOT ${includes})
				dk_error("The url does not contain 'github.com' OR 'gitlab.com'")
			endif()
		endif()
	
		list(GET url_list 3 org)
		dk_verbose(org)
	
		list(GET url_list 4 Lib)
		dk_verbose(Lib)
		
		string(FIND ${Lib} ".git" index)
		if(${index} GREATER -1)
		#dk_includes(${Lib} ".git" index)
		#if(${index})
			string(SUBSTRING ${Lib} 0 ${index} Lib)
		endif()
	endif()
	
	dk_toLower(${Lib} Lib)
	dk_verbose(Lib)
	
	math(EXPR last "${url_list_size}-1")  #OUTPUT_FORMAT DECIMAL)")  CMake 3.13+
	list(GET url_list ${last} url${last})
	
	string(FIND ${url${last}} ".git" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".git" index)
	#if(${index})
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
			dk_toLower(${ID} FOLDER)
			dk_verbose(FOLDER)
		endif()
	endif()
	
	# check current folder name
	if(NOT "${DKIMPORTS_DIR}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		dk_error("\n\nThe Imports folder is named incorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS_DIR}/${FOLDER}\n\n")
	endif()
	
	dk_toUpper(${Lib} LIBVAR)
	if(NOT LIBVAR)
		dk_error("$(LIBVAR) is invalid")
	endif()
	dk_verbose(LIBVAR)
	
	dk_set(${LIBVAR}_FOLDER ${FOLDER})
	if(NOT ${LIBVAR}_FOLDER)
		dk_error("${LIBVAR}_FOLDER is invalid")
	endif()
	dk_verbose(${LIBVAR}_FOLDER	)
	
	dk_set(${LIBVAR}_BRANCH ${branch})
	if(NOT ${LIBVAR}_BRANCH)
		dk_error("${LIBVAR}_BRANCH is invalid")
	endif()
	dk_verbose(${LIBVAR}_BRANCH	)
	
	dk_set(${LIBVAR}_NAME ${FOLDER}-${${LIBVAR}_BRANCH})
	if(NOT ${LIBVAR}_NAME)
		dk_error("${LIBVAR}_NAME is invalid")
	endif()
	dk_verbose(${LIBVAR}_NAME)
	
	dk_set(${LIBVAR} ${DK3RDPARTY_DIR}/${${LIBVAR}_NAME})
	if(NOT ${LIBVAR})
		dk_error("${${LIBVAR}} is invalid")
	endif()
	dk_verbose(${${LIBVAR}})
	
	if(NOT EXISTS ${${LIBVAR}}/.git)
		dk_set(CURRENT_DIR ${DIGITALKNOB_DIR}/${DK3RDPARTY_DIR})
		if(EXISTS ${${LIBVAR}})
			dk_remove(${${LIBVAR}})
		endif()
		if(NOT EXISTS ${${LIBVAR}})
			dk_makeDirectory(${${LIBVAR}})
		endif()
		dk_set(CURRENT_DIR ${${LIBVAR}})
		dk_command(${GIT_EXE} clone ${url} ${${LIBVAR}})
	endif()
	dk_set(CURRENT_DIR ${${LIBVAR}})
	dk_command(${GIT_EXE} checkout -- .)
	dk_command(${GIT_EXE} checkout ${branch} ${id})
	dk_command(${GIT_EXE} pull)
	
	#set(arg_list "${ARGN}")
	#foreach(arg IN LISTS arg_list)
	#	if("${arg}" STREQUAL "PATCH")
	#		dk_patch(${Lib} ${${LIBVAR}})
	#	endif()
	#endforeach()

	if(PATCH)
		dk_patch(${Lib} ${${LIBVAR}})
	endif()	
endfunction()