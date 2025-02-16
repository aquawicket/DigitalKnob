#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##############################################################################
# dk_cmakePolicies()
#
#	https://cmake.org/cmake/help/latest/manual/cmake-policies.7.html
#
function(dk_cmakePolicies) 
	#dk_debugFunc(0)

	if(POLICY CMP0001)
		cmake_policy(SET CMP0001 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0001.html	cmake 2.6.0  - CMAKE_BACKWARDS_COMPATIBILITY should no longer be used.
	endif()
	if(POLICY CMP0002)
		cmake_policy(SET CMP0002 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0002.html	cmake 2.6.0  - Logical target names must be globally unique.
	endif()
		cmake_policy(SET CMP0003 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0003.html	cmake 2.6.0  - Libraries linked via full path no longer produce linker search paths.
		cmake_policy(SET CMP0004 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0004.html	cmake 2.6.0  - Libraries linked may not have leading or trailing whitespace.
		cmake_policy(SET CMP0005 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0005.html	cmake 2.6.0  - Preprocessor definition values are now escaped automatically.
		cmake_policy(SET CMP0006 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0006.html	cmake 2.6.0  - Installing MACOSX_BUNDLE targets requires a BUNDLE DESTINATION.
		cmake_policy(SET CMP0007 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0007.html	cmake 2.6.0  - list command no longer ignores empty elements.
		cmake_policy(SET CMP0008 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0008.html	cmake 2.6.1  - Libraries linked by full-path must have a valid library file name.
		cmake_policy(SET CMP0009 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0009.html	cmake 2.6.2  - FILE GLOB_RECURSE calls should not follow symlinks by default.
		cmake_policy(SET CMP0010 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0010.html	cmake 2.6.3  - Bad variable reference syntax is an error.
		cmake_policy(SET CMP0011 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0011.html	cmake 2.6.3  - Included scripts do automatic cmake_policy() PUSH and POP.
		cmake_policy(SET CMP0012 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0012.html	cmake 2.8.0  - if() recognizes numbers and boolean constants.
		cmake_policy(SET CMP0013 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0013.html	cmake 2.6.3  - Duplicate binary directories are not allowed.
		cmake_policy(SET CMP0014 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0014.html	cmake 2.8.0  - Input directories must have CMakeLists.txt.
		cmake_policy(SET CMP0015 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0015.html	cmake 2.8.1  - link_directories() treats paths relative to the source dir.
		cmake_policy(SET CMP0016 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0016.html	cmake 2.8.3  - target_link_libraries() reports error if its only argument is not a target.
		cmake_policy(SET CMP0017 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0017.html	cmake 2.8.4  - Prefer files from the CMake module directory when including from there.
		cmake_policy(SET CMP0018 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0018.html	cmake 2.8.9  - Ignore CMAKE_SHARED_LIBRARY_<Lang>_FLAGS variable.
		cmake_policy(SET CMP0019 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0019.html	cmake 2.8.11 - Do not re-expand variables in include and link information.
		cmake_policy(SET CMP0020 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0020.html	cmake 2.8.11 - Automatically link Qt executables to qtmain target on Windows.
		cmake_policy(SET CMP0021 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0021.html	cmake 2.8.12 - Fatal error on relative paths in INCLUDE_DIRECTORIES target property.
		cmake_policy(SET CMP0022 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0022.html	cmake 2.8.12 - INTERFACE_LINK_LIBRARIES defines the link interface.
		cmake_policy(SET CMP0023 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0023.html	cmake 2.8.12 - Plain and keyword target_link_libraries() signatures cannot be mixed.
		cmake_policy(SET CMP0024 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0024.html	cmake 2.8.13 - Disallow include export result.
		cmake_policy(SET CMP0025 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0025.html	cmake
		cmake_policy(SET CMP0026 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0026.html	cmake
		cmake_policy(SET CMP0027 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0027.html	cmake
		cmake_policy(SET CMP0028 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0028.html	cmake
		cmake_policy(SET CMP0029 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0029.html	cmake
		cmake_policy(SET CMP0030 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0030.html	cmake
		cmake_policy(SET CMP0031 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0031.html	cmake
		cmake_policy(SET CMP0032 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0032.html	cmake
		cmake_policy(SET CMP0033 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0033.html	cmake
		cmake_policy(SET CMP0034 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0034.html	cmake
		cmake_policy(SET CMP0035 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0035.html	cmake
		cmake_policy(SET CMP0036 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0036.html	cmake
		cmake_policy(SET CMP0037 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0037.html	cmake
		cmake_policy(SET CMP0038 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0038.html	cmake
		cmake_policy(SET CMP0039 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0039.html	cmake
		cmake_policy(SET CMP0040 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0040.html	cmake
		cmake_policy(SET CMP0041 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0041.html	cmake
		cmake_policy(SET CMP0042 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0042.html	cmake
		cmake_policy(SET CMP0043 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0043.html	cmake
		cmake_policy(SET CMP0044 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0044.html	cmake
		cmake_policy(SET CMP0045 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0045.html	cmake
		cmake_policy(SET CMP0046 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0046.html	cmake
		cmake_policy(SET CMP0047 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0047.html	cmake
		cmake_policy(SET CMP0048 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0048.html	cmake
		cmake_policy(SET CMP0049 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0049.html	cmake
		cmake_policy(SET CMP0050 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0050.html	cmake
		cmake_policy(SET CMP0051 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0051.html	cmake
		cmake_policy(SET CMP0052 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0052.html	cmake
		cmake_policy(SET CMP0053 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0053.html	cmake
		cmake_policy(SET CMP0054 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0054.html	cmake 3.1.0 - Only interpret if() arguments as variables or keywords when unquoted.
		cmake_policy(SET CMP0055 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0055.html	cmake
		cmake_policy(SET CMP0056 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0056.html	cmake
		cmake_policy(SET CMP0057 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0057.html	cmake 3.3.0 - Support new if() IN_LIST operator.
		cmake_policy(SET CMP0121 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0121.html	cmake 3.21.0 - The list() command now detects invalid indices.
		cmake_policy(SET CMP0126 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0126.html   cmake 3.21.0 - set(CACHE) command does not remove any normal variable of the same name
		cmake_policy(SET CMP0127 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0127.html	cmake 3.22
		cmake_policy(SET CMP0128 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0128.html	cmake 3.22
		cmake_policy(SET CMP0129 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0129.html	cmake 3.23
		cmake_policy(SET CMP0130 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0130.html	cmake 3.24
		cmake_policy(SET CMP0131 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0131.html	cmake 3.24
		cmake_policy(SET CMP0132 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0132.html	cmake 3.24
		cmake_policy(SET CMP0133 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0133.html	cmake 3.24
		cmake_policy(SET CMP0134 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0134.html	cmake 3.24
		cmake_policy(SET CMP0135 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0135.html	cmake 3.24
		cmake_policy(SET CMP0136 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0136.html	cmake 3.24
		cmake_policy(SET CMP0137 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0137.html	cmake 3.24
		cmake_policy(SET CMP0138 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0138.html	cmake 3.24
		cmake_policy(SET CMP0139 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0139.html	cmake 3.24
		cmake_policy(SET CMP0140 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0140.html	cmake 3.25
		cmake_policy(SET CMP0141 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0141.html	cmake 3.25
		cmake_policy(SET CMP0142 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0142.html	cmake 3.25
		cmake_policy(SET CMP0143 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0143.html	cmake 3.26
		cmake_policy(SET CMP0144 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0144.html	cmake 3.27
		cmake_policy(SET CMP0145 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0145.html	cmake 3.27
		cmake_policy(SET CMP0146 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0146.html	cmake 3.27
		cmake_policy(SET CMP0147 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0147.html	cmake 3.27
		cmake_policy(SET CMP0148 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0148.html	cmake 3.27
		cmake_policy(SET CMP0149 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0149.html	cmake 3.27
		cmake_policy(SET CMP0150 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0150.html	cmake 3.27
		cmake_policy(SET CMP0151 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0151.html	cmake 3.27
		cmake_policy(SET CMP0152 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0152.html	cmake 3.28
		cmake_policy(SET CMP0153 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0153.html	cmake 3.28
		cmake_policy(SET CMP0154 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0154.html	cmake 3.28
		cmake_policy(SET CMP0155 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0155.html	cmake 3.28
		cmake_policy(SET CMP0156 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0156.html	cmake 3.29
		cmake_policy(SET CMP0157 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0157.html	cmake 3.29
		cmake_policy(SET CMP0158 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0158.html	cmake 3.29 - add_test() honors CMAKE_CROSSCOMPILING_EMULATOR only when cross-compiling.
		cmake_policy(SET CMP0159 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0159.html	cmake 3.29
	if(POLICY CMP0160)
		cmake_policy(SET CMP0160 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0160.html	cmake 3.29
	endif()
	if(POLICY CMP0161)
		cmake_policy(SET CMP0161 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0161.html	cmake 3.29
	endif()
	if(POLICY CMP0162)
		cmake_policy(SET CMP0162 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0162.html	cmake 3.30
	endif()
	if(POLICY CMP0163)
		cmake_policy(SET CMP0163 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0163.html	cmake 3.30
	endif()
	if(POLICY CMP0164)
		cmake_policy(SET CMP0164 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0164.html	cmake 3.30
	endif()
	if(POLICY CMP0165)
		cmake_policy(SET CMP0165 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0165.html	cmake 3.30
	endif()
	if(POLICY CMP0166)
		cmake_policy(SET CMP0166 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0166.html	cmake 3.30
	endif()
	if(POLICY CMP0167)
		cmake_policy(SET CMP0167 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0167.html	cmake 3.30
	endif()
	if(POLICY CMP0168)
		cmake_policy(SET CMP0168 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0168.html	cmake 3.30
	endif()
	if(POLICY CMP0169)
		cmake_policy(SET CMP0169 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0169.html	cmake 3.30
	endif()
	if(POLICY CMP0170)
		cmake_policy(SET CMP0170 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0170.html	cmake 3.30
	endif()
	if(POLICY CMP0171)
		cmake_policy(SET CMP0171 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0171.html	cmake 3.31
	endif()
	if(POLICY CMP0172)
		cmake_policy(SET CMP0172 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0172.html	cmake 3.31
	endif()
	if(POLICY CMP0173)
		cmake_policy(SET CMP0173 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0173.html	cmake 3.31
	endif()
	if(POLICY CMP0174)	
		cmake_policy(SET CMP0174 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0174.html	cmake 3.31
	endif()
	if(POLICY CMP0175)
		cmake_policy(SET CMP0175 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0175.html	cmake 3.31
	endif()
	if(POLICY CMP0176)
		cmake_policy(SET CMP0176 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0176.html	cmake 3.31
	endif()
	if(POLICY CMP077)
		cmake_policy(SET CMP0177 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0177.html	cmake 3.31
	endif()
	if(POLICY CMP0178)
		cmake_policy(SET CMP0178 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0178.html	cmake 3.31
	endif()
	if(POLICY CMP0179)
		cmake_policy(SET CMP0179 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0179.html	cmake 3.31
	endif()
	if(POLICY CMP0180)
		cmake_policy(SET CMP0180 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0180.html  	cmake 3.31
	endif()
	
endfunction()









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc(0)
	
	dk_cmakePolicies()
endfunction()