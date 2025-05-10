#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


###############################################################################
# dk_Target_Tuple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  win_x86_64_clang
#
#	If the CMAKE_BINARY_DIR is missing the <Target_Os> or the <Target_Arch>, dk_Target_Tuple_SET will be called to get those variables
#
#   <Target_Os>_<Target_Arch>				= Android_arm64, Emscripten_arm64, Ios_arm64, Iossim_arm64, Linux_arm64, Mac_arm64, Raspberry_arm64, windows_arm64
#   <Target_Os>_<Target_Arch>_<Target_Env>	= android_arm64_clang, emscripten_arm64_clang, ios_arm64_clang, iossim_arm64_clang, linux_arm64_clang, mac_arm64_clang, raspberry_arm64_clang, windows_arm64_clang
#
dk_Target_Tuple() {
	dk_debugFunc 0

	#CMAKE_BINARY_DIR="C:/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/win_x86_64_clang/Debug"
	default_Target_Env="clang"

	### Get TARGET_DIR ###
	dk_call dk_realpath "${CMAKE_BINARY_DIR}" TARGET_DIR
	dk_call dk_printVar TARGET_DIR 							# TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang/Debug

	#### Set target_type / TARGET_TYPE ###
	if [ "${TARGET_DIR}" = "Debug" ]; then	
		### Get DEBUG ###
		dk_call dk_set DKBUILD_TYPE DEBUG					# DKBUILD_TYPE	= DEBUG
		dk_call dk_set ${DKBUILD_TYPE} 1					# DEBUG = 1	
		dk_call dk_dirname TARGET_DIR TARGET_TUPLE_DIR		# TARGET_TUPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	elif [ "${TARGET_DIR}" = "Release" ]; then
		### Get RELEASE ###
		dk_call dk_set DKBUILD_TYPE RELEASE 				# DKBUILD_TYPE = RELEASE
		dk_call dk_set ${DKBUILD_TYPE} 1					# RELEASE = 1	
		dk_call dk_dirname ${TARGET_DIR} TARGET_TUPLE_DIR	# TARGET_TUPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	fi

	if ( ( dk_call dk_containsCI "${TARGET_DIR}" "android"      ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "android"      ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "emscripten"   ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "ios"          ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "iossim"       ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "linux"        ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "mac"          ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "raspberry"    ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "windows"      ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "cosmopolitan"	) ); then
		     dk_call dk_set TARGET_TUPLE_DIR ${TARGET_DIR}
	else
		dk_call dk_Target_Tuple_SET
		dk_call dk_set TARGET_TUPLE_DIR ${TARGET_DIR}/${Target_Tuple}
	fi

	if [ -e "${TARGET_TUPLE_DIR}" ]; then
		dk_call dk_assertPath TARGET_TUPLE_DIR
	else
		dk_call dk_warning "TARGET_TUPLE_DIR:${TARGET_TUPLE_DIR} does not exits."
		dk_call dk_debug "Creating directory . . .${TARGET_TUPLE_DIR}"
		dk_call dk_mkdir "${TARGET_TUPLE_DIR}"
	fi

	#### Set DK_PROJECT_DIR ###
	dk_call dk_dirname "${TARGET_TUPLE_DIR}" DK_PROJECT_DIR
	dk_call dk_set DK_PROJECT_DIR "${DK_PROJECT_DIR}"
	dk_call dk_assertPath DK_PROJECT_DIR

	#### Set Target_Tuple/TARGET_TUPLE, <target_os>_<target_arch>_<Target_Env>/<Target_Os>_<Target_Arch>_<Target_Env> ###
	dk_call dk_basename ${TARGET_TUPLE_DIR} Target_Tuple			# Target_Tuple 	= win_x86_64_clang
	dk_call dk_set Target_Tuple ${Target_Tuple}					# Globalize the variable
	dk_call dk_toUpper ${Target_Tuple} TARGET_TUPLE				# TARGET_TUPLE	= WIN_X86_64_CLANG
	dk_call dk_set TARGET_TUPLE ${TARGET_TUPLE}					# Globalize the variable
	dk_call dk_set ${Target_Tuple} 1								# win_x86_64_clang = 1
	dk_call dk_set ${TARGET_TUPLE} 1								# WIN_X86_64_CLANG = 1
	dk_call dk_printVar Target_Tuple 
	dk_call dk_printVar TARGET_TUPLE 

	#### Set target_os / Target_Os / <target_os>_target / <Target_Os>_TARGET
	dk_call dk_containsCI "${TARGET_TUPLE}" "android" 		&& dk_call dk_set target_os android
	dk_call dk_containsCI "${TARGET_TUPLE}" "emscripten" 	&& dk_call dk_set target_os emscripten
	dk_call dk_containsCI "${TARGET_TUPLE}" "iossim" 		&& dk_call dk_set target_os iossim 
	dk_call dk_containsCI "${TARGET_TUPLE}" "ios" 			&& dk_call dk_set target_os ios
	dk_call dk_containsCI "${TARGET_TUPLE}" "linux" 			&& dk_call dk_set target_os linux
	dk_call dk_containsCI "${TARGET_TUPLE}" "mac" 			&& dk_call dk_set target_os mac
	dk_call dk_containsCI "${TARGET_TUPLE}" "raspberry" 		&& dk_call dk_set target_os raspberry
	dk_call dk_containsCI "${TARGET_TUPLE}" "windows" 		&& dk_call dk_set target_os windows
	dk_call dk_containsCI "${TARGET_TUPLE}" "win"			&& dk_call dk_set target_os win
	dk_call dk_containsCI "${TARGET_TUPLE}" "cosmopolitan"	&& dk_call dk_set target_os cosmopolitan
	if [ -z "${target_os-}" ]; then
		# dk_call dk_warning "The target Target_Tuple:${Target_Tuple} does not contain a valid target_os"
		dk_call dk_unset Target_Tuple
		dk_call dk_unset TARGET_TUPLE 
		dk_call dk_Target_Tuple_SET
	else
		dk_call dk_toUpper ${target_os} Target_Os
		dk_call dk_set target_os ${target_os}
		dk_call dk_set Target_Os ${Target_Os} 
		dk_call dk_set ${target_os} 1
		dk_call dk_set ${Target_Os} 1
		dk_call dk_set ${target_os}_target 1
		dk_call dk_set ${Target_Os}_TARGET 1
	fi
	
	#### Get target_arch / Target_Arch
	dk_call dk_containsCI "${Target_Tuple}" "arm64" 			&& dk_call dk_set target_arch arm64
	dk_call dk_containsCI "${Target_Tuple}" "arm32" 			&& dk_call dk_set target_arch arm32
	dk_call dk_containsCI "${Target_Tuple}" "x86_64" 			&& dk_call dk_set target_arch x86_64
	dk_call dk_containsCI "${Target_Tuple}" "x86" 				&& dk_call dk_set target_arch x86
	dk_call dk_containsCI "${Target_Tuple}" "cosmopolitan" 	&& dk_call dk_set target_arch cosmopolitan	
	
	if [ -z "${target_arch-}" ]; then
		dk_call dk_warning "The target Target_Tuple:${Target_Tuple} does not contain a valid target_arch"
		dk_call dk_Target_Tuple_SET
	else
		dk_call dk_toUpper ${target_arch} Target_Arch
		dk_call dk_set target_arch ${target_arch}
		dk_call dk_set Target_Arch ${Target_Arch}
		dk_call dk_set ${target_arch} 1
		dk_call dk_set ${Target_Arch} 1
		dk_call dk_set ${target_arch}_target 1
		dk_call dk_set ${Target_Arch}_TARGET 1
	fi

	#### Set evn / Target_Env 
	dk_call dk_containsCI "${Target_Tuple}" "clang" 			&& dk_call dk_set Target_Env clang
	dk_call dk_containsCI "${Target_Tuple}" "mingw" 			&& dk_call dk_set Target_Env mingw
	dk_call dk_containsCI "${Target_Tuple}" "ucrt"  			&& dk_call dk_set Target_Env ucrt
	dk_call dk_containsCI "${Target_Tuple}" "msvc"  			&& dk_call dk_set Target_Env msvc
	dk_call dk_containsCI "${Target_Tuple}" "cosmopolitan" 	&& dk_call dk_set Target_Env cosmopolitan
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
				dk_call dk_set msystem "${Target_Env}${Target_Arch}"	# Msystem = Clangarm64
			elif [ -n "${X86_64-}" ]; then
				dk_call dk_set Msystem "${Target_Env}64"				# Msystem = Clang64, Mingw64, Ucrt64
			elif [ -n "${X86-}" ]; then
				dk_call dk_set msystem "${Target_Env}32"				# Msystem = Clang32, Mingw32
			else
				dk_call dk_fatal "The target Target_Tuple:${Target_Tuple} does not contain a valid Target_Env or msystem"
			fi
		fi
		dk_call dk_set ${MSYSTEM} 1										# CLANGARM64, CLANG64, CLANG32, MINGW64, MINGW32, UCRT64 = 1
	fi
	
	### Set target_os_arch / Target_Os_ARCH ###
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
