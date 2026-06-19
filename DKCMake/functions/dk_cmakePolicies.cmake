#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_cmakePolicies()
#
#	https://cmake.org/cmake/help/latest/manual/cmake-policies.7.html
#
function(dk_cmakePolicies) 
	#dk_debugFunc(0)

	if(POLICY CMP0001) # https://cmake.org/cmake/help/latest/policy/CMP0001.html 2.6.0 CMAKE_BACKWARDS_COMPATIBILITY should no longer be used.
		cmake_policy(SET CMP0001 NEW) 
	endif()
	if(POLICY CMP0002) # https://cmake.org/cmake/help/latest/policy/CMP0002.html 2.6.0 Logical target names must be globally unique.
		cmake_policy(SET CMP0002 NEW) 
	endif()
	if(POLICY CMP0003) # https://cmake.org/cmake/help/latest/policy/CMP0003.html 2.6.0 Libraries linked via full path no longer produce linker search paths.
		cmake_policy(SET CMP0003 NEW) 
	endif()
	if(POLICY CMP0004) # https://cmake.org/cmake/help/latest/policy/CMP0004.html 2.6.0 Libraries linked may not have leading or trailing whitespace.
		cmake_policy(SET CMP0004 NEW) 
	endif()
	if(POLICY CMP0005) # https://cmake.org/cmake/help/latest/policy/CMP0005.html 2.6.0 Preprocessor definition values are now escaped automatically.
		cmake_policy(SET CMP0005 NEW) 
	endif()
	if(POLICY CMP0006) # https://cmake.org/cmake/help/latest/policy/CMP0006.html 2.6.0 Installing MACOSX_BUNDLE targets requires a BUNDLE DESTINATION.
		cmake_policy(SET CMP0006 NEW) 
	endif()
	if(POLICY CMP0007) # https://cmake.org/cmake/help/latest/policy/CMP0007.html 2.6.0 list command no longer ignores empty elements.
		cmake_policy(SET CMP0007 NEW) 
	endif()
	if(POLICY CMP0008) # https://cmake.org/cmake/help/latest/policy/CMP0008.html 2.6.1 Libraries linked by full-path must have a valid library file name.
		cmake_policy(SET CMP0008 NEW) 
	endif()
	if(POLICY CMP0009) # https://cmake.org/cmake/help/latest/policy/CMP0009.html 2.6.2 FILE GLOB_RECURSE calls should not follow symlinks by default.
		cmake_policy(SET CMP0009 NEW) 
	endif()
	if(POLICY CMP0010) # https://cmake.org/cmake/help/latest/policy/CMP0010.html 2.6.3 Bad variable reference syntax is an error.
		cmake_policy(SET CMP0010 NEW) 
	endif()
	if(POLICY CMP0011) # https://cmake.org/cmake/help/latest/policy/CMP0011.html 2.6.3 Included scripts do automatic cmake_policy() PUSH and POP.
		cmake_policy(SET CMP0011 NEW) 
	endif()
	if(POLICY CMP0012) # https://cmake.org/cmake/help/latest/policy/CMP0012.html 2.8.0 if() recognizes numbers and boolean constants.
		cmake_policy(SET CMP0012 NEW) 
	endif()
	if(POLICY CMP0013) # https://cmake.org/cmake/help/latest/policy/CMP0013.html 2.6.3 Duplicate binary directories are not allowed.
		cmake_policy(SET CMP0013 NEW)
	endif()
	if(POLICY CMP0014) # https://cmake.org/cmake/help/latest/policy/CMP0014.html 2.8.0 Input directories must have CMakeLists.txt.
		cmake_policy(SET CMP0014 NEW) 
	endif()
	if(POLICY CMP0015) # https://cmake.org/cmake/help/latest/policy/CMP0015.html 2.8.1 link_directories() treats paths relative to the source dir.
		cmake_policy(SET CMP0015 NEW) 
	endif()
	if(POLICY CMP0016) # https://cmake.org/cmake/help/latest/policy/CMP0016.html 2.8.3 target_link_libraries() reports error if its only argument is not a target.
		cmake_policy(SET CMP0016 NEW) 
	endif()
	if(POLICY CMP0017) # https://cmake.org/cmake/help/latest/policy/CMP0017.html 2.8.4 Prefer files from the CMake module directory when including from there.
		cmake_policy(SET CMP0017 NEW) 
	endif()
	if(POLICY CMP0018) # https://cmake.org/cmake/help/latest/policy/CMP0018.html 2.8.9 Ignore CMAKE_SHARED_LIBRARY_<Lang>_FLAGS variable.
		cmake_policy(SET CMP0018 NEW) 
	endif()
	if(POLICY CMP0019) # https://cmake.org/cmake/help/latest/policy/CMP0019.html 2.8.11 Do not re-expand variables in include and link information.
		cmake_policy(SET CMP0019 NEW) 
	endif()
	if(POLICY CMP0020) # https://cmake.org/cmake/help/latest/policy/CMP0020.html 2.8.11 Automatically link Qt executables to qtmain target on Windows.
		cmake_policy(SET CMP0020 NEW) 
	endif()
	if(POLICY CMP0021) # https://cmake.org/cmake/help/latest/policy/CMP0021.html 2.8.12 Fatal error on relative paths in INCLUDE_DIRECTORIES target property.
		cmake_policy(SET CMP0021 NEW) 
	endif()
	if(POLICY CMP0022) # https://cmake.org/cmake/help/latest/policy/CMP0022.html 2.8.12 INTERFACE_LINK_LIBRARIES defines the link interface.
		cmake_policy(SET CMP0022 NEW) 
	endif()
	if(POLICY CMP0023) # https://cmake.org/cmake/help/latest/policy/CMP0023.html 2.8.12 Plain and keyword target_link_libraries() signatures cannot be mixed.
		cmake_policy(SET CMP0023 NEW) 
	endif()
	if(POLICY CMP0024) # https://cmake.org/cmake/help/latest/policy/CMP0024.html 2.8.13 Disallow include export result.
		cmake_policy(SET CMP0024 NEW) 
	endif()
	if(POLICY CMP0025) # https://cmake.org/cmake/help/latest/policy/CMP0025.html	
		cmake_policy(SET CMP0025 NEW) 
	endif()
	if(POLICY CMP0026) # https://cmake.org/cmake/help/latest/policy/CMP0026.html	
		cmake_policy(SET CMP0026 NEW) 
	endif()
	if(POLICY CMP0027) # https://cmake.org/cmake/help/latest/policy/CMP0027.html	
		cmake_policy(SET CMP0027 NEW) 
	endif()
	if(POLICY CMP0028) # https://cmake.org/cmake/help/latest/policy/CMP0028.html	
		cmake_policy(SET CMP0028 NEW) 
	endif()
	if(POLICY CMP0029) # https://cmake.org/cmake/help/latest/policy/CMP0029.html	
		cmake_policy(SET CMP0029 NEW) 
	endif()
	if(POLICY CMP0030) # https://cmake.org/cmake/help/latest/policy/CMP0030.html	
		cmake_policy(SET CMP0030 NEW) 
	endif()
	if(POLICY CMP0031) # https://cmake.org/cmake/help/latest/policy/CMP0031.html	
		cmake_policy(SET CMP0031 NEW) 
	endif()
	if(POLICY CMP0032) # https://cmake.org/cmake/help/latest/policy/CMP0032.html	
		cmake_policy(SET CMP0032 NEW) 
	endif()
	if(POLICY CMP0033) # https://cmake.org/cmake/help/latest/policy/CMP0033.html	
		cmake_policy(SET CMP0033 NEW)
	endif()
	if(POLICY CMP0034) # https://cmake.org/cmake/help/latest/policy/CMP0034.html			 
		cmake_policy(SET CMP0034 NEW) 
	endif()
	if(POLICY CMP0035) # https://cmake.org/cmake/help/latest/policy/CMP0035.html	
		cmake_policy(SET CMP0035 NEW) 
	endif()
	if(POLICY CMP0036) # https://cmake.org/cmake/help/latest/policy/CMP0036.html	
		cmake_policy(SET CMP0036 NEW) 
	endif()
	if(POLICY CMP0037) # https://cmake.org/cmake/help/latest/policy/CMP0037.html	
		cmake_policy(SET CMP0037 NEW) 
	endif()
	if(POLICY CMP0038) # https://cmake.org/cmake/help/latest/policy/CMP0038.html	
		cmake_policy(SET CMP0038 NEW) 
	endif()
	if(POLICY CMP0039) # https://cmake.org/cmake/help/latest/policy/CMP0039.html	
		cmake_policy(SET CMP0039 NEW) 
	endif()
	if(POLICY CMP0040) # https://cmake.org/cmake/help/latest/policy/CMP0040.html	
		cmake_policy(SET CMP0040 NEW) 
	endif()
	if(POLICY CMP0041) # https://cmake.org/cmake/help/latest/policy/CMP0041.html	
		cmake_policy(SET CMP0041 NEW) 
	endif()
	if(POLICY CMP0042) # https://cmake.org/cmake/help/latest/policy/CMP0042.html	
		cmake_policy(SET CMP0042 NEW) 
	endif()
	if(POLICY CMP0043) # https://cmake.org/cmake/help/latest/policy/CMP0043.html		
		cmake_policy(SET CMP0043 NEW) 
	endif()
	if(POLICY CMP0044) # https://cmake.org/cmake/help/latest/policy/CMP0044.html	
		cmake_policy(SET CMP0044 NEW) 
	endif()
	if(POLICY CMP0045) # https://cmake.org/cmake/help/latest/policy/CMP0045.html
		cmake_policy(SET CMP0045 NEW) 	
	endif()
	if(POLICY CMP0046) # https://cmake.org/cmake/help/latest/policy/CMP0046.html	
		cmake_policy(SET CMP0046 NEW) 
	endif()
	if(POLICY CMP0047) # https://cmake.org/cmake/help/latest/policy/CMP0047.html	
		cmake_policy(SET CMP0047 NEW) 
	endif()
	if(POLICY CMP0048) # https://cmake.org/cmake/help/latest/policy/CMP0048.html	
		cmake_policy(SET CMP0048 NEW) 
	endif()
	if(POLICY CMP0049) # https://cmake.org/cmake/help/latest/policy/CMP0049.html	
		cmake_policy(SET CMP0049 NEW) 
	endif()
	if(POLICY CMP0050) # https://cmake.org/cmake/help/latest/policy/CMP0050.html	
		cmake_policy(SET CMP0050 NEW) 
	endif()
	if(POLICY CMP0051) # https://cmake.org/cmake/help/latest/policy/CMP0051.html	
		cmake_policy(SET CMP0051 NEW) 
	endif()
	if(POLICY CMP0052) # https://cmake.org/cmake/help/latest/policy/CMP0052.html	
		cmake_policy(SET CMP0052 NEW) 
	endif()
	if(POLICY CMP0053) # https://cmake.org/cmake/help/latest/policy/CMP0053.html	
		cmake_policy(SET CMP0053 NEW) 
	endif()
	if(POLICY CMP0054) # https://cmake.org/cmake/help/latest/policy/CMP0054.html 3.1.0 Only interpret if() arguments as variables or keywords when unquoted.
		cmake_policy(SET CMP0054 NEW) 
	endif()
	if(POLICY CMP0055) # https://cmake.org/cmake/help/latest/policy/CMP0055.html	
		cmake_policy(SET CMP0055 NEW) 
	endif()
	if(POLICY CMP0056) # https://cmake.org/cmake/help/latest/policy/CMP0056.html	
		cmake_policy(SET CMP0056 NEW) 
	endif()
	if(POLICY CMP0057) # https://cmake.org/cmake/help/latest/policy/CMP0057.html 3.3.0 Support new if() IN_LIST operator.
		cmake_policy(SET CMP0057 NEW) 
	endif()
	if(POLICY CMP0121) # https://cmake.org/cmake/help/latest/policy/CMP0121.html 3.21.0 The list() command now detects invalid indices.
		cmake_policy(SET CMP0121 NEW) 
	endif()
	if(POLICY CMP0126) # https://cmake.org/cmake/help/latest/policy/CMP0126.html 3.21.0 set(CACHE) command does not remove any normal variable of the same name
		cmake_policy(SET CMP0126 NEW) 
	endif()
	if(POLICY CMP0127) # https://cmake.org/cmake/help/latest/policy/CMP0127.html 3.22
		cmake_policy(SET CMP0127 NEW) 
	endif()
	if(POLICY CMP0128) # https://cmake.org/cmake/help/latest/policy/CMP0128.html 3.22
		cmake_policy(SET CMP0128 NEW) 
	endif()
	if(POLICY CMP0129) # https://cmake.org/cmake/help/latest/policy/CMP0129.html 3.23
		cmake_policy(SET CMP0129 NEW) 
	endif()
	if(POLICY CMP0130) # https://cmake.org/cmake/help/latest/policy/CMP0130.html 3.24
		cmake_policy(SET CMP0130 NEW) 
	endif()
	if(POLICY CMP0131) # https://cmake.org/cmake/help/latest/policy/CMP0131.html 3.24
		cmake_policy(SET CMP0131 NEW) 
	endif()
	if(POLICY CMP0132) # https://cmake.org/cmake/help/latest/policy/CMP0132.html 3.24
		cmake_policy(SET CMP0132 NEW) 
	endif()
	if(POLICY CMP0133) # https://cmake.org/cmake/help/latest/policy/CMP0133.html 3.24
		cmake_policy(SET CMP0133 NEW) 
	endif()
	if(POLICY CMP0134) # https://cmake.org/cmake/help/latest/policy/CMP0134.html 3.24
		cmake_policy(SET CMP0134 NEW) 
	endif()
	if(POLICY CMP0135) # https://cmake.org/cmake/help/latest/policy/CMP0135.html 3.24
		cmake_policy(SET CMP0135 NEW) 
	endif()
	if(POLICY CMP0136) # https://cmake.org/cmake/help/latest/policy/CMP0136.html 3.24
		cmake_policy(SET CMP0136 NEW) 
	endif()
	if(POLICY CMP0137) # https://cmake.org/cmake/help/latest/policy/CMP0137.html 3.24
		cmake_policy(SET CMP0137 NEW) 
	endif()
	if(POLICY CMP0138) # https://cmake.org/cmake/help/latest/policy/CMP0138.html 3.24
		cmake_policy(SET CMP0138 NEW) 
	endif()
	if(POLICY CMP0139) # https://cmake.org/cmake/help/latest/policy/CMP0139.html 3.24
		cmake_policy(SET CMP0139 NEW) 
	endif()
	if(POLICY CMP0140) # https://cmake.org/cmake/help/latest/policy/CMP0140.html 3.25
		cmake_policy(SET CMP0140 NEW) 
	endif()
	if(POLICY CMP0141) # https://cmake.org/cmake/help/latest/policy/CMP0141.html 3.25
		cmake_policy(SET CMP0141 NEW) 
	endif()
	if(POLICY CMP0142) # https://cmake.org/cmake/help/latest/policy/CMP0142.html 3.25
		cmake_policy(SET CMP0142 NEW) 
	endif()
	if(POLICY CMP0143) # https://cmake.org/cmake/help/latest/policy/CMP0143.html 3.26
		cmake_policy(SET CMP0143 NEW) 
	endif()
	if(POLICY CMP0144) # https://cmake.org/cmake/help/latest/policy/CMP0144.html 3.27
		cmake_policy(SET CMP0144 NEW) 
	endif()
	if(POLICY CMP0145) # https://cmake.org/cmake/help/latest/policy/CMP0145.html 3.27
		cmake_policy(SET CMP0145 NEW) 
	endif()
	if(POLICY CMP0146) # https://cmake.org/cmake/help/latest/policy/CMP0146.html 3.27
		cmake_policy(SET CMP0146 NEW) 
	endif()
	if(POLICY CMP0147) # https://cmake.org/cmake/help/latest/policy/CMP0147.html 3.27
		cmake_policy(SET CMP0147 NEW) 
	endif()
	if(POLICY CMP0148) # https://cmake.org/cmake/help/latest/policy/CMP0148.html 3.27
		cmake_policy(SET CMP0148 NEW) 
	endif()
	if(POLICY CMP0149) # https://cmake.org/cmake/help/latest/policy/CMP0149.html 3.27
		cmake_policy(SET CMP0149 NEW) 
	endif()
	if(POLICY CMP0150) # https://cmake.org/cmake/help/latest/policy/CMP0150.html 3.27
		cmake_policy(SET CMP0150 NEW) 
	endif()
	if(POLICY CMP0151) # https://cmake.org/cmake/help/latest/policy/CMP0151.html 3.27
		cmake_policy(SET CMP0151 NEW) 
	endif()
	if(POLICY CMP0152) # https://cmake.org/cmake/help/latest/policy/CMP0152.html 3.28
		cmake_policy(SET CMP0152 NEW) 
	endif()
	if(POLICY CMP0153) # https://cmake.org/cmake/help/latest/policy/CMP0153.html 3.28
		cmake_policy(SET CMP0153 NEW) 
	endif()
	if(POLICY CMP0154) # https://cmake.org/cmake/help/latest/policy/CMP0154.html 3.28
		cmake_policy(SET CMP0154 NEW) 
	endif()
	if(POLICY CMP0155) # https://cmake.org/cmake/help/latest/policy/CMP0155.html 3.28
		cmake_policy(SET CMP0155 NEW) 
	endif()
	if(POLICY CMP0156) # https://cmake.org/cmake/help/latest/policy/CMP0156.html 3.29
		cmake_policy(SET CMP0156 NEW) 
	endif()
	if(POLICY CMP0157) # https://cmake.org/cmake/help/latest/policy/CMP0157.html 3.29
		cmake_policy(SET CMP0157 NEW) 
	endif()
	if(POLICY CMP0158) # https://cmake.org/cmake/help/latest/policy/CMP0158.html 3.29 add_test() honors CMAKE_CROSSCOMPILING_EMULATOR only when cross-compiling.
		cmake_policy(SET CMP0158 NEW) 
	endif()
	if(POLICY CMP0159) # https://cmake.org/cmake/help/latest/policy/CMP0159.html 3.29
		cmake_policy(SET CMP0159 NEW) 
	endif()
	if(POLICY CMP0160) # https://cmake.org/cmake/help/latest/policy/CMP0160.html 3.29
		cmake_policy(SET CMP0160 NEW) 
	endif()
	if(POLICY CMP0161) # https://cmake.org/cmake/help/latest/policy/CMP0161.html 3.29
		cmake_policy(SET CMP0161 NEW) 
	endif()
	if(POLICY CMP0162) # https://cmake.org/cmake/help/latest/policy/CMP0162.html 3.30
		cmake_policy(SET CMP0162 NEW) 
	endif()
	if(POLICY CMP0163) # https://cmake.org/cmake/help/latest/policy/CMP0163.html 3.30
		cmake_policy(SET CMP0163 NEW) 
	endif()
	if(POLICY CMP0164) # https://cmake.org/cmake/help/latest/policy/CMP0164.html 3.30
		cmake_policy(SET CMP0164 NEW) 
	endif()
	if(POLICY CMP0165) # https://cmake.org/cmake/help/latest/policy/CMP0165.html 3.30
		cmake_policy(SET CMP0165 NEW) 
	endif()
	if(POLICY CMP0166) # https://cmake.org/cmake/help/latest/policy/CMP0166.html 3.30
		cmake_policy(SET CMP0166 NEW) 
	endif()
	if(POLICY CMP0167) # https://cmake.org/cmake/help/latest/policy/CMP0167.html 3.30
		cmake_policy(SET CMP0167 NEW) 
	endif()
	if(POLICY CMP0168) # https://cmake.org/cmake/help/latest/policy/CMP0168.html 3.30
		cmake_policy(SET CMP0168 NEW) 
	endif()
	if(POLICY CMP0169) # https://cmake.org/cmake/help/latest/policy/CMP0169.html 3.30
		cmake_policy(SET CMP0169 NEW) 
	endif()
	if(POLICY CMP0170) # https://cmake.org/cmake/help/latest/policy/CMP0170.html 3.30
		cmake_policy(SET CMP0170 NEW) 
	endif()
	if(POLICY CMP0171) # https://cmake.org/cmake/help/latest/policy/CMP0171.html 3.31
		cmake_policy(SET CMP0171 NEW) 
	endif()
	if(POLICY CMP0172) # https://cmake.org/cmake/help/latest/policy/CMP0172.html 3.31
		cmake_policy(SET CMP0172 NEW) 
	endif()
	if(POLICY CMP0173) # https://cmake.org/cmake/help/latest/policy/CMP0173.html 3.31
		cmake_policy(SET CMP0173 NEW) 
	endif()
	if(POLICY CMP0174) # https://cmake.org/cmake/help/latest/policy/CMP0174.html 3.31
		cmake_policy(SET CMP0174 NEW) 
	endif()
	if(POLICY CMP0175) # https://cmake.org/cmake/help/latest/policy/CMP0175.html 3.31
		cmake_policy(SET CMP0175 NEW) 
	endif()
	if(POLICY CMP0176) # https://cmake.org/cmake/help/latest/policy/CMP0176.html 3.31
		cmake_policy(SET CMP0176 NEW) 
	endif()
	if(POLICY CMP0177) # https://cmake.org/cmake/help/latest/policy/CMP0177.html 3.31
		cmake_policy(SET CMP0177 NEW) 
	endif()
	if(POLICY CMP0178) # https://cmake.org/cmake/help/latest/policy/CMP0178.html 3.31
		cmake_policy(SET CMP0178 NEW) 
	endif()
	if(POLICY CMP0179) # https://cmake.org/cmake/help/latest/policy/CMP0179.html 3.31
		cmake_policy(SET CMP0179 NEW) 
	endif()
	if(POLICY CMP0180) # https://cmake.org/cmake/help/latest/policy/CMP0180.html 3.31
		cmake_policy(SET CMP0180 NEW) 
	endif()
	
endfunction()









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc(0)
	
	dk_cmakePolicies()
endfunction()