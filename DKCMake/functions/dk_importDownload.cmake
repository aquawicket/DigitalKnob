include_guard()

###############################################################################
# dk_importDownload(url) install_path PATCH
#
#	TODO
#
#	@url						- TODO
#	@install_path (optional)	- TODO 
#
function(dk_importDownload url) #install_path #PATCH
	DKDEBUGFUNC(${ARGV})
	dk_debug("dk_importDownload(${ARGV})")
	#dk_wait()
	string(REPLACE "/" ";" url_list ${url}) # split into list converting / to divider ;
	#foreach(item ${url_list})
	#	dk_verbose(item)
	#endforeach()
	list(LENGTH url_list url_length)
	#dk_verbose(url_length)
	
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(install_path ${ARGV1})
			dk_verbose(install_path)
		endif()
	endif()
	
	if(${ARGC} GREATER 2)
		if(NOT "${ARGV2}" STREQUAL "PATCH")
			set(tag ${ARGV2})
			dk_verbose(tag)
		endif()
	endif()
	
	dk_verbose(CMAKE_CURRENT_LIST_DIR)
	get_filename_component(Lib ${CMAKE_CURRENT_LIST_DIR} NAME)
	dk_verbose(Lib)
	
	string(TOUPPER ${Lib} LIB)
	dk_set(LIBVAR ${LIB})
	dk_verbose(LIBVAR)
	
	string(TOLOWER ${Lib} FOLDER)
	dk_set(${LIBVAR}_FOLDER ${FOLDER})
	if(NOT ${LIBVAR}_FOLDER)
		dk_error("${LIBVAR}_FOLDER invalid")
	endif()
	dk_verbose(${LIBVAR}_FOLDER)
	
	# check current folder name
	dk_verbose("\${DKIMPORTS_DIR}/\${${LIBVAR}_FOLDER}} = ${DKIMPORTS_DIR}/${${LIBVAR}_FOLDER}}")
	if(NOT "${DKIMPORTS_DIR}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		dk_error("The Imports folder is named inncorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS_DIR}/${${LIBVAR}_FOLDER}}")
	endif()
	
	math(EXPR last "${url_length}-1")
	list(GET url_list ${last} url${last})
	
#	dk_set(${LIBVAR}_DL ${url})
#	dk_removeExtension(${url${last}} tag)
	######### add recognizable file extensions ########## 
	string(FIND ${url${last}} ".7z" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".7z" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".js" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".js" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".tar.bz2" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".tar.bz2" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".tar.gz" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".tar.gz" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".zip" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".zip" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".tar.xz" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".tar.xz" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	######################################################

	if(tag)
		dk_set(${LIBVAR}_BRANCH ${tag})
	endif()
	
	if(FOLDER AND LIBVAR AND ${LIBVAR}_BRANCH)
		dk_set(${LIBVAR}_NAME ${FOLDER}-${${LIBVAR}_BRANCH})
	endif()
	
	if(install_path)
		dk_set(${LIBVAR} ${install_path})
	else()
		dk_set(${LIBVAR} ${DK3RDPARTY_DIR}/${${LIBVAR}_NAME})
	endif()
	
	if(NOT ${LIBVAR})
		dk_error("LIBVAR invalid")
	endif()
	
	if(NOT ${LIBVAR}_BRANCH)
		dk_error("${LIBVAR}_BRANCH invalid")
	endif()
	
	if(NOT ${LIBVAR}_NAME)
		dk_error("${LIBVAR}_NAME invalid")
	endif()
	
	if(NOT ${LIBVAR}_DL)
		dk_error("${LIBVAR}_DL invalid")
	endif()
	
	dk_install(${${LIBVAR}_DL} ${${LIBVAR}} ${${LIBVAR}_FOLDER} ${ARGN})
endfunction()