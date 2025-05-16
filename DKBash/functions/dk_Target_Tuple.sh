#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


###############################################################################
# dk_Target_Tuple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  Win_X86_64_Clang
#
#	If the CMAKE_BINARY_DIR is missing the <Target_Os> or the <Target_Arch>, dk_Target_Tuple_SET will be called to get those variables
#
#   <Target_Os>_<Target_Arch>				= Android_Arm64, Emscripten_Arm64, Ios_Arm64, Iossim_Arm64, Linux_Arm64, Mac_Arm64, Raspberry_Arm64, Windows_Arm64
#   <Target_Os>_<Target_Arch>_<Target_Env>	= Android_Arm64_Clang, Emscripten_Arm64_Clang, Ios_Arm64_Clang, Iossim_Arm64_Clang, Linux_Arm64_Clang, Mac_Arm64_Clang, Raspberry_Arm64_Clang, Windows_Arm64_Clang
#
dk_Target_Tuple() {
	dk_debugFunc 0

	#CMAKE_BINARY_DIR="C:/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/Win_X86_64_Clang/Debug"
	default_Target_Env="clang"

	### Get Target_Dir ###
	dk_call dk_realpath "${CMAKE_BINARY_DIR}" Target_Dir
	dk_call dk_printVar Target_Dir 							# Target_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/Win_X86_64_Clang/Debug

	#### Set Target_Type / TARGET_TYPE ###
	if [ "${Target_Dir}" = "Debug" ]; then	
		### Get DEBUG ###
		dk_call dk_set Target_Type DEBUG					# Target_Type	= DEBUG
		dk_call dk_set ${Target_Type} 1					# DEBUG = 1	
		dk_call dk_dirname Target_Dir Target_Tuple_Dir		# Target_Tuple_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/Win_X86_64_Clang
	elif [ "${Target_Dir}" = "Release" ]; then
		### Get RELEASE ###
		dk_call dk_set Target_Type RELEASE 				# Target_Type = RELEASE
		dk_call dk_set ${Target_Type} 1					# RELEASE = 1	
		dk_call dk_dirname ${Target_Dir} Target_Tuple_Dir	# Target_Tuple_Dir = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/Win_X86_64_Clang
	fi

	if ( ( dk_call dk_containsCI "${Target_Dir}" "Android"      ) ||
		 ( dk_call dk_containsCI "${Target_Dir}" "Android"      ) ||
		 ( dk_call dk_containsCI "${Target_Dir}" "Emscripten"   ) ||
		 ( dk_call dk_containsCI "${Target_Dir}" "Ios"          ) ||
		 ( dk_call dk_containsCI "${Target_Dir}" "Iossim"       ) ||
		 ( dk_call dk_containsCI "${Target_Dir}" "Linux"        ) ||
		 ( dk_call dk_containsCI "${Target_Dir}" "Mac"          ) ||
		 ( dk_call dk_containsCI "${Target_Dir}" "Raspberry"    ) ||
		 ( dk_call dk_containsCI "${Target_Dir}" "Windows"      ) ||
		 ( dk_call dk_containsCI "${Target_Dir}" "Cosmopolitan"	) ); then
		     dk_call dk_set Target_Tuple_Dir ${Target_Dir}
	else
		dk_call dk_Target_Tuple_SET
		dk_call dk_set Target_Tuple_Dir ${Target_Dir}/${Target_Tuple}
	fi

	if [ -e "${Target_Tuple_Dir}" ]; then
		dk_call dk_assertPath Target_Tuple_Dir
	else
		dk_call dk_warning "Target_Tuple_Dir:${Target_Tuple_Dir} does not exits."
		dk_call dk_debug "Creating directory . . .${Target_Tuple_Dir}"
		dk_call dk_mkdir "${Target_Tuple_Dir}"
	fi

	#### Set DK_PROJECT_DIR ###
	dk_call dk_dirname "${Target_Tuple_Dir}" DK_PROJECT_DIR
	dk_call dk_set DK_PROJECT_DIR "${DK_PROJECT_DIR}"
	dk_call dk_assertPath DK_PROJECT_DIR

	#### Set Target_Tuple, <Target_Os>_<Target_Arch>_<Target_Env> ###
	dk_call dk_basename ${Target_Tuple_Dir} Target_Tuple		# Target_Tuple 	= Win_X86_64_Clang
	dk_call dk_set Target_Tuple ${Target_Tuple}					# Globalize the variable
	dk_call dk_set ${Target_Tuple} 1							# Win_X86_64_Clang = 1

	#### Set Target_Os / <Target_Os>_Target
	dk_call dk_containsCI "${Target_Tuple}" "Android" 		&& dk_call dk_set Target_Os Android
	dk_call dk_containsCI "${Target_Tuple}" "Emscripten" 	&& dk_call dk_set Target_Os Emscripten
	dk_call dk_containsCI "${Target_Tuple}" "Iossim" 		&& dk_call dk_set Target_Os Iossim 
	dk_call dk_containsCI "${Target_Tuple}" "Ios" 			&& dk_call dk_set Target_Os Ios
	dk_call dk_containsCI "${Target_Tuple}" "Linux" 		&& dk_call dk_set Target_Os Linux
	dk_call dk_containsCI "${Target_Tuple}" "Mac" 			&& dk_call dk_set Target_Os Mac
	dk_call dk_containsCI "${Target_Tuple}" "Raspberry" 	&& dk_call dk_set Target_Os Raspberry
	dk_call dk_containsCI "${Target_Tuple}" "Windows" 		&& dk_call dk_set Target_Os Windows
	dk_call dk_containsCI "${Target_Tuple}" "Win"			&& dk_call dk_set Target_Os Win
	dk_call dk_containsCI "${Target_Tuple}" "Cosmopolitan"	&& dk_call dk_set Target_Os Cosmopolitan
	if [ -z "${Target_Os-}" ]; then
		# dk_call dk_warning "The target Target_Tuple:${Target_Tuple} does not contain a valid Target_Os"
		dk_call dk_unset Target_Tuple
		dk_call dk_unset Target_Tuple 
		dk_call dk_Target_Tuple_SET
	else
		dk_call dk_set Target_Os ${Target_Os}
		dk_call dk_set ${Target_Os} 1
		dk_call dk_set ${Target_Os}_Target 1
	fi
	
	#### Get Target_Arch
	dk_call dk_containsCI "${Target_Tuple}" "Arm64" 			&& dk_call dk_set Target_Arch arm64
	dk_call dk_containsCI "${Target_Tuple}" "Arm32" 			&& dk_call dk_set Target_Arch arm32
	dk_call dk_containsCI "${Target_Tuple}" "X86_64" 			&& dk_call dk_set Target_Arch x86_64
	dk_call dk_containsCI "${Target_Tuple}" "X86" 				&& dk_call dk_set Target_Arch x86
	dk_call dk_containsCI "${Target_Tuple}" "Cosmopolitan" 		&& dk_call dk_set Target_Arch Cosmopolitan	
	
	if [ -z "${Target_Arch-}" ]; then
		dk_call dk_warning "The target Target_Tuple:${Target_Tuple} does not contain a valid Target_Arch"
		dk_call dk_Target_Tuple_SET
	else
		dk_call dk_set Target_Arch ${Target_Arch}
		dk_call dk_set ${Target_Arch} 1
		dk_call dk_set ${Target_Arch}_Target 1
	fi

	#### Set Target_Env 
	dk_call dk_containsCI "${Target_Tuple}" "Clang" 			&& dk_call dk_set Target_Env Clang
	dk_call dk_containsCI "${Target_Tuple}" "MinGW" 			&& dk_call dk_set Target_Env MinGW
	dk_call dk_containsCI "${Target_Tuple}" "Ucrt"  			&& dk_call dk_set Target_Env Ucrt
	dk_call dk_containsCI "${Target_Tuple}" "Msvc"  			&& dk_call dk_set Target_Env Msvc
	dk_call dk_containsCI "${Target_Tuple}" "Cosmopolitan" 		&& dk_call dk_set Target_Env Cosmopolitan
	if [ -z "${Target_Env-}" ]; then
		dk_call dk_warning "The target Target_Tuple:${Target_Tuple} does not contain a valid Target_Env"
		dk_call dk_set Target_Env ${default_Target_Env}
	else
		dk_call dk_set ${Target_Env} 1
		dk_call dk_set ${Target_Env}_Target 1
	fi

	#### Set MSYSTEM
	if [ -n "${Target_Env-}" ]; then
		if [ -n "${CLANG-}" ]; then 
			if [ -n "${ARM64-}" ]; then
				dk_call dk_set Msystem "${Target_Env}${Target_Arch}"	# Msystem = Clangarm64
			elif [ -n "${X86_64-}" ]; then
				dk_call dk_set Msystem "${Target_Env}64"				# Msystem = Clang64, MinGW64, Ucrt64
			elif [ -n "${X86-}" ]; then
				dk_call dk_set Msystem "${Target_Env}32"				# Msystem = Clang32, MinGW32
			else
				dk_call dk_fatal "The target Target_Tuple:${Target_Tuple} does not contain a valid Target_Env or msystem"
			fi
		fi
		dk_call dk_set ${Msystem} 1										# Clangarm64, Clang64, Clang32, MinGW64, MinGW32, Ucrt64 = 1
	fi
	
	### Set Target_Os_arch / Target_Os_ARCH ###
	dk_call dk_set Target_Os_Arch "${Target_Os}_${Target_Arch}"
	dk_call dk_set ${Target_Os_Arch} 1
	dk_call dk_set ${Target_Os_Arch}_Target 1

	#### Set DEBUG_DIR and RELEASE_DIR variables
	if [ -n "${IOS-}" ]; then
		dk_call dk_set DEBUG_DIR Debug-iphoneos
		dk_call dk_set RELEASE_DIR Release-iphoneos
	elif [ -n "${IOSSIM-}" ]; then
		dk_call dk_set DEBUG_DIR Debug-iphonesimulator
		dk_call dk_set RELEASE_DIR Release-iphonesimulator
	else
		dk_call dk_set DEBUG_DIR Debug
		dk_call dk_set RELEASE_DIR Release
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_Target_Tuple
}
