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


############ cmake ############
# https://cmake.org
# https://github.com/Kitware/CMake
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake
# https://discourse.cmake.org/t/cmake-silent-install-with-options-help/1475/2
# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line 	# How to get latest version on ubuntu
# https://github.com/Kitware/CMake/releases


dk_import(APP)













#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_validate(Host_Tuple "dk_Host_Tuple()")
#set(cmake_Import "${cmake_${Host_Tuple}_Import}")
#dk_assertVar(cmake_${Host_Tuple}_Import)

### BINARY DISTRIBUTIONS (PORTABLE) ###
#if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
#	dk_set(cmake_Import cmake)
#	if(NOT EXIST ${CMAKE_EXE})
#		dk_installPackage(${cmake_Import})
#		dk_findProgram(CMAKE_EXE cmake)
#	endif()
#	dk_return()
#endif()

### CMAKE variables ###
#dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
#dk_importVariables	("${cmake_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR} INSTALL_ROOT ${DKTOOLS_DIR})



###### INSTALL ######
#if(Android_Host)
#	dk_installPackage(cmake)
#	dk_findProgram(CMAKE_EXE cmake)
#elseif(Windows_Host)
#	if(Android)
#		dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
#		dk_set(CMAKE "$ENV{DKTOOLS_DIR}/${CMAKE_FOLDER}")
#		dk_findProgram(CMAKE_EXE cmake ${CMAKE})
#	#elseif(CLANG OR MINGW OR UCRT)
#	elseif(MSYSTEM)
#		dk_validate(MSYS2 "dk_depend(msys2)")
#		dk_validate(MSYSTEM "dk_MSYSTEM()")
#		if(MSYSTEM)
#			dk_toLower(${MSYSTEM} msystem)
#			if(MSYSTEM STREQUAL "MSYS")
#				dk_set(msystem clang64)		
#			endif()
#		endif()
#		
#		if(NOT EXISTS ${CMAKE_EXE})
#			dk_installPackage(cmake)
#			if(MSYSTEM)
#				dk_findProgram(CMAKE_EXE cmake.exe "${${MSYSTEM}_BIN}")
#			else()
#				dk_findProgram(CMAKE_EXE cmake.exe ${MSYS2}/usr/bin)
#			endif()
#		endif()
#	else()
#		dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
#		dk_set(CMAKE "$ENV{DKTOOLS_DIR}/${CMAKE_FOLDER}")
#		dk_findProgram(CMAKE_EXE cmake ${CMAKE})
#	endif()
#else()
#	dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
#	if(Mac_Host)
#		dk_info("searching for cmake in ${CMAKE}/CMake.app/Contents/bin")
#		dk_import(${cmake_Import} _PATH_ $ENV{DKTOOLS_DIR}/${CMAKE_FOLDER})
#		dk_findProgram(CMAKE_EXE cmake ${CMAKE}/CMake.app/Contents/bin)
#	else()
#		dk_set(CMAKE "$ENV{DKTOOLS_DIR}/${CMAKE_FOLDER}")
#		
#		if(NOT EXISTS ${CMAKE_EXE})
#			dk_import(${cmake_Import} _PATH_ ${CMAKE})
#			dk_findProgram(CMAKE_EXE cmake ${CMAKE})
#		endif()
#	endif()
#endif()



### VALIDATE ### (second check)
#if(NOT CMAKE_EXE)
#	dk_warning("COULD NOT FIND CMAKE_EXE...   defaulting to CMAKE_COMMAND")
#	dk_set(CMAKE_EXE ${CMAKE_COMMAND})
#endif()

#dk_firewallAllow("CMake" "$ENV{CMAKE_EXE}")


#execute_process(COMMAND ${CMAKE_EXE} --version OUTPUT_VARIABLE CMAKE_EXE_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)
#string(STRIP ${CMAKE_VERSION} CMAKE_VERSION)
#dk_set(CMAKE_VERSION "${CMAKE_VERSION}")































### COMPILE CMAKE ###
#set(COMPILE_CMAKE 1)
if(COMPILE_CMAKE)
	if(NOT CMAKE_EXE)
		dk_set(CMAKE_EXE ${CMAKE_COMMAND})
	else()
		dk_import(https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3.tar.gz)
		if(Android_Host)
			dk_download(https://raw.githubusercontent.com/libarchive/libarchive/master/contrib/android/include/android_lf.h ${CMAKE}/Utilities/cmlibarchive/libarchive)
		endif()
		
		dk_include				(${CMAKE}									CMAKE_INCLUDE_DIR)
		dk_include				(${CMAKE}/${Target_Tuple})
		Debug_dk_include		(${CMAKE_DEBUG_DIR})
		Release_dk_include		(${CMAKE_RELEASE_DIR})

		dk_libDebug		(${CMAKE_DEBUG_DIR}/libcmake.a				CMAKE_LIBRARY_DEBUG)
		dk_libRelease	(${CMAKE_RELEASE_DIR}/libcmake.a			CMAKE_LIBRARY_RELEASE)
		
		# Remove some flags for some builds
		string(REPLACE "--DDEBUG" 	""	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
		string(REPLACE "  "			" " DKCMAKE_BUILD "${DKCMAKE_BUILD}")
		dk_configure(${CMAKE} 
			-DCMake_INSTALL_COMPONENTS=OFF 			# "Using components when installing" OFF
			-DCMake_INSTALL_DEPENDENCIES=OFF		# "Whether to install 3rd-party runtime dependencies" OFF
			-DCMake_BUILD_DEVELOPER_REFERENCE=OFF	# "Build CMake Developer Reference" OFF
			-DCMake_BUILD_LTO=OFF 					# "Compile CMake with link-time optimization" OFF
			-DCMake_BUILD_PCH=OFF 					# "Compile CMake with precompiled headers" OFF
			#-DCMAKE_USE_SYSTEM_LIBARCHIVE 			# "Use system-installed libarchive" "${CMAKE_USE_SYSTEM_LIBRARY_LIBARCHIVE}"
			#-DCMAKE_USE_SYSTEM_CPPDAP 				# "Use system-installed cppdap" "${CMAKE_USE_SYSTEM_LIBRARY_CPPDAP}"
			#-DCMAKE_USE_SYSTEM_CURL 				# "Use system-installed curl" "${CMAKE_USE_SYSTEM_LIBRARY_CURL}"
			#-DCMAKE_USE_SYSTEM_EXPAT 				# "Use system-installed expat" "${CMAKE_USE_SYSTEM_LIBRARY_EXPAT}"
			#-DCMAKE_USE_SYSTEM_FORM 				# "Use system-installed libform" "${CMAKE_USE_SYSTEM_LIBRARY_FORM}"
			#-DCMAKE_USE_SYSTEM_LIBRHASH 			# "Use system-installed librhash" "${CMAKE_USE_SYSTEM_LIBRARY_LIBRHASH}"
			#-DCMAKE_USE_SYSTEM_LIBUV 				# "Use system-installed libuv" "${CMAKE_USE_SYSTEM_LIBRARY_LIBUV}"
			#-DCMAKE_USE_SYSTEM_KWIML 				# "Use system-installed KWIML" OFF
			#-DCMAKE_USE_FOLDERS 					# "Enable folder grouping of projects in IDEs." ON
			#-DCMake_RUN_CLANG_TIDY 				# "Run clang-tidy with the compiler." OFF
			#-DCMake_USE_CLANG_TIDY_MODULE 			# "Use CMake's clang-tidy module." OFF
			#-DCMake_RUN_IWYU 						# "Run include-what-you-use with the compiler." OFF
			#-DCMake_IWYU_VERBOSE 					# "Run include-what-you-use in verbose mode" OFF
		)
			 
		dk_build()
		
		dk_return()
	endif()
endif()
	
	

### OR ###	


	
### INSTALL PREBUILT CMAKE ###
if(MSYSTEM)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_assertPath(MSYS2)
	
	dk_depend(bash)
	dk_exec(${BASH_EXE} -c "command -v cmake" OUTPUT_VARIABLE CMAKE_EXE)
	#dk_findProgram(CMAKE_EXE cmake)
	if(EXISTS ${CMAKE_EXE})
		dk_depend(cygpath)
		dk_exec(${CYGPATH_EXE} -m ${CMAKE_EXE} OUTPUT_VARIABLE CMAKE_EXE)
	endif()
	
	if(NOT EXISTS ${CMAKE_EXE})
		dk_installPackage(cmake)
	endif()
	
	dk_exec(bash -c "command -v cmake" OUTPUT_VARIABLE CMAKE_EXE)
	#dk_findProgram(CMAKE_EXE cmake)
	if(CMAKE_EXE)
		dk_exec(cygpath -m ${CMAKE_EXE} OUTPUT_VARIABLE CMAKE_EXE)
	endif()
	
elseif(Android_Host)
	#dk_exec(pkg install cmake -y)
	dk_installPackage(cmake)
else()
	if(Windows_Host)
		if(NOT CMAKE_EXE)
			dk_set(CMAKE_EXE ${CMAKE_COMMAND})
		else()
			dk_set(CMAKE_EXE $ENV{DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake.exe)
			if(NOT EXISTS ${CMAKE_EXE})
				### INSTALL ###
				dk_info("Installing CMake . . .")
				dk_download(${cmake_Import} $ENV{DKDOWNLOAD_DIR})			
				dk_nativePath("$ENV{DKDOWNLOAD_DIR}/${cmake_Import_FILE}" CMAKE_INSTALL_FILE)
				dk_nativePath("$ENV{DKTOOLS_DIR}/${CMAKE_FOLDER}" CMAKE_INSTALL_PATH)
				dk_exec(MsiExec.exe /i "${CMAKE_INSTALL_FILE}" INSTALL_ROOT=${CMAKE_INSTALL_PATH})
			endif()
		endif()
	else()
		dk_findProgram(CMAKE_EXE cmake)
		if(NOT EXISTS ${CMAKE_EXE})
			dk_installPackage(cmake)
			dk_findProgram(CMAKE_EXE cmake)
		endif()
	endif()
endif()




#if(NOT EXISTS ${CMAKE_COMMAND})
#	dk_fatal("CMAKE_COMMAND:${CMAKE_COMMAND} does not exist")
#endif()
#if(NOT CMAKE_EXE)
#	dk_notice("CMAKE_EXE:${CMAKE_EXE} is empty. setting to ${CMAKE_COMMAND}")
#	set(CMAKE_EXE "${CMAKE_COMMAND}" CACHE INTERNAL "" FORCE)
#endif()
#
#if(NOT EXISTS ${CMAKE_EXE})
#	dk_fatal("CMAKE_EXE:${CMAKE_EXE} does not exist")
#endif()
#
#dk_set(CMAKE_EXE ${CMAKE_EXE}) # make the variable persistent


