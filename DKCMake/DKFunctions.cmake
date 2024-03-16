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

dk_load(dk_createOsMacros)
###############################################################################
# dk_createOsMacros(func)
#
#	Prefix a function with <OS>_ macros. Calling the <OS>_function will only be called if the current <OS> or <OS_HOST> is true
#
#	@func	- The func of the function to create aliases for
#
#function(dk_createOsMacros func)
#	DKDEBUGFUNC(${ARGV})
#	if(NOT EXISTS ${DKFunctions_ext})
#		file(APPEND ${DKFunctions_ext} "### Don't make changes in this file. They will be overwritten. ###\n")
#		file(APPEND ${DKFunctions_ext} "### This file was automatically generated from DKFunctions.cmake ###\n")
#	endif()
#	file(APPEND ${DKFunctions_ext} "\n## ${func} ##\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_HOST_${func})\n   if(WIN_HOST)\n      ${func}(\${ARGV})\n  endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_HOST_${func})\n   if(WIN_HOST AND X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_64_HOST_${func})\n   if(WIN_HOST AND X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(UNIX_HOST_${func})\n   if(UNIX_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_HOST_${func})\n   if(MAC_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_HOST_${func})\n   if(MAC_HOST AND X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_64_HOST_${func})\n   if(MAC_HOST AND X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_HOST_${func})\n   if(LINUX_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_HOST_${func})\n   if(LINUX_HOST AND X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_64_HOST_${func})\n   if(LINUX_HOST AND X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_HOST_${func})\n   if(ANDROID_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	
#	file(APPEND ${DKFunctions_ext} "macro(WIN_${func})\n   if(WIN)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_${func})\n   if(WIN_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_64_${func})\n   if(WIN_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(UNIX_${func})\n   if(NOT WIN)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(APPLE_${func})\n   if(MAC OR IOS OR IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(APPLE32_${func})\n   if(MAC_X86 OR IOS_ARM32 OR IOSSIM_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(APPLE64_${func})\n   if(MAC_X86_64 OR IOS_ARM64 OR IOSSIM_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_${func})\n   if(MAC)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_${func})\n   if(MAC_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_64_${func})\n   if(MAC_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOS_${func})\n   if(IOS AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM32_${func})\n   if(IOS_ARM32 AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM64_${func})\n   if(IOS_ARM64 AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_${func})\n   if(IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_${func})\n   if(IOSSIM_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_64_${func})\n   if(IOSSIM_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_${func})\n   if(LINUX)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_${func})\n   if(LINUX_X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_64_${func})\n   if(LINUX_X86_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_${func})\n   if(RASPBERRY)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM32_${func})\n   if(RASPBERRY_ARM32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM64_${func})\n   if(RASPBERRY_ARM64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_${func})\n   if(ANDROID)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM32_${func})\n   if(ANDROID_ARM32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM64_${func})\n   if(ANDROID_ARM64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(EMSCRIPTEN_${func})\n   if(EMSCRIPTEN)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	
#	if("${ARGN}" STREQUAL "NO_DEBUG_RELEASE_TAGS")
#		return()
#	endif()
#	file(APPEND ${DKFunctions_ext} "macro(DEBUG_${func})\n   if(DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_DEBUG_${func})\n   if(WIN AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_DEBUG_${func})\n   if(WIN_X86 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_64_DEBUG_${func})\n   if(WIN_X86_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(UNIX_DEBUG_${func})\n   if(NOT WIN AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(APPLE_DEBUG_${func})\n   if(MAC OR IOS OR IOSSIM AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_DEBUG_${func})\n   if(MAC AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_DEBUG_${func})\n   if(MAC_X86 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_64_DEBUG_${func})\n   if(MAC_X86_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOS_DEBUG_${func})\n   if(IOS AND DEBUG AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM32_DEBUG_${func})\n   if(IOS_ARM32 AND DEBUG AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM64_DEBUG_${func})\n   if(IOS_ARM64 AND DEBUG AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_DEBUG_${func})\n   if(IOSSIM AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_DEBUG_${func})\n   if(IOSSIM_X86 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_64_DEBUG_${func})\n   if(IOSSIM_X86_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_DEBUG_${func})\n   if(LINUX AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_DEBUG_${func})\n   if(LINUX_X86 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_64_DEBUG_${func})\n   if(LINUX_X86_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_DEBUG_${func})\n   if(RASPBERRY AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM32_DEBUG_${func})\n   if(RASPBERRY_ARM32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM64_DEBUG_${func})\n   if(RASPBERRY_ARM64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_DEBUG_${func})\n   if(ANDROID AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM32_DEBUG_${func})\n   if(ANDROID_ARM32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM64_DEBUG_${func})\n   if(ANDROID_ARM64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(EMSCRIPTEN_DEBUG_${func})\n   if(EMSCRIPTEN AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	
#	file(APPEND ${DKFunctions_ext} "macro(RELEASE_${func})\n   if(RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_RELEASE_${func})\n   if(WIN AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_RELEASE_${func})\n   if(WIN_X86 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(WIN_X86_64_RELEASE_${func})\n   if(WIN_X86_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(UNIX_RELEASE_${func})\n   if(NOT WIN AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(APPLE_RELEASE_${func})\n   if(MAC OR IOS OR IOSSIM AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_RELEASE_${func})\n   if(MAC AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_RELEASE_${func})\n   if(MAC_X86 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(MAC_X86_64_RELEASE_${func})\n   if(MAC_X86_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOS_RELEASE_${func})\n   if(IOS AND RELEASE AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM32_RELEASE_${func})\n   if(IOS_ARM32 AND RELEASE AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOS_ARM64_RELEASE_${func})\n   if(IOS_ARM64 AND RELEASE AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_RELEASE_${func})\n   if(IOSSIM AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_RELEASE_${func})\n   if(IOSSIM_X86 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_X86_64_RELEASE_${func})\n   if(IOSSIM_X86_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_RELEASE_${func})\n   if(LINUX AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_RELEASE_${func})\n   if(LINUX_X86 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(LINUX_X86_64_RELEASE_${func})\n   if(LINUX_X86_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_RELEASE_${func})\n   if(RASPBERRY AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM32_RELEASE_${func})\n   if(RASPBERRY_ARM32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_ARM64_RELEASE_${func})\n   if(RASPBERRY_ARM64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_RELEASE_${func})\n   if(ANDROID AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM32_RELEASE_${func})\n   if(ANDROID_ARM32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(ANDROID_ARM64_RELEASE_${func})\n   if(ANDROID_ARM64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#	file(APPEND ${DKFunctions_ext} "macro(EMSCRIPTEN_RELEASE_${func})\n   if(EMSCRIPTEN AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
#endfunction()
#set(dk_disabled_list ""	CACHE INTERNAL "")
#set(DKFunctions_ext ${DKCMAKE_DIR}/DKFunctions_ext.cmake)
#dk_remove(${DKFunctions_ext} NOERROR)

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
dk_load(dk_updateAndroidName)
dk_load(dk_updateInfoPlist)
dk_load(dk_buildLog)
dk_load(dk_addSource)
dk_load(dk_removeSource)
dk_load(dk_wrapString)
dk_load(dk_bin2h)
dk_load(dk_getCmakeCommandLine)
dk_load(dk_printSettings)
dk_load(dk_addTarget)
dk_load(dk_removeTarget)
dk_load(dk_createSmartObject)
dk_load(dk_log)
dk_load(dk_removeSubstring)
dk_load(dk_findTarget)
dk_load(dk_setReadOnly)
dk_load(dk_readOnlyCallback)
dk_load(dk_prependFile)
dk_load(dk_addRegistryKey)
dk_load(dk_importGit)
dk_load(dk_importDownload)
dk_load(dk_import)
dk_load(dk_DownloadAll3rdParty)
dk_load(dk_getFileType)
dk_load(dk_getAppDirectory)

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

dk_load(dk_removeExtension)
dk_load(dk_getAppName)
dk_load(dk_createPlugin)
dk_load(dk_getGitBranchName)	
dk_load(dk_printArgData)
dk_load(dk_printUrlData)
dk_load(dk_killProcess)
dk_load(dk_clearScreen)
dk_load(dk_findLibrary)
dk_load(dk_findFiles)
dk_load(dk_resizeImage)
dk_load(dk_createWindowsIcon)
dk_load(dk_createFavIcon)
dk_load(dk_pathContains)
dk_load(dk_addFirewallAllow)
dk_load(dk_getUnixPath)
dk_load(dk_applyPatch)
dk_load(dk_get_arg_count)
dk_load(dk_is_list)

#include(${DKFunctions_ext})
