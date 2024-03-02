# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


###############################################################################
# dk_getGithubDownload(url) #install_path #PATCH
#
#	TODO
#
#	@url	- TODO
#
function(dk_getGithubDownload url) #install_path #Patch
	DKDEBUGFUNC(${ARGV})
	# IS THE URL VALID           Example https://github.com/aquawicket/DigitalKnob/archive/01c17f6a9cd66068f7890ea887ab3b9a673f0434.zip)
	# must contain https://github.com/
	# split into list converting / to divider ;
	string(REPLACE "/" ";" url_list ${url})
	foreach(item ${url_list})
		dk_debug(item)
	endforeach()

	list(LENGTH url_list url_length)
	dk_debug(url_length)
	
	if(${url_length} LESS 5)
		dk_error("url_list doesn't contain enough elements to have a 'orginization/library'")
		return()
	endif()	
	
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(install_path ${ARGV1})
			dk_debug(install_path)
		endif()
	endif()
	
	if(${ARGC} GREATER 2)
		if(NOT "${ARGV2}" STREQUAL "PATCH")
			set(tag ${ARGV2})
			dk_debug(tag)
		endif()
	endif()
	
	if(NOT Lib)
		dk_debug(CMAKE_CURRENT_LIST_DIR)
		get_filename_component(Lib ${CMAKE_CURRENT_LIST_DIR} NAME)
		dk_debug(Lib)
		
		string(FIND ${url} "github.com" includes)
		if(${includes} EQUAL -1)
			string(FIND ${url} "gitlab.com" includes)
			if(${includes} EQUAL -1)
				dk_error("Lib invalid and The url does not contain 'github.com' OR 'gitlab.com'")
				return()
			endif()
		endif()
		list(GET url_list 3 org)
		dk_debug(org)
		list(GET url_list 4 Lib)
		dk_debug(Lib)
	endif()
	
	string(TOUPPER ${Lib} LIB)
	dk_set(LIBVAR ${LIB})
	dk_debug(LIBVAR)
	
	string(TOLOWER ${Lib} FOLDER)
	dk_set(${LIBVAR}_FOLDER ${FOLDER})
	if(NOT ${LIBVAR}_FOLDER)
		dk_error("${LIBVAR}_FOLDER invalid")
	endif()
	dk_debug(${LIBVAR}_FOLDER)
	
	# check current folder name
	dk_debug("\${DKIMPORTS_DIR}/\${${LIBVAR}_FOLDER}} = ${DKIMPORTS_DIR}/${${LIBVAR}_FOLDER}}")
	if(NOT "${DKIMPORTS_DIR}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		dk_error("The Imports folder is named inncorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS_DIR}/${${LIBVAR}_FOLDER}}")
	endif()
	
	math(EXPR last "${url_length}-1")
	list(GET url_list ${last} url${last})
	
	######### add recognizable file extensions ########## 
	string(FIND ${url${last}} ".7z" index)
	if(${index} GREATER -1)
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	
	string(FIND ${url${last}} ".js" index)
	if(${index} GREATER -1)
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	
	string(FIND ${url${last}} ".tar.bz2" index)
	if(${index} GREATER -1)
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	
	string(FIND ${url${last}} ".tar.gz" index)
	if(${index} GREATER -1)
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()

	string(FIND ${url${last}} ".zip" index)
	if(${index} GREATER -1)
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()

	
	
	if(NOT ${LIBVAR}_DL)
		string(FIND ${url} "github.com" includes)
		if(${includes} EQUAL -1)
			string(FIND ${url} "gitlab.com" includes)
			if(${includes} EQUAL -1)
				dk_error("The url is not a 'github.com' address")
				return()
			endif()
		endif()
		
		dk_error("The url doesn't end in .zip or .tar.gz")
		dk_info("We will try to get the master commit id from the page")
		dk_download(${url} ${DKDOWNLOAD_DIR}/TEMP/${FOLDER}.html)
		file(READ ${DKDOWNLOAD_DIR}/TEMP/${FOLDER}.html PAGE)
		file(REMOVE ${DKDOWNLOAD_DIR}/TEMP/${FOLDER}.html)
		string(FIND "${PAGE}" "spoofed_commit_check" index)
		if(${index} EQUAL -1)
			dk_error("The page doesn't contain a 'spoofed_commit_check' variable")
			return()
		endif()
		math(EXPR value "${index} + 21") #OUTPUT_FORMAT DECIMAL) # CMake 3.13+
		string(SUBSTRING "${PAGE}" ${value} 40 tag)
		set(ZIP ${tag}.zip)
		string(SUBSTRING ${ZIP} 0 7 TAG)
		dk_set(${LIBVAR}_DL https://github.com/${org}/${Lib}/archive/${ZIP})
		dk_debug(tag)
		
		## update DKMAKE.cmake file
		dk_copy(${CMAKE_CURRENT_LIST_FILE} ${CMAKE_CURRENT_LIST_FILE}.BACKUP TRUE)
		file(READ ${CMAKE_CURRENT_LIST_FILE} DKMAKE_FILE)
		string(REPLACE "dk_import(${url})" "#dk_import(${url})\ndk_import(${${LIBVAR}_DL})" DKMAKE_FILE ${DKMAKE_FILE})
		string(REPLACE "dk_import(${url} PATCH)" "#dk_import(${url} PATCH)\ndk_import(${${LIBVAR}_DL} PATCH)" DKMAKE_FILE ${DKMAKE_FILE})
       file(WRITE ${CMAKE_CURRENT_LIST_FILE} ${DKMAKE_FILE})
	endif()
	
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
		dk_error("${LIBVAR} invalid")
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