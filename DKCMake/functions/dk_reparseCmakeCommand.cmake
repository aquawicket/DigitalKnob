#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_reparseCmakeCommand(CMD_LIST)
#
#
function(reparseCmakeCommand CMD_LIST)
	set(ARGV "${${CMD_LIST}}")
	file(REMOVE cmake_reparsed.txt)
	list(REMOVE_ITEM ARGV COMMAND)
	foreach(item IN LISTS ARGV)
		if(${item} MATCHES "=")
			list(REMOVE_ITEM ARGV ${item})
			string(REGEX REPLACE "^-D" "set(" item ${item})
			string(REGEX REPLACE "^=" " " item "${item})")
			file(APPEND cmake_reparsed.txt "${item}\n")
		endif() 
	endforeach()
	
	# find the first occurence of an execute_process_option
	set(execute_process_options "WORKING_DIRECTORY;TIMEOUT;RESULT_VARIABLE;RESULTS_VARIABLE;OUTPUT_VARIABLE;ERROR_VARIABLE;INPUT_FILE;OUTPUT_FILE;ERROR_FILE;OUTPUT_QUIET;ERROR_QUIET;COMMAND_ECHO;OUTPUT_STRIP_TRAILING_WHITESPACE;ERROR_STRIP_TRAILING_WHITESPACE;ENCODING;ECHO_OUTPUT_VARIABLE;ECHO_ERROR_VARIABLE;COMMAND_ERROR_IS_FATAL")
	list(LENGTH ARGV first_ep_arg)
	foreach(item IN LISTS execute_process_options)
		list(FIND ARGV "${item}" pos)
		if((${pos} GREATER -1) AND (${pos} LESS ${first_ep_arg}))
			set(first_ep_arg ${pos})
		endif()
	endforeach()

	list(SUBLIST ARGV 0 ${first_ep_arg} CMAKE_ARGS)
	list(SUBLIST ARGV ${first_ep_arg} -1 EP_ARGS)

	list(APPEND CMAKE_ARGS "-C;cmake_reparsed.txt")
	#message("CMAKE_ARGS = ${CMAKE_ARGS}\n")
	#message("EP_ARGS = ${EP_ARGS}\n")
	list(APPEND NEW_ARGV "COMMAND")
	list(APPEND NEW_ARGV "${CMAKE_ARGS}")
	list(APPEND NEW_ARGV "${EP_ARGS}")
	set(${CMD_LIST} ${NEW_ARGV} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	set(myCmakeCommand "COMMAND;cmd;/c;C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang32/bin/cmake.exe;-G;MinGW Makefiles;-DBUILD_SHARED_LIBS=0;-DBUILD_STATIC_LIBS=1;-DBUILD_TESTING=0;-DCMAKE_BUILD_TYPE=Debug;-DCMAKE_MAKE_PROGRAM=C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang32/bin/mingw32-make.exe;-DCMAKE_C_COMPILER=C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang32/bin/clang.exe;-DCMAKE_C_FLAGS=-march=i686 -DMSYSTEM=CLANG32 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17;-DCMAKE_C_FLAGS_DEBUG=-DDEBUG -D_DEBUG -g;-DCMAKE_C_FLAGS_RELEASE=-O3 -DNDEBUG;-DCMAKE_CXX_COMPILER=C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang32/bin/clang++.exe;-DCMAKE_CXX_FLAGS=-frtti -march=i686 -DMSYSTEM=CLANG32 -DWIN -DWIN_X86 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17;-DCMAKE_CXX_FLAGS_DEBUG=-DDEBUG -D_DEBUG -g;-DCMAKE_CXX_FLAGS_RELEASE=-O3 -DNDEBUG;-DAOM_TARGET_CPU=generic;-S;C:/Users/Administrator/digitalknob/Development/3rdParty/aom-c2fe6bf;-B;C:/Users/Administrator/digitalknob/Development/3rdParty/aom-c2fe6bf/win_x86_clang/Debug;OUTPUT_VARIABLE;echo_output;ERROR_VARIABLE;echo_output;WORKING_DIRECTORY;C:/Users/Administrator/digitalknob/Development/3rdParty/aom-c2fe6bf/win_x86_clang/Debug;RESULT_VARIABLE;result_variable;COMMAND_ECHO;STDOUT;OUTPUT_STRIP_TRAILING_WHITESPACE")
	
	message("myCmakeCommand = ${myCmakeCommand}\n")
	reparseCmakeCommand(myCmakeCommand)
	message("myCmakeCommand = ${myCmakeCommand}\n")
endfunction()
