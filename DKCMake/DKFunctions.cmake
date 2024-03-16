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

# Extra Documentation
# https://asitdhal.medium.com/cmake-functions-and-macros-22293041519f
# https://foonathan.net/2016/03/cmake-install/ 

dk_load(dk_sleep)
dk_load(dk_get_option)
dk_load(DK)
dk_load(dk_call)
dk_load(dk_listReplace)
dk_load(dk_getArgIdentifiers)
dk_load(dk_debugFunc)
dk_load(dk_updateLogInfo)
dk_load(DKASSERT)
dk_load(dk_printvar)
dk_load(dk_error)
dk_load(dk_warn)
dk_load(dk_info)
dk_load(dk_debug)
dk_load(dk_verbose)
dk_load(dk_trace)
dk_load(dk_todo)
dk_load(dk_pad)
dk_load(dk_includes)
dk_load(dk_getParameter)
dk_load(dk_remove)

###############################################################################
# dk_createOsMacros(func)
#
#	Prefix a function with <OS>_ macros. Calling the <OS>_function will only be called if the current <OS> or <OS_HOST> is true
#
#	@func	- The func of the function to create aliases for
#
function(dk_createOsMacros func)
	DKDEBUGFUNC(${ARGV})
	if(NOT EXISTS ${DKFunctions_ext})
		file(APPEND ${DKFunctions_ext} "### Don't make changes in this file. They will be overwritten. ###\n")
		file(APPEND ${DKFunctions_ext} "### This file was automatically generated from DKFunctions.cmake ###\n")
	endif()
	file(APPEND ${DKFunctions_ext} "\n## ${func} ##\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_HOST_${func})\n   if(WIN_HOST)\n      ${func}(\${ARGV})\n  endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_HOST_${func})\n   if(WIN_HOST AND X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_64_HOST_${func})\n   if(WIN_HOST AND X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_HOST_${func})\n   if(UNIX_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_HOST_${func})\n   if(MAC_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_HOST_${func})\n   if(MAC_HOST AND X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_64_HOST_${func})\n   if(MAC_HOST AND X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_HOST_${func})\n   if(LINUX_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_HOST_${func})\n   if(LINUX_HOST AND X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_64_HOST_${func})\n   if(LINUX_HOST AND X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_HOST_${func})\n   if(ANDROID_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	
	file(APPEND ${DKFunctions_ext} "macro(WIN_${func})\n   if(WIN)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_${func})\n   if(WIN_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_64_${func})\n   if(WIN_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_${func})\n   if(NOT WIN)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE_${func})\n   if(MAC OR IOS OR IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE32_${func})\n   if(MAC_X86 OR IOS_ARM32 OR IOSSIM_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE64_${func})\n   if(MAC_X86_64 OR IOS_ARM64 OR IOSSIM_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_${func})\n   if(MAC)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_${func})\n   if(MAC_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_64_${func})\n   if(MAC_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_${func})\n   if(IOS AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM32_${func})\n   if(IOS_ARM32 AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM64_${func})\n   if(IOS_ARM64 AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_${func})\n   if(IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_${func})\n   if(IOSSIM_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_64_${func})\n   if(IOSSIM_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_${func})\n   if(LINUX)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_${func})\n   if(LINUX_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_64_${func})\n   if(LINUX_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_${func})\n   if(RASPBERRY)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM32_${func})\n   if(RASPBERRY_ARM32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM64_${func})\n   if(RASPBERRY_ARM64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_${func})\n   if(ANDROID)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM32_${func})\n   if(ANDROID_ARM32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM64_${func})\n   if(ANDROID_ARM64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(EMSCRIPTEN_${func})\n   if(EMSCRIPTEN)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	
	if("${ARGN}" STREQUAL "NO_DEBUG_RELEASE_TAGS")
		return()
	endif()
	file(APPEND ${DKFunctions_ext} "macro(DEBUG_${func})\n   if(DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_DEBUG_${func})\n   if(WIN AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_DEBUG_${func})\n   if(WIN_X86 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_64_DEBUG_${func})\n   if(WIN_X86_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_DEBUG_${func})\n   if(NOT WIN AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE_DEBUG_${func})\n   if(MAC OR IOS OR IOSSIM AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_DEBUG_${func})\n   if(MAC AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_DEBUG_${func})\n   if(MAC_X86 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_64_DEBUG_${func})\n   if(MAC_X86_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_DEBUG_${func})\n   if(IOS AND DEBUG AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM32_DEBUG_${func})\n   if(IOS_ARM32 AND DEBUG AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM64_DEBUG_${func})\n   if(IOS_ARM64 AND DEBUG AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_DEBUG_${func})\n   if(IOSSIM AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_DEBUG_${func})\n   if(IOSSIM_X86 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_64_DEBUG_${func})\n   if(IOSSIM_X86_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_DEBUG_${func})\n   if(LINUX AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_DEBUG_${func})\n   if(LINUX_X86 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_64_DEBUG_${func})\n   if(LINUX_X86_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_DEBUG_${func})\n   if(RASPBERRY AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM32_DEBUG_${func})\n   if(RASPBERRY_ARM32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM64_DEBUG_${func})\n   if(RASPBERRY_ARM64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_DEBUG_${func})\n   if(ANDROID AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM32_DEBUG_${func})\n   if(ANDROID_ARM32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM64_DEBUG_${func})\n   if(ANDROID_ARM64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(EMSCRIPTEN_DEBUG_${func})\n   if(EMSCRIPTEN AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	
	file(APPEND ${DKFunctions_ext} "macro(RELEASE_${func})\n   if(RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_RELEASE_${func})\n   if(WIN AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_RELEASE_${func})\n   if(WIN_X86 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_64_RELEASE_${func})\n   if(WIN_X86_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_RELEASE_${func})\n   if(NOT WIN AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE_RELEASE_${func})\n   if(MAC OR IOS OR IOSSIM AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_RELEASE_${func})\n   if(MAC AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_RELEASE_${func})\n   if(MAC_X86 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_64_RELEASE_${func})\n   if(MAC_X86_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_RELEASE_${func})\n   if(IOS AND RELEASE AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM32_RELEASE_${func})\n   if(IOS_ARM32 AND RELEASE AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM64_RELEASE_${func})\n   if(IOS_ARM64 AND RELEASE AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_RELEASE_${func})\n   if(IOSSIM AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_RELEASE_${func})\n   if(IOSSIM_X86 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_64_RELEASE_${func})\n   if(IOSSIM_X86_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_RELEASE_${func})\n   if(LINUX AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_RELEASE_${func})\n   if(LINUX_X86 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_64_RELEASE_${func})\n   if(LINUX_X86_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_RELEASE_${func})\n   if(RASPBERRY AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM32_RELEASE_${func})\n   if(RASPBERRY_ARM32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM64_RELEASE_${func})\n   if(RASPBERRY_ARM64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_RELEASE_${func})\n   if(ANDROID AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM32_RELEASE_${func})\n   if(ANDROID_ARM32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM64_RELEASE_${func})\n   if(ANDROID_ARM64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(EMSCRIPTEN_RELEASE_${func})\n   if(EMSCRIPTEN AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
endfunction()
set(dk_disabled_list ""	CACHE INTERNAL "")
set(DKFunctions_ext ${DKCMAKE_DIR}/DKFunctions_ext.cmake)
dk_remove(${DKFunctions_ext} NOERROR)

dk_load(dk_return)
dk_load(dk_printAllVariables)
dk_load(dk_set)
dk_load(dk_append)
dk_load(dk_unset)
dk_load(dk_exit)
dk_load(dk_isNumber)
dk_load(dk_wait)
dk_load(dk_dump)
dk_load(dk_watch)
dk_load(dk_watchCallback)
dk_load(dk_setXcodeProperty)
dk_load(dk_deleteCache)
dk_load(dk_deleteTempFiles)
dk_load(dk_deleteEmptyDirectories)
dk_load(dk_getEnv)
dk_load(dk_download)
dk_load(dk_extract)
dk_load(dk_zip)
dk_load(dk_copy)
dk_load(dk_filesMatch)
dk_load(dk_rename)
dk_load(dk_upxCompress)
dk_load(dk_enable)
dk_load(dk_disable)
dk_load(dk_define)
dk_load(dk_undefine)
dk_load(dk_include)
dk_load(dk_linkDir)
dk_load(dk_getCurrentDirectory)
dk_load(dk_makeDirectory)
dk_load(dk_getDirectory)
dk_load(dk_getFilename)
dk_load(dk_getExtension)
dk_load(dk_dirIsEmpty)
dk_load(dk_refreshIcons)
dk_load(dk_patch)
dk_load(dk_install)
dk_load(dk_validatePath)
dk_load(dk_getShortPath)
dk_load(dk_print_prefix_vars)
dk_load(dk_get_option_value)
dk_load(dk_get_option_values)
dk_load(dk_executeProcess)
dk_load(dk_setEnv)
dk_load(dk_setPath)
dk_load(dk_bash)
dk_load(dk_queueBash)
dk_load(dk_msys2)
dk_load(dk_msys2_bash)
dk_load(dk_mergeFlags)
dk_load(dk_command)
dk_load(dk_queueCommand)
dk_load(dk_visualStudioDebug)
dk_load(dk_visualStudioRelease)
dk_load(dk_visualStudioRelease)
dk_load(dk_xcodeDebug)
dk_load(dk_xcodeRelease)
dk_load(dk_xcode)
dk_load(dk_ndkDebug)
dk_load(dk_ndkRelease)
dk_load(dk_ndk)
dk_load(dk_make)
dk_load(dk_build)
dk_load(dk_lib)
dk_load(dk_libDebug)
dk_load(dk_libRelease)
dk_load(dk_generateCmake)
dk_load(dk_dll)
dk_load(dk_executable)
dk_load(dk_testApp)
dk_load(dk_addToPluginList)
dk_load(dk_appendCmake)

SET(ASSETS 
	PATTERN *.h EXCLUDE
	PATTERN *.c EXCLUDE
	PATTERN *.cmake EXCLUDE
	PATTERN *.cpp EXCLUDE
	PATTERN *.dir EXCLUDE
	PATTERN *.filters EXCLUDE
	PATTERN *.lib EXCLUDE
	PATTERN *.manifest EXCLUDE
	PATTERN *.mm EXCLUDE
	PATTERN *.pdb EXCLUDE
	PATTERN *.plist EXCLUDE
	PATTERN *.rc EXCLUDE
	PATTERN *.sln EXCLUDE
	PATTERN *.tmp EXCLUDE
	PATTERN *.TMP EXCLUDE
	PATTERN *.temp EXCLUDE
	PATTERN *.TEMP EXCLUDE
	PATTERN *.vcxproj EXCLUDE
	PATTERN CMakeFiles EXCLUDE
	PATTERN CMakeLists.txt EXCLUDE
	PATTERN temp.txt EXCLUDE
	PATTERN win_x86 EXCLUDE
	PATTERN win_x86_64 EXCLUDE
	PATTERN mac_x86 EXCLUDE
	PATTERN mac_x86_64 EXCLUDE
	PATTERN ios_arm32 EXCLUDE
	PATTERN ios_arm64 EXCLUDE
	PATTERN iossim_x86 EXCLUDE
	PATTERN iossim_x86_64 EXCLUDE
	PATTERN linux_x86 EXCLUDE
	PATTERN linux_x86_64 EXCLUDE
	PATTERN android_arm32 EXCLUDE
	PATTERN android_arm64 EXCLUDE
	PATTERN raspberry_arm32 EXCLUDE
	PATTERN raspberry_arm64 EXCLUDE
	PATTERN emscripten EXCLUDE
	PATTERN dktest EXCLUDE)

dk_load(dk_assets)
dk_load(dk_getPathToPlugin)
dk_load(dk_depend)
dk_load(dk_undepend)
dk_load(dk_runDepends)
dk_load(dk_require)
dk_load(dk_dependAll)
dk_load(dk_fileReplace)


###############################################################################
# dk_updateAndroidName(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateAndroidName app_name)
	DKDEBUGFUNC(${ARGV})
	string(TOLOWER ${app_name} app_name)
	if(ANDROID)
		# update all files and folders recursivley
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${DK_PROJECT_DIR}/${OS}/" "${DK_PROJECT_DIR}/${OS}/*")
		dk_verbose("Getting a list of files in ${DK_PROJECT_DIR}/${OS}")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			dk_verbose(each_file	PRINTVAR)
			set(filepath "${DK_PROJECT_DIR}/${OS}/${each_file}")
			if(NOT IS_DIRECTORY ${filepath})
				string(FIND "${each_file}" "opendb" indexD)
				if(${indexD} GREATER -1)
				#dk_includes( "${each_file}" "opendb" includes_A)
				#if(${includes_A})
					continue()
				endif()
				string(FIND "${each_file}" ".log" indexD)
				if(${indexD} GREATER -1)
				#dk_includes("${each_file}" ".log" includes_B)
				#if(${includes_B})
					continue()
				endif()
				file(READ ${filepath} filestring)
				string(FIND "${filestring}" "dkapp" index)
				if(${index} GREATER -1)
				#dk_includes("${filestring}" "dkapp" includes_C)
				#if(${includes_C})
					dk_info("Replacing 'dkapp' with '${app_name}' in ${filepath}")
					string(REPLACE "dkapp" "${app_name}" filestring "${filestring}")
					file(WRITE ${filepath} "${filestring}")
				endif()
			endif()
			get_filename_component(fname ${each_file} NAME)
			string(FIND "${fname}" "dkapp" indexB)
			if(${indexB} GREATER -1)
			#dk_includes("${fname}" "dkapp" includes_D)
			#if(${includes_D})
				set(new_name ${each_file})
				string(REPLACE "dkapp" "${app_name}" new_name "${new_name}")
				dk_info("Renaming ${each_file} to ${new_name}")
				dk_rename(${DK_PROJECT_DIR}/${OS}/${each_file} ${DK_PROJECT_DIR}/${OS}/${new_name} OVERWRITE)
			endif()
		endforeach()
	endif()
endfunction()


###############################################################################
# dk_updateInfoPlist(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateInfoPlist app_name)
	DKDEBUGFUNC(${ARGV})
	if(MAC)
		# FIXME
		dk_info("Updating MAC info.plist . . .")
		if(DEBUG)
			if(EXISTS ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
			endif()	
		endif()
	endif()
	if(IOS OR IOSSIM)
		dk_info("Updating IOS Info.plist . . .")
		dk_info("CHECKING FOR... ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist")
		if(EXISTS ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist)
			dk_info("Updating IOS Debug Info.plist . . .")
			file(READ ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist plist)
			string(REPLACE "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist ${plist})
			file(WRITE "${plist}" ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist)
		endif()
	endif()
endfunction()


###############################################################################
# dk_buildLog(entry) PRINTVAR
#
#	TODO
#
#	@entry			- TODO
#	@PRINTVAR	- TODO
#
function(dk_buildLog entry)
	DKDEBUGFUNC(${ARGV})
	
	dk_get_option(PRINTVAR ${ARGV})
	dk_printvar(entry)
	
	dk_info("${entry}")
	
	file(APPEND ${DK_PROJECT_DIR}/${BUILD_DIR}/DKBUILD.log "${entry}\n")
endfunction()


###############################################################################
# dk_addSource(regex)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_addSource regex)
	DKDEBUGFUNC(${ARGV})
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${ARGV})
endfunction()


###############################################################################
# dk_removeSource(regex)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_removeSource regex)
	DKDEBUGFUNC(${ARGV})
	dk_set(SRC_EXCLUDE ${SRC_EXCLUDE} ${ARGV})
endfunction()

###############################################################################
# dk_wrapString()
#
#	Function to wrap a given string into multiple lines at the given column position.
#
#	@VARIABLE	- The name of the CMake variable holding the string.
#	@AT_COLUMN	- The column position at which string will be wrapped.
#
function(dk_wrapString)
	DKDEBUGFUNC(${ARGV})
	set(oneValueArgs VARIABLE AT_COLUMN)
	cmake_parse_arguments(dk_wrapString "${options}" "${oneValueArgs}" "" ${ARGN})
    string(LENGTH ${${DK_WRAPSTRING_VARIABLE}} stringLength)
    math(EXPR offset "0")
    while(stringLength GREATER 0)
        if(stringLength GREATER ${DK_WRAPSTRING_AT_COLUMN})
            math(EXPR length "${DK_WRAPSTRING_AT_COLUMN}")
        else()
            math(EXPR length "${stringLength}")
        endif()
        string(SUBSTRING ${${DK_WRAPSTRING_VARIABLE}} ${offset} ${length} line)
        set(lines "${lines}\n${line}")
        math(EXPR stringLength "${stringLength} - ${length}")
        math(EXPR offset "${offset} + ${length}")
    endwhile()
    set(${DK_WRAPSTRING_VARIABLE} "${lines}" PARENT_SCOPE)
endfunction()


###############################################################################
# dk_bin2h(SOURCE_FILE arg1 HEADER_FILE arg2 VARIABLE_NAME arg3)
#
#	https://gist.github.com/sivachandran/3a0de157dccef822a230#file-bin2h-cmake
#	Function to embed contents of a file as byte array in C/C++ header file(.h). The header file
#	will contain a byte array and integer variable holding the size of the array.
#	
#	@SOURCE_FILE     - The path of source file whose contents will be embedded in the header file.
#   @VARIABLE_NAME   - The name of the variable for the byte array. The string "_SIZE" will be append
#                      to this name and will be used a variable name for size variable.
#   @HEADER_FILE     - The path of header file.
#   @APPEND          - If specified appends to the header file instead of overwriting it
#   @NULL_TERMINATE  - If specified a null byte(zero) will be append to the byte array. This will be
#                      useful if the source file is a text file and we want to use the file contents
#                      as string. But the size variable holds size of the byte array without this
#                      null byte.
#	Usage:
#		dk_bin2h(SOURCE_FILE "Logo.png" HEADER_FILE "Logo.h" VARIABLE_NAME "LOGO_PNG")
#
function(dk_bin2h)
	DKDEBUGFUNC(${ARGV})
    set(options APPEND NULL_TERMINATE)
    set(oneValueArgs SOURCE_FILE VARIABLE_NAME HEADER_FILE)
    cmake_parse_arguments(dk_bin2h "${options}" "${oneValueArgs}" "" ${ARGN})
    # reads source file contents as hex string
    file(READ ${DK_BIN2H_SOURCE_FILE} hexString HEX)
    string(LENGTH ${hexString} hexStringLength)
    # appends null byte if asked
    if(DK_BIN2H_NULL_TERMINATE)
        set(hexString "${hexString}00")
    endif()
    # wraps the hex string into multiple lines at column 32(i.e. 16 bytes per line)
#	dk_wrapString(VARIABLE hexString AT_COLUMN 32)
    math(EXPR arraySize "${hexStringLength} / 2")
    # adds '0x' prefix and comma suffix before and after every byte respectively
#	string(REGEX REPLACE "([0-9a-f][0-9a-f])" "\\1" arrayValues ${hexString})
    # removes trailing comma
#	string(REGEX REPLACE ", $" "" arrayValues ${arrayValues})
    # converts the variable name into proper C identifier
    string(MAKE_C_IDENTIFIER "${DK_BIN2H_VARIABLE_NAME}" DK_BIN2H_VARIABLE_NAME)
    string(TOUPPER "${DK_BIN2H_VARIABLE_NAME}" DK_BIN2H_VARIABLE_NAME)
    # declares byte array and the length variables
    set(arrayDefinition "std::string ${DK_BIN2H_VARIABLE_NAME} = \"${hexString}\";")
    set(arraySizeDefinition "size_t ${DK_BIN2H_VARIABLE_NAME}_SIZE = ${arraySize};")
    set(declarations "${arrayDefinition}\n\n${arraySizeDefinition}\n\n")
    if(DK_BIN2H_APPEND)
        file(APPEND ${DK_BIN2H_HEADER_FILE} "${declarations}")
    else()
        file(WRITE ${DK_BIN2H_HEADER_FILE} "${declarations}")
    endif()
endfunction()


###############################################################################
# dk_getCmakeCommandLine(RESULT)
#	
#	TODO
#
#	@RESULT			- TODO
#
function(dk_getCmakeCommandLine RESULT)
	DKDEBUGFUNC(${ARGV})
	if(NOT CMAKE_ARGC)
		dk_info("dk_getCmakeCommandLine(): CMAKE_ARGC not set")
		dk_info("CMAKE_ARG variables are only set in cmake script mode")
		return()
	endif()
	
	set(PASSED_PARAMETERS "") # it will contain all params string
	set(ARG_NUM 1) # current index, starting with 1 (0 ignored)
	#math(EXPR ARGC_COUNT "${CMAKE_ARGC}")
	set(ARGC_COUNT "${CMAKE_ARGC}")
	
	while(ARG_NUM LESS ARGC_COUNT)	
		set(CURRENT_ARG ${CMAKE_ARGV${ARG_NUM}})					# making current arg named "CMAKE_ARGV" + "CURRENT_INDEX"
		set(PASSED_PARAMETERS ${PASSED_PARAMETERS} ${CURRENT_ARG})  # adding current param to the list
		math(EXPR ARG_NUM "${ARG_NUM}+1") 							# incrementing current index
	endwhile()
	
	dk_debug(PASSED_PARAMETERS	PRINTVAR)
	dk_wait()
	
	set(${RESULT} "${PASSED_PARAMETERS}" PARENT_SCOPE) #return RESULT
endfunction()

###############################################################################
# dk_printSettings()
#
#	TODO
#
#	https://cmake.org/cmake/help/latest/manual/cmake-variables.7.html
#
function(dk_printSettings)
	DKDEBUGFUNC(${ARGV})
	
	dk_buildLog("#############  DigitalKnob  ############")
	dk_buildLog(DKBRANCH						PRINTVAR)
	dk_buildLog(DIGITALKNOB_DIR					PRINTVAR)
	dk_buildLog(DKTOOLS_DIR						PRINTVAR)
	dk_buildLog(DKBRANCH_DIR					PRINTVAR)
	dk_buildLog(DK3RDPARTY_DIR					PRINTVAR)
	dk_buildLog(DKIMPORTS_DIR					PRINTVAR)
	dk_buildLog(DKAPPS_DIR						PRINTVAR)
	dk_buildLog(DKPLUGINS_DIR					PRINTVAR)
	dk_buildLog(BUILD_DIR						PRINTVAR)
	
	dk_buildLog("#################  CMAKE VARIABLES  ################")
	#dk_getCmakeCommandLine(CMAKE_COMMAND_LINE)
	dk_buildLog(CMAKE_COMMAND_LINE				PRINTVAR)
	dk_buildLog(CMAKE_COMMAND					PRINTVAR)
	dk_buildLog(CMAKE_EXE						PRINTVAR)
	dk_buildLog(CMAKE_VERSION					PRINTVAR)
	
	dk_buildLog("#################  HOST VARIABLES  ################")
	dk_buildLog(CMAKE_HOST_SYSTEM_NAME			PRINTVAR)
	dk_buildLog(CMAKE_HOST_SYSTEM_VERSION		PRINTVAR)
	dk_buildLog(CMAKE_HOST_SYSTEM_PROCESSOR   	PRINTVAR)
	dk_buildLog(CMAKE_LIBRARY_ARCHITECTURE    	PRINTVAR)
	dk_buildLog(CMAKE_CPP_COMPILER_ID         	PRINTVAR)
	dk_buildLog(CMAKE_CXX_COMPILER_ID         	PRINTVAR)
	dk_buildLog(ENV{USERNAME}                 	PRINTVAR)
	dk_buildLog(ENV{USER}						PRINTVAR)
	#dk_buildLog(ENV{PATH}						PRINTVAR)
	execute_process(COMMAND uname OUTPUT_VARIABLE UNAME OUTPUT_STRIP_TRAILING_WHITESPACE)
	dk_buildLog(UNAME							PRINTVAR)
	dk_buildLog(MINGW							PRINTVAR)
	dk_buildLog(MSYS							PRINTVAR)
	dk_buildLog(MSVC							PRINTVAR)
	#dk_buildLog(VISUAL_STUDIO					PRINTVAR)
	dk_buildLog(XCODE							PRINTVAR)
	
	dk_buildLog("#################  TARGET VARIABLES  ################")
	dk_buildLog(CMAKE_SYSTEM					PRINTVAR)
	dk_buildLog(CMAKE_SYSTEM_NAME				PRINTVAR)
	dk_buildLog(CMAKE_BINARY_DIR				PRINTVAR)
	dk_buildLog(CMAKE_ARCHIVE_OUTPUT_DIRECTORY	PRINTVAR)
	dk_buildLog(CMAKE_LIBRARY_OUTPUT_DIRECTORY	PRINTVAR)
	dk_buildLog(CMAKE_RUNTIME_OUTPUT_DIRECTORY	PRINTVAR)
	dk_buildLog(CMAKE_GENERATOR					PRINTVAR)
	dk_buildLog(CMAKE_MAKE_PROGRAM				PRINTVAR)
	dk_buildLog(CMAKE_C_COMPILER				PRINTVAR)
	dk_buildLog(CMAKE_C_STANDARD				PRINTVAR)
	dk_buildLog(CMAKE_C_STANDARD_REQUIRED		PRINTVAR)
	dk_buildLog(CMAKE_C_EXTENSIONS				PRINTVAR)
	dk_buildLog(CMAKE_C_FLAGS					PRINTVAR)
	dk_buildLog(CMAKE_C_FLAGS_DEBUG				PRINTVAR)
	dk_buildLog(CMAKE_C_FLAGS_RELEASE			PRINTVAR)
	dk_buildLog(CMAKE_CXX_COMPILER				PRINTVAR)
	dk_buildLog(CMAKE_CXX_STANDARD				PRINTVAR)
	dk_buildLog(CMAKE_CXX_STANDARD_REQUIRED		PRINTVAR)
	dk_buildLog(CMAKE_CXX_EXTENSIONS			PRINTVAR)
	dk_buildLog(CMAKE_CXX_FLAGS					PRINTVAR)
	dk_buildLog(CMAKE_CXX_FLAGS_DEBUG			PRINTVAR)
	dk_buildLog(CMAKE_CXX_FLAGS_RELEASE			PRINTVAR)
	dk_buildLog(MULTI_CONFIG					PRINTVAR)
	dk_buildLog(SINGLE_CONFIG					PRINTVAR)
	dk_buildLog(APP_NAME						PRINTVAR)
	dk_buildLog(DK_PROJECT_DIR					PRINTVAR)
	dk_buildLog(DEBUG_DIR						PRINTVAR)
	dk_buildLog(RELEASE_DIR						PRINTVAR)
	dk_buildLog(VS_STARTUP_PROJECT				PRINTVAR)
	dk_buildLog(OS								PRINTVAR)
	dk_buildLog(DEBUG							PRINTVAR)
	dk_buildLog(RELEASE							PRINTVAR)
	dk_buildLog(BUILD							PRINTVAR)
	dk_buildLog(REBUILD							PRINTVAR)
	dk_buildLog(REBUILDALL						PRINTVAR)
	dk_buildLog(DKCEF							PRINTVAR)
	dk_buildLog(WIN								PRINTVAR)
	dk_buildLog(WIN_X86							PRINTVAR)
	dk_buildLog(WIN_X86_64						PRINTVAR)
	dk_buildLog(MAC								PRINTVAR)
	dk_buildLog(MAC_X86							PRINTVAR)
	dk_buildLog(MAC_X86_64						PRINTVAR)
	dk_buildLog(IOS								PRINTVAR)
	dk_buildLog(IOS_ARM32						PRINTVAR)
	dk_buildLog(IOS_ARM64						PRINTVAR)
	dk_buildLog(IOSSIM							PRINTVAR)
	dk_buildLog(IOSSIM_X86						PRINTVAR)
	dk_buildLog(IOSSIM_X86_64					PRINTVAR)
	dk_buildLog(LINUX							PRINTVAR)
	dk_buildLog(LINUX_X86						PRINTVAR)
	dk_buildLog(LINUX_X86_64					PRINTVAR)
	dk_buildLog(ANDROID							PRINTVAR)
	dk_buildLog(ANDROID_ARM32					PRINTVAR)
	dk_buildLog(ANDROID_ARM64					PRINTVAR)
	dk_buildLog(RASPBERRY						PRINTVAR)
	dk_buildLog(RASPBERRY_ARM32					PRINTVAR)
	dk_buildLog(RASPBERRY_ARM64					PRINTVAR)
	dk_buildLog(EMSCRIPTEN						PRINTVAR)
	dk_buildLog("")
endfunction()


###############################################################################
# dk_addTarget(plugin target)
#
#	TODO
#
#	@plugin		- TODO
#	@target		- TODO
#
function(dk_addTarget plugin target)
	DKDEBUGFUNC(${ARGV})
	dk_verbose("dk_addTarget( ${ARGV} )")
	if(${plugin}_targets_OFF)
		list(REMOVE_ITEM ${plugin}_targets_OFF ${target})
	endif()
	if(${plugin}_targets)
		dk_set(${plugin}_targets ${${plugin}_targets} ${target})
	else()
		dk_set(${plugin}_targets ${target})
	endif()
	if(${plugin}_all)
		dk_set(${plugin}_${target} ON)
		#dk_set(${plugin}::${target} ON) # TESTME
	endif()
endfunction()


###############################################################################
# dk_removeTarget(plugin target)
#
#	TODO
#
#	@plugin		- TODO
#	@target		- TODO
#
function(dk_removeTarget plugin target)
	DKDEBUGFUNC(${ARGV})
	dk_verbose("dk_removeTarget( ${ARGV} )")
	if(${plugin}_targets)
		list(REMOVE_ITEM ${plugin}_targets ${target})
	endif()
	if(${plugin}_targets_OFF)
		dk_set(${plugin}_targets_OFF ${${plugin}_targets_OFF} ${target})
	else()
		dk_set(${plugin}_targets_OFF ${target})
	endif()
	dk_set(${plugin}_${target} 0)
	dk_unset(${plugin}_${target})
	#dk_unset(${plugin}::${target}) # TESTME
endfunction()


###############################################################################
# dk_createSmartObject(object)
#
#	TODO
#	We can scan each plugin and attempt to create it's variable and infomation manually here
#
#	@object		- TODO
#
function(dk_createSmartObject object)
	DKDEBUGFUNC(${ARGV})
	dk_todo()
	dk_verbose("dk_createSmartObject(${object})")
	# We require something that can resolve to a full, valid path containing a DKMAKE.cmake file 
endfunction()


###############################################################################
# dk_log(args)
#
#	A simple, quick and easy logger
#
#	@args		- TODO
#
function(dk_log args)
	DKDEBUGFUNC(${ARGV})
	dk_verbose(ARGV		PRINTVAR)
	set(output " ")
	foreach(arg ${ARGV})
		if(DEFINED ${arg})
			set(output "${output} ${arg}=${${arg}} ")
		else()
			set(output "${output} ${arg}")
		endif()
			dk_info(output	PRINTVAR)
	endforeach()
	dk_wait()
endfunction()


###############################################################################
# dk_removeSubstring(removethis fromthis RESULT)
#
#	TODO
#
#	@removethis		- TODO
#	@fromthis		- TODO
#	@RESULT			- TODO
#
function(dk_removeSubstring removethis fromthis RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_dump(removethis)
	dk_dump(fromthis)
	#foreach(item ${fromthis})
	#	string(REPLACE ${removethis} "" item ${item})
	#	list(APPEND rtn ${item})
	#endforeach()
	string(REPLACE ${removethis} "" rtn "${fromthis}")
	string(REPLACE "  " " " rtn "${rtn}") #replace doube spaces with single space
	set(${RESULT} "${rtn}" PARENT_SCOPE) #return RESULT
	dk_dump(rtn)
	#dk_wait()
endfunction()
dk_createOsMacros("dk_removeSubstring")


###############################################################################
# dk_findTarget(target RESULT_PATH RESULT_TYPE)
#
#	TODO
#
#	@target			- TODO
#	@RESULT_PATH	- TODO
#	@RESULT_TYPE	- TODO
#
function(dk_findTarget target RESULT_PATH RESULT_TYPE)
	DKDEBUGFUNC(${ARGV})
	## search up to 4 levels deep
	file(GLOB children RELATIVE ${DIGITALKNOB_DIR}/ 
		${DIGITALKNOB_DIR}/${target}/DKMAKE.cmake 
		${DIGITALKNOB_DIR}/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB_DIR}/**/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB_DIR}/**/**/**/${target}/DKMAKE.cmake
		${DIGITALKNOB_DIR}/**/**/**/**/${target}/DKMAKE.cmake)
	foreach(child ${children})
		dk_info("FOUND: ${DIGITALKNOB_DIR}/${child}")
		string(REPLACE "/DKMAKE.cmake" "" path ${DIGITALKNOB_DIR}/${child})
		set(${RESULT_PATH} ${path} PARENT_SCOPE)
		
		file(STRINGS ${path}/DKMAKE.cmake dkmake_string)
		string(FIND "${dkmake_string}" "DKAPP" index)
		if(${index} GREATER -1)
		#dk_includes("${dkmake_string}" "DKAPP" index)
		#if(${index})
			set(${RESULT_TYPE} APP PARENT_SCOPE) 
		else()
			set(${RESULT_TYPE} LIBRARY PARENT_SCOPE)	#LIBRARY is default, we need to label executables to detect them
		endif()
		return()
	endforeach()
endfunction()


###############################################################################
# dk_setReadOnly(VAR)
#
#	TODO
#
#	@VAR	- TODO
#	 
macro(dk_setReadOnly VAR)
	DKDEBUGFUNC(${ARGV})
	set("${VAR}" "${ARGN}")						# Set the variable itself
	set("_${VAR}_readonly_val" "${ARGN}")		# Store the variable's value for restore it upon modifications.
	variable_watch("${VAR}" dk_readOnlyCallback)	# Register a watcher for a variable
endmacro()


###############################################################################
# dk_readOnlyCallback(VAR access value current_list_file stack)
#
#	TODO
#
#	@VAR				- TODO
#	@access:			- TODO
# 	@value:				- TODO
#	@current_list_file:	- TODO
#	@stack:				- TODO
#	 
macro(dk_readOnlyCallback VAR access value current_list_file stack)   # Watcher for readonly property.
	DKDEBUGFUNC(${ARGV})
	if ("${access}" STREQUAL "MODIFIED_ACCESS")
		dk_warn("'${VAR}' is READONLY")
		set(${VAR} "${_${VAR}_readonly_val}")	# Restore a value of the variable to the initial one.
	endif()
endmacro()


###############################################################################
# dk_prependFile(path string)
#
#	TODO
#
#	@path	- TODO
#	@string	- TODO
# 
function(dk_prependFile path string)
	DKDEBUGFUNC(${ARGV})
	file(READ "${path}" file_data)
	file(write "${pah}" "${string}\n${filedata}")
endfunction()


###############################################################################
# dk_addRegistryKey(key value data)
#
#	TODO
#
#	@key	- TODO
#	@value	- TODO
#	@data	- TODO
#
function(dk_addRegistryKey key value data)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		string(REPLACE "/" "\\" key   ${key})
		string(REPLACE "/" "\\" value ${value})
		string(REPLACE "/" "\\" data  ${data})
		execute_process(COMMAND reg add "${key}" /v "${value}" /t REG_SZ /d "${data}" /f /reg:64 OUTPUT_VARIABLE _output ERROR_VARIABLE _output RESULT_VARIABLE _failed)
		dk_verbose(output	PRINTVAR)
		dk_verbose(_failed	PRINTVAR)
	endif()
endfunction()


###############################################################################
# dk_import(url) #args
#
#	This is a flexable super function for importing just about anything into digitalknob
#	The idea is to provide a url or path and dk_import will do the rest. 
#
#	@url	- The online path the .git or file to import
#
#	github GIT:	https://github.com/orginization/library.git		dk_importGit(url) #branch/tag #PATCH
#	github DL:	https://github.com/orginization/library			dk_importGit(url) #branch/tag #PATCH
#	lib url DL:	https://website.com/library.zip					dk_importDownload(url) #PATCH
#	exe url DL:	https://website.com/executable.exe 				dk_importDownload(url) #PATCH
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
#function(dk_import url) #Lib #tag #Patch
#	DKDEBUGFUNC(${ARGV})
#	dk_import2(${ARGV})
	#dk_getExtension(${url} extension)
	#if("${extension}" STREQUAL ".git")
	#	dk_importGit2(${ARGV})
	#else()
	#	dk_importDownload2(${ARGV})
	#endif()
#endfunction()
#dk_createOsMacros("dk_import")


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
	DKDEBUGFUNC(${ARGV})
	dk_get_option(PATCH ${ARGV})
	
	include(${DKIMPORTS_DIR}/git/DKMAKE.cmake)
	DKASSERT(GIT_EXE)
	
	string(REPLACE "/" ";" url_list ${url})  #split url path into list
	foreach(item ${url_list})
		dk_verbose(item	PRINTVAR)
	endforeach()
	
	list(LENGTH url_list url_list_size)
	dk_verbose(url_list_size	PRINTVAR)

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
		dk_verbose(org	PRINTVAR)
	
		list(GET url_list 4 Lib)
		dk_verbose(Lib	PRINTVAR)
		
		string(FIND ${Lib} ".git" index)
		if(${index} GREATER -1)
		#dk_includes(${Lib} ".git" index)
		#if(${index})
			string(SUBSTRING ${Lib} 0 ${index} Lib)
		endif()
	endif()
	
	string(TOLOWER ${Lib} Lib)
	dk_verbose(Lib	PRINTVAR)
	
	math(EXPR last "${url_list_size}-1")  #OUTPUT_FORMAT DECIMAL)")  CMake 3.13+
	list(GET url_list ${last} url${last})
	
	string(FIND ${url${last}} ".git" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".git" index)
	#if(${index})
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
			string(TOLOWER ${ID} FOLDER)
			dk_verbose(FOLDER	PRINTVAR)
		endif()
	endif()
	
	# check current folder name
	if(NOT "${DKIMPORTS_DIR}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		dk_error("\n\nThe Imports folder is named incorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS_DIR}/${FOLDER}\n\n")
	endif()
	
	string(TOUPPER ${Lib} LIBVAR)
	if(NOT LIBVAR)
		dk_error("$(LIBVAR) is invalid")
	endif()
	dk_verbose(LIBVAR	PRINTVAR)
	
	dk_set(${LIBVAR}_FOLDER ${FOLDER})
	if(NOT ${LIBVAR}_FOLDER)
		dk_error("${LIBVAR}_FOLDER is invalid")
	endif()
	dk_verbose(${LIBVAR}_FOLDER		PRINTVAR)
	
	dk_set(${LIBVAR}_BRANCH ${branch})
	if(NOT ${LIBVAR}_BRANCH)
		dk_error("${LIBVAR}_BRANCH is invalid")
	endif()
	dk_verbose(${LIBVAR}_BRANCH		PRINTVAR)
	
	dk_set(${LIBVAR}_NAME ${FOLDER}-${${LIBVAR}_BRANCH})
	if(NOT ${LIBVAR}_NAME)
		dk_error("${LIBVAR}_NAME is invalid")
	endif()
	dk_verbose(${LIBVAR}_NAME	PRINTVAR)
	
	dk_set(${LIBVAR} ${DK3RDPARTY_DIR}/${${LIBVAR}_NAME})
	if(NOT ${LIBVAR})
		dk_error("${${LIBVAR}} is invalid")
	endif()
	dk_verbose(${${LIBVAR}}	PRINTVAR)
	
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
	string(REPLACE "/" ";" url_list ${url}) # split into list converting / to divider ;
	#foreach(item ${url_list})
	#	dk_verbose(item		PRINTVAR)
	#endforeach()
	list(LENGTH url_list url_length)
	#dk_verbose(url_length	PRINTVAR)
	
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(install_path ${ARGV1})
			dk_verbose(install_path		PRINTVAR)
		endif()
	endif()
	
	if(${ARGC} GREATER 2)
		if(NOT "${ARGV2}" STREQUAL "PATCH")
			set(tag ${ARGV2})
			dk_verbose(tag		PRINTVAR)
		endif()
	endif()
	
	dk_verbose(CMAKE_CURRENT_LIST_DIR	PRINTVAR)
	get_filename_component(Lib ${CMAKE_CURRENT_LIST_DIR} NAME)
	dk_verbose(Lib	PRINTVAR)
	
	string(TOUPPER ${Lib} LIB)
	dk_set(LIBVAR ${LIB})
	dk_verbose(LIBVAR	PRINTVAR)
	
	string(TOLOWER ${Lib} FOLDER)
	dk_set(${LIBVAR}_FOLDER ${FOLDER})
	if(NOT ${LIBVAR}_FOLDER)
		dk_error("${LIBVAR}_FOLDER invalid")
	endif()
	dk_verbose(${LIBVAR}_FOLDER		PRINTVAR)
	
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

###############################################################################
# dk_import(url) #args
#
#	This is a flexable super function for importing just about anything into digitalknob
#	The idea is to provide a url or path and dk_import will do the rest. 
#
#	@url	- The online path the .git or file to import
#
#	github GIT:	https://github.com/orginization/library.git		dk_importGit(url) #branch/tag #PATCH
#	github DL:	https://github.com/orginization/library			dk_importGit(url) #branch/tag #PATCH
#	lib url DL:	https://website.com/library.zip					dk_importDownload(url) #PATCH
#	exe url DL:	https://website.com/executable.exe 				dk_importDownload(url) #PATCH
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
function(dk_import url)
	DKDEBUGFUNC(${ARGV})
	dk_importVariables(${url} plugin ${ARGN})
	
	string(MAKE_C_IDENTIFIER ${plugin} plugin_alpha_numeric)
	string(TOUPPER ${plugin_alpha_numeric} plugin_var)	
	
	#dk_debug(${plugin_var} 					PRINTVAR)
	#dk_debug(${plugin_var}_URL			PRINTVAR)
	#dk_debug(${plugin_var}_VERSION	PRINTVAR)
	#dk_debug(${plugin_var}_FOLDER		PRINTVAR)
	#dk_debug(${plugin_var}_BRANCH	PRINTVAR)
	#dk_debug(${plugin_var}_TAG			PRINTVAR)
	
	if(NOT DKOFFLINE)
		### .git
		dk_getExtension(${url} extension)
		if("${extension}" STREQUAL ".git")
			
			include(${DKIMPORTS_DIR}/git/DKMAKE.cmake)
			DKASSERT(GIT_EXE)
			
			if(NOT EXISTS ${${plugin_var}}/.git)
				dk_set(CURRENT_DIR ${DIGITALKNOB_DIR}/${DK3RDPARTY_DIR})
				if(EXISTS ${${plugin_var}})
					dk_remove(${${plugin_var}})
				endif()
				if(NOT EXISTS ${${plugin_var}})
					dk_makeDirectory(${${plugin_var}})
				endif()
				dk_set(CURRENT_DIR ${${plugin_var}})
				dk_command(${GIT_EXE} clone ${${plugin_var}_URL} ${${plugin_var}})
			endif()
			dk_set(CURRENT_DIR ${${plugin_var}})
			dk_command(${GIT_EXE} checkout -- .)
			dk_command(${GIT_EXE} checkout ${${plugin_var}_BRANCH})
			dk_command(${GIT_EXE} pull)
			if(${plugin_var}_TAG)
				dk_command(${GIT_EXE} checkout ${${plugin_var}_TAG})
			endif()
		### download
		else()
			dk_verbose("dk_install(${plugin} ${ARGN})")
			dk_install(${plugin} ${ARGN})
		endif()
	endif()
	
	dk_get_option(PATCH ${ARGV})
	if(PATCH)
		#dk_debug("dk_patch(${plugin} ${${plugin_var}})")
		dk_patch(${plugin} ${${plugin_var}})
	endif()
	
	# Set the current build output directory
	dk_verbose("setting current build directory to ${${plugin_var}}/${BUILD_DIR}")
	dk_setPath(${${plugin_var}}/${BUILD_DIR})
	
endfunction()
dk_createOsMacros("dk_import")


###############################################################################
# dk_DownloadAll3rdParty()
#
#	TODO
#
function(dk_DownloadAll3rdParty)
	DKDEBUGFUNC(${ARGV})
	dk_dependAll()
	
	# Get a list of all /3rdParty/DKMAKE.cmake paths
	file(GLOB All3rdParty ${DKIMPORTS_DIR}/*)
	foreach(item ${All3rdParty})
		if(EXISTS ${item}/DKMAKE.cmake)
			#dk_info("item = ${item}")
			dk_info(item 	PRINTVAR)
			file(STRINGS ${item}/DKMAKE.cmake lines)
			unset(temp_import_script)
			unset(index)
			unset(indexB)
			
			set(keepCommands "set;SET;dk_download;dk_install;dk_import")
			set(KEEPLINE 0)
			foreach(line ${lines})
			
				foreach(keepCommand ${keepCommands})
					dk_includes("${line}" "${keepCommand}(" hasCommand) # trailing (
					if(${hasCommand})
						set(KEEPLINE 1)
					endif()
					dk_includes("${line}" "${keepCommand} " hasCommand) # trailing space
					if(${hasCommand})
						set(KEEPLINE 1)
					endif()
					dk_includes("${line}" "${keepCommand}	" hasCommand) # trailing tab
					if(${hasCommand})
						set(KEEPLINE 1)
					endif()
				endforeach()
			
				if(KEEPLINE)
					set(dl_import_script "${dl_import_script}${line}\n")
				endif()
				string(FIND "${line}" ")" indexB) 
				if(${indexB} GREATER -1)
				#dk_includes("${line}" ")" indexB)
				#if(${indexB})
					set(KEEPLINE 0)
				endif()
			endforeach()
			
			if(dl_import_script)
				file(WRITE ${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP "${dl_import_script}")
				INCLUDE(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
				dk_remove(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
			endif()
		endif()
	endforeach()
endfunction()


######################################################################
# dk_getFileType(path RESULT)
#  
#	Takes a path and checks the extension to return the file type.
#
#	@path		- A string value of the path to identify
#	@RESULT		- returns a string representing the  type of file.
#           	  Possible results are ARCHIVE, EXECUTABLE, IMAGE, SCRIPT, UNKNOWN, WEB, ...TODO
#
#	Reference: https://en.wikipedia.org/wiki/List_of_file_formats
#
function(dk_getFileType path rtn-type)
	DKDEBUGFUNC(${ARGV})
	dk_getExtension(${path} ext)
	if(NOT ext)
		dk_error("The path does not contain an extension")
		set(${rtn-type} ERROR PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".app")
		set(${rtn-type} EXECUTABLE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bash")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bat")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bz")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bz2")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".com")
		set(${rtn-type} WEB PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".exe")
		set(${rtn-type} EXECUTABLE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".gif")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".gz")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".htm")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".html")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".jpeg")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".jpg")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".js")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".png")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".rar")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".sh")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".tar")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".tif")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".tiff")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".xz")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".zip")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	else()
		set(${rtn-type} UNKNOWN PARENT_SCOPE)
	endif()
endfunction()


###############################################################################
# dk_getAppDirectory(RESULT)
#
#	Get the OS default app directory
#
#	@RESULT		- TODO
#
function(dk_getAppDirectory RESULT)
	DKDEBUGFUNC(${ARGV})
	set(USE_32BIT 1)
	if(WIN_HOST)
		set(appDirectory "C:/Program Files")
		if(${USE_32BIT} AND ${WIN_X86_64_HOST})
			set(appDirectory "C:/Program Files (x86)")
		endif()
	elseif(MAC_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(IOS_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(LINUX_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(RASPBERRY_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(ANDROID_ANDROID)
		dk_todo() #TODO
		set(appDirectory "/")
	endif()
	set(${RESULT} ${appDirectory} PARENT_SCOPE)
endfunction()


###############################################################################
# toLower(str RESULT)
#
#	Convert a string to lower case
#
#	@str	- The input string to convert
#	@RESULT	- Returns the converted output string
#
function(toLower str RESULT)
	DKDEBUGFUNC(${ARGV})
	string(TOLOWER "${str}" upper)
	set(${RESULT} ${out} PARENT_SCOPE)
endfunction()


###############################################################################
# toUpper(str RESULT)
#
#	Convert a string to upper case
#
#	@str	- The input string to convert
#	@RESULT	- Returns the converted output string
#
function(toUpper str RESULT)
	#DKDEBUGFUNC(${ARGV})
	string(TOUPPER "${str}" upper)
	set(${RESULT} ${upper} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_removeExtension(path RESULT) NOERROR
#
#	Remove the extension from a file path
#
#	@path				- TODO
#	@RESULT				- TODO
#   NOERROR (optional)	- if one of the parameters is NOERROR, dk_error() messages will not be displayed
#
function(dk_removeExtension path RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_get_option(NOERROR ${ARGV})
	
	string(FIND ${path} "." includes REVERSE)
	if(${includes} EQUAL -1)
	#dk_includes(${path} "." includes REVERSE)
	#if(NOT includes)
		if(NOT NOERROR)
			dk_error("no extension found")
		endif()
		return()
	endif()
	
	dk_getExtension(${path} ext)
	string(REPLACE ${ext} "" fileNameNoExt ${path}) 
	#string(SUBSTRING ${path} 0 ${includes} fileNameNoExt)
    set(${RESULT} ${fileNameNoExt} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_getAppName(path RESULT)
#
#	Get the app name from a file path
#
#	@path		- TODO
#	@RESULT		- TODO
#
function(dk_getAppName path RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_getFilename(${path} fileName)
	dk_removeExtension(${fileName} fileNameNoExt)
	dk_verbose(fileNameNoExt	PRINTVAR)
	set(${RESULT} ${fileNameNoExt} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_createPlugin(url)
#
#	Generate a folder/DKMAKE.cmake for a new plugin
#
#	@url	- TODO
#
function(dk_createPlugin url)
	DKDEBUGFUNC(${ARGV})
	dk_todo() #TODO
	dk_getAppName(${url} App_Name)
	dk_verbose(App_Name		PRINTVAR)					# My_App
	dk_toLower(${App_Name} app_name)
	dk_verbose(app_name		PRINTVAR)					# my_app
	dk_toUpper(${APP_NAME} APP_NAME)
	dk_verbose(APP_NAME		PRINTVAR)					# MY_APP
	dk_getAppDirectory(appDirectory)
	if(NOT exe_path)
		dk_set(exe_path ${appDirectory}/${App_Name}/${App_Name}.exe)
	endif()
endfunction()


###############################################################################
# dk_getGitBranchName(url RESULT)
#
#	Return the name of the head branch from a git repository
#
#	@url	- The git url
#	@RESULT	- Returns the name of the head branch
#
#	https://stackoverflow.com/a/31919435
#
function(dk_getGitBranchName url RESULT)
	DKDEBUGFUNC(${ARGV})
	
	include(${DKIMPORTS_DIR}/git/DKMAKE.cmake)
	DKASSERT(GIT_EXE)
			
	execute_process(COMMAND ${GIT_EXE} ls-remote ${url} heads/* RESULT_VARIABLE result OUTPUT_VARIABLE output)
	set(${RESULT} ${output} PARENT_SCOPE)
endfunction()	


###############################################################################
# dk_printArgData()
#
#	Print the current CMake scripte path and ARG* variables
#
macro(dk_printArgData)
	DKDEBUGFUNC(${ARGV})
	dk_debug(" ")
	dk_debug("************************************************************")
	dk_debug(" ")
	dk_debug(CMAKE_CURRENT_LIST_DIR		PRINTVAR)
	dk_debug("*** ARG Variables ***")
	dk_debug(ARGC	PRINTVAR)
	dk_debug(ARGN	PRINTVAR)
	dk_debug(ARGV	PRINTVAR)
	dk_debug(ARGV0	PRINTVAR)
	dk_debug(ARGV1	PRINTVAR)
	math(EXPR ARGC_LAST "${ARGC}-1")
	dk_debug(ARGC_LAST	PRINTVAR)
	set(ARGV_LAST ${ARGV${ARGC_LAST}})
	dk_debug(ARGV_LAST	PRINTVAR)
	dk_debug(" ")
endmacro()


###############################################################################
# dk_printUrlData(url)
#
#	Print url seperated into an array
#
#	@url	- The url to print
#
function(dk_printUrlData url)
	DKDEBUGFUNC(${ARGV})
	if(NOT url)
		dk_error("url invalid! ")
	endif()
	dk_verbose("*** url Variables ***")
	dk_verbose(url					PRINTVAR)
	string(REPLACE "/" ";" PLUGIN_URL_LIST ${url}) # seperate the url nodes into a list 
	dk_verbose(PLUGIN_URL_LIST		PRINTVAR)
	list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)
	dk_verbose(PLUGIN_URL_LENGTH	PRINTVAR)
	set(n -1)
	foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})
		math(EXPR n "${n}+1")
		set(url_${n} ${PLUGIN_URL_ITEM})
		dk_verbose(url_${n}			PRINTVAR)
		set(url_last ${url_${n}})
	endforeach()
	dk_verbose(url_last			PRINTVAR)
	dk_getFileType(${url} url_filetype)
	dk_verbose(url_filetype		PRINTVAR)
endfunction()


###############################################################################
# dk_killProcess(name)
#
#	Kill a running process by name
#
#	@name		- name of the process to kill
#
function(dk_killProcess name)
	DKDEBUGFUNC(${ARGV})
	dk_executeProcess("taskkill /f /im ${name}" NOASSERT)
endfunction()


###############################################################################
# dk_clearScreen()
#
#	Clear the console
#
function(dk_clearScreen)
	DKDEBUGFUNC(${ARGV})
	dk_debug("clear screen")
	execute_process(COMMAND "cmd /c cls")
endfunction()


###############################################################################
# dk_findLibrary(name) NOASSERT
#
#	Search for a library and include it with dk_lib
#
#	@name	- The name of the library
#
function(dk_findLibrary name)
	DKDEBUGFUNC(${ARGV})
	dk_get_option(NOASSERT ${ARGV})
	
	find_library(${name}_LIBRARY ${name} ${ARGN})
	if(NOT WIN)
		if(NOT ${name}_LIBRARY)
				dk_error("Could not locate ${name} Library" ${NOASSERT})
				if(NOASSERT)
					set(${name}_LIBRARY ${name})
				endif()
		endif()
		dk_lib(${${name}_LIBRARY})
	else()
		#FIXME: no error control for windows library search
		dk_lib(${name})
	endif()
endfunction()
dk_createOsMacros("dk_findLibrary")


###############################################################################
# dk_findFiles(path pattern RESULT) RECURSE
#
#	Search for files within a path matching a pattern
#
#	@path				- The path to search 
#	@pattern			- The pattern to search for
#	@RESULT				- Returns the list of file(s) if found
#   RECURSE (optional) 	- Search the path recursivly 
#
function(dk_findFiles path pattern RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_get_option(RECURSE ${ARGV})

	if(RECURSE)
		file(GLOB_RECURSE files "${path}/" "${path}/${pattern}")
	else()
		file(GLOB files "${path}/" "${path}/${pattern}")
	endif()
	if(NOT files)
		dk_error("files is invalid")
		return()
	endif()
	dk_debug(files	PRINTVAR)
	set(${RESULT} ${files} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_shell(args)
#
#	Execute a UNIX style command
#
#	@args	- The command and args to execute
#
#macro(dk_shell args)
#	DKDEBUGFUNC(${ARGV})
#	if(WIN_HOST)# AND NOT EMSCRIPTEN)
#		dk_msys2(${ARGV})
#	else()
#		dk_command(${ARGV})
#	endif()
#endmacro()
#dk_createOsMacros("dk_shell")


###############################################################################
# dk_queueShell(args)
#
#	Queue the execution of a UNIX style command
#
#	@args	- The command and args to execute
#
#macro(dk_queueShell args)
#	DKDEBUGFUNC(${ARGV})
#	if(QUEUE_BUILD)
#		dk_shell(${ARGV})
#	endif()	
#endmacro()
#dk_createOsMacros("dk_queueShell")


###############################################################################
# dk_resizeImage(inpath width height outpath)
#
#	@inpath		- Full path of the image file to resize
#	@width		- The number of pixels in with to resize to 
#	@height		- The number of pixels in height to resize to
#	@outpath	- Full path of the output file to save to
#
function(dk_resizeImage inpath width height outpath)
	DKDEBUGFUNC(${ARGV})
	get_filename_component(outdir ${outpath} DIRECTORY)
	if(NOT outdir)
		dk_error("outdir is invalid")
	endif()
	dk_makeDirectory(${outdir})

	if(MAC_HOST)
		dk_executeProcess(sips -z ${width} ${height} ${inpath} --out ${outpath})
	else()
		include("${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake")
		if(NOT IMAGEMAGICK_CONVERT)
			dk_warn("IMAGEMAGICK_CONVERT is invalid!")
			return()
		endif()
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${inpath} -resize ${width}x${height} ${outpath})
	endif()
endfunction()


###############################################################################
# dk_createWindowsIcon()
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createWindowsIcon inpath outpath)
	DKDEBUGFUNC(${ARGV})
	include("${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake")
	if(IMAGEMAGICK_CONVERT)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${inpath} -define icon:auto-resize=256,128,64,48,32,16 ${outpath})
	else()
		dk_error("IMAGEMAGICK_CONVERT is invalid!")
	endif()
endfunction()


###############################################################################
# dk_createFavIcon()
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createFavIcon inpath outpath)
	DKDEBUGFUNC(${ARGV})
	include("${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake")
	if(IMAGEMAGICK_CONVERT)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${inpath} -define icon:auto-resize=16 ${outpath})
	else()
		dk_error("IMAGEMAGICK_CONVERT is invalid!")
	endif()
endfunction()


###############################################################################
# dk_pathContains(expression RESULT)
#
#	@expression	- The search expression to use. Example: "${path}/subfolder/*.exe"
#   @RESULT		- Returns TRUE if the expression is found
#
function(dk_pathContains expression RESULT)
	DKDEBUGFUNC(${ARGV})
	FILE(GLOB contains "${expression}") 
	if(contains)
		set(${RESULT} TRUE PARENT_SCOPE)
		return()
	endif()
endfunction()


###############################################################################
# dk_addFirewallAllow(name executable)
#
#	@name		 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
function(dk_addFirewallAllow name executable)
	DKDEBUGFUNC(${ARGV})
	return()	# this function is disabled for now
	
	if(NOT WIN_HOST)
		return()
	endif()
	
	string(REPLACE "/" "\\\\" executable "${executable}") #replace / with \

	dk_command(netsh advfirewall firewall add rule name="${name}" dir=in action=allow program="${executable}" enable=yes profile=any)
	dk_command(netsh advfirewall firewall add rule name="${name}" dir=out action=allow program="${executable}" enable=yes profile=any) 
endfunction()



###############################################################################
# dk_getUnixPath(path unix_path)
#
#	@path		 	- windows in path
#   @unix_path		- The returned unix style path
#
macro(dk_getUnixPath path unix_path)
	if(WIN32)
		dk_depend(MSYS2)
		execute_process(COMMAND cygpath.exe "${path}" OUTPUT_VARIABLE ${unix_path} OUTPUT_STRIP_TRAILING_WHITESPACE)
		string (STRIP ${unix_path} unix_path)
	endif(WIN32)
endmacro()



###############################################################################
# dk_applyPatch(directory patch_file)
#
#	@directory		- The directory to patch from
#   @patch_file		- Full path to the patch file
#
#	https://stackoverflow.com/a/66755317/688352
#
macro(dk_applyPatch directory patch_file)

	## First run a check 
	set(COMMAND_ARGS "")
	set(COMMAND_ARGS ${COMMAND_ARGS} git)
	set(COMMAND_ARGS ${COMMAND_ARGS} apply)
	set(COMMAND_ARGS ${COMMAND_ARGS} --check)
	set(COMMAND_ARGS ${COMMAND_ARGS} --verbose)
	set(COMMAND_ARGS ${COMMAND_ARGS} ${patch_file})
	dk_debug("${COMMAND_ARGS}")
	execute_process(COMMAND ${COMMAND_ARGS}
					WORKING_DIRECTORY ${directory}
					RESULT_VARIABLE result
					OUTPUT_VARIABLE output
					OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(NOT ${result} EQUAL 0)
		#dk_error("ERROR: 'An error occured patching with ${patch_file}'")
		return()	# RETURN if the patch check failed, it may have already been patched
	endif()
	dk_debug(output	PRINTVAR)
	
	## THen do the actual patch 
	set(COMMAND_ARGS "")
	set(COMMAND_ARGS ${COMMAND_ARGS} git)
	set(COMMAND_ARGS ${COMMAND_ARGS} apply)
	#set(COMMAND_ARGS ${COMMAND_ARGS} --check)
	set(COMMAND_ARGS ${COMMAND_ARGS} --verbose)
	set(COMMAND_ARGS ${COMMAND_ARGS} ${patch_file})
	dk_debug(COMMAND_ARGS	PRINTVAR)
	execute_process(COMMAND ${COMMAND_ARGS}
					WORKING_DIRECTORY ${directory}
					RESULT_VARIABLE result
					OUTPUT_VARIABLE output
					OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(NOT ${result} EQUAL 0)
		dk_error("ERROR: 'An error occured patching with ${patch_file}'")
	endif()
	dk_info(output	PRINTVAR)
endmacro()

dk_load(dk_get_arg_count)
###############################################################################
# dk_get_arg_count(RESULT args)
#
#	@RESULT  - Returns the number of args received (minus the result argument)
#	@args 	 - a variable number of input arguments
#
#function(dk_get_arg_count RESULT)
#	math(EXPR ARGC "${ARGC}-1")
#	set(${RESULT} ${ARGC} PARENT_SCOPE)
#endfunction()

dk_load(dk_is_list)
###############################################################################
# dk_is_list(result arg(s))
#
#	@RESULT     - returns true is the arg(s) is a list, false if not
#	@arg		- The input argument(s) to be examined 
#
#function(dk_is_list RESULT)
#	math(EXPR ARGC "${ARGC}-1")  
#
#	if(NOT "${${ARGN}}" STREQUAL "")
#		dk_get_arg_count(count ${${ARGN}})
#		message("count = ${count}")
#		if(${count} GREATER 1)
#			message("${ARGN} is a LIST variable")
#			set(${RESULT} TRUE PARENT_SCOPE)
#		elseif(${count} GREATER 0)
#			message("${ARGN} is a STRING variable")
#			set(${RESULT} FALSE PARENT_SCOPE)
#		else()
#			message("${ARGN} is INVALID!")
#			set(${RESULT} FALSE PARENT_SCOPE)
#		endif()
#		return()
#	endif()
#
#	if(NOT "${ARGN}" STREQUAL "")
#		dk_get_arg_count(count ${ARGN})
#		message("count = ${count}")
#		if(${count} GREATER 1)
#			message("${ARGN} is a LIST value")
#			set(${RESULT} TRUE PARENT_SCOPE)
#		elseif(${count} GREATER 0)
#			message("${ARGN} is a STRING value")
#			set(${RESULT} FALSE PARENT_SCOPE)
#		else()
#			message("${ARGN} is INVALID!")
#			set(${RESULT} FALSE PARENT_SCOPE)
#		endif()
#		return()
#	else()
#		message("${ARGN} is invalid")
#		set(${RESULT} FALSE PARENT_SCOPE)
#	endif()
#endfunction()






include(${DKFunctions_ext})
