#[===[ 2>nul 
@echo off
call :BATCH
echo "$(where cmd.exe)"
echo "$(command -v bash)"
echo "$(command -v sh)"

DKSCRIPT_PATH="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";
echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}";

### DigitalKnob
export DigitalKnob="DigitalKnob";

### DigitalKnob_DIR
[ ! -e "${DigitalKnob_DIR}" ] && {
	while [ ! "${currentDir}" = "/" ]
	do
		[ -z "${currentDir}" ] && currentDir="${PWD}" || currentDir=$(dirname "${currentDir}");
		echo "currentDir = ${currentDir}";
		
		[ "$(basename ${currentDir})" = "${DigitalKnob}" ] && {
			DigitalKnob_DIR=${currentDir};
			break;
		}
	done
	echo "DigitalKnob_DIR = ${DigitalKnob_DIR}"
}

[ ! -e "${DigitalKnob_DIR}" ] && {
	DigitalKnob_DIR=$(find ${HOME} -maxdepth 1 -type d -name "${DigitalKnob}")
	echo "DigitalKnob_DIR = ${DigitalKnob_DIR}";
}


#[ ! -e "${cmake_exe}" ] && cmake_exe="$(which cmake)";
#[ ! -e "${cmake_exe}" ] && cmake_exe="${HOME}/DigitalKnob/DKTools/cmake-3.29.5-windows-x86_64/bin/cmake.exe";
[ ! -e "${cmake_exe}" ] && cmake_exe=$(find "${HOME}" -name "cmake.exe")	
echo "cmake_exe = ${cmake_exe}";

${cmake_exe} --version && {
	${cmake_exe} -P ${DKSCRIPT_PATH} $*
} || {
	echo "cmake_exe:'${cmake_exe}' failed"
}
exit $?;


:BATCH
echo :BATCH
exit /b 0
#]===]





### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	message("")
	#bash 	= bash -c "which PROGRAM"		OR	bash -c "command -v PROGRAM"
	#cmd	=  cmd /c "where PROGRAM"
	#sh		=   sh -c "which PROGRAM"		OR    sh -c "command -v PROGRAM"
	
	### cmd.exe
	if(NOT EXISTS "${cmd.exe}")
		set(cmd.exe "$ENV{ComSpec}")
		message("cmd.exe = ${cmd.exe}")
	endif()
	if(NOT EXISTS "${cmd.exe}")
		execute_process(COMMAND where cmd.exe 	RESULT_VARIABLE exit_code OUTPUT_VARIABLE cmd.exe 	OUTPUT_STRIP_TRAILING_WHITESPACE)
		message("cmd.exe = ${cmd.exe}")
	endif()
	
	### bash
	if(NOT EXISTS "${bash_exe}")
		execute_process(COMMAND which bash 		RESULT_VARIABLE exit_code OUTPUT_VARIABLE bash_exe 	OUTPUT_STRIP_TRAILING_WHITESPACE)
		message("bash_exe = ${bash_exe}")
	endif()
	
	### sh
	if(NOT EXISTS "${sh_exe}")
		execute_process(COMMAND which sh		RESULT_VARIABLE exit_code OUTPUT_VARIABLE sh_exe 	OUTPUT_STRIP_TRAILING_WHITESPACE)
		message("sh_exe = ${sh_exe}")
	endif()
	



	
	# (command -v 'sh' 1>/dev/null)	|| export PATH=/bin
	execute_process(COMMAND sh -c "command -v sh" RESULT_VARIABLE exit_code OUTPUT_VARIABLE sh_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(NOT ${exit_code} EQUAL 0)	
		message("sh_exe = ${sh_exe}")
		set(ENV{PATH} "/bin")
		message("ENV{PATH} = $ENV{PATH}")
	endif()
		
	# (command -v 'cygpath' 1>/dev/null) && export HOME=$(cygpath -u $USERPROFILE) && echo "cygpath: HOME = ${HOME}"
	execute_process(COMMAND sh -c "command -v cygpath" RESULT_VARIABLE exit_code OUTPUT_VARIABLE cygpath_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(${exit_code} EQUAL 0)
		execute_process(COMMAND ${cygpath_exe} -u "$ENV{USERPROFILE}" OUTPUT_VARIABLE ENV{HOME} OUTPUT_STRIP_TRAILING_WHITESPACE)
		message("cygpath: ENV{HOME} = '$ENV{HOME}'")
	endif()
	
	# (command -v 'cmd.exe' 1>/dev/null) && export cmd.exe=$(command -v 'cmd.exe') && echo "cmd.exe = ${cmd.exe}"
	execute_process(COMMAND sh -c "command -v cmd.exe" RESULT_VARIABLE exit_code OUTPUT_VARIABLE cmd.exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(${exit_code} EQUAL 0)
		message("cmd.exe = '${cmd.exe}'")
	endif()
	
	# [ -z "${USERPROFILE}" ] && export USERPROFILE=$($cmd.exe /c echo %USERPROFILE% | tr -d '\r') && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	if(NOT DEFINED ENV{USERPROFILE})
		execute_process(COMMAND sh -c "${cmd.exe} /c echo %USERPROFILE% | tr -d '\r'" RESULT_VARIABLE exit_code OUTPUT_VARIABLE USERPROFILE OUTPUT_STRIP_TRAILING_WHITESPACE)
		if(${exit_code} EQUAL 0)
			set(ENV{USERPROFILE} "${USERPROFILE}")
			message("ENV{USERPROFILE} = '$ENV{USERPROFILE}'")
		endif()
	endif()

	# (command -v 'wslpath' 1>/dev/null) && export HOME=$(wslpath -u ${USERPROFILE}) && echo "wslpath: HOME = ${HOME}"
	execute_process(COMMAND sh -c "command -v wslpath" RESULT_VARIABLE exit_code OUTPUT_VARIABLE wslpath_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(${exit_code} EQUAL 0)
		execute_process(COMMAND sh -c "${wslpath_exe} -u \${USERPROFILE}" RESULT_VARIABLE exit_code OUTPUT_VARIABLE HOME OUTPUT_STRIP_TRAILING_WHITESPACE)
		if(${exit_code} EQUAL 0)
			set(ENV{HOME} "${HOME}")
			message("ENV{HOME} = '$ENV{HOME}'")
		endif()
	endif()
	
	# (command -v 'cmake' 1>/dev/null) && export cmake_exe=$(command -v cmake)	&& echo "cmake_exe = ${cmake_exe}"
	execute_process(COMMAND sh -c "command -v cmake" RESULT_VARIABLE exit_code OUTPUT_VARIABLE cmake_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	message("cmake_exe = '${cmake_exe}'")
	
	# [ ! -e "${DK_CMAKE}" ] && export DK_CMAKE="${HOME}/Digital Knob/Development/DKCmake/functions/DK.cmake"	&& echo "DK_CMAKE = ${DK_CMAKE}"
	if(NOT EXISTS "${DK_CMAKE}")
		set(DK_CMAKE "${HOME}/Digital Knob/Development/DKCmake/functions/DK.cmake")
		message("DK_CMAKE = ${DK_CMAKE}")
	endif()
	
	# [ ! -e "${DK_CMAKE}" ] && export DK_CMAKE=$(find "${HOME}" -name "DK.cmake") && echo "DK_CMAKE = ${DK_CMAKE}"
	if(NOT EXISTS "${DK_CMAKE}")
		execute_process(COMMAND sh -c "find \"\${HOME}\" -name \"DK.cmake\"" RESULT_VARIABLE exit_code OUTPUT_VARIABLE DK_CMAKE OUTPUT_STRIP_TRAILING_WHITESPACE)
		message("DK_CMAKE = ${DK_CMAKE}")
	endif()
	
	# [ -e "${cmake_exe}" ] && "${cmake_exe}" -P "${DK_CMAKE}" "$0" $*
	if(EXISTS "${cmake_exe}")
		message("${cmake_exe} -P ${DK_CMAKE} ${CMAKE_CURRENT_LIST_FILE}")
		execute_process(COMMAND sh -c "${cmake_exe} -P ${DK_CMAKE} ${CMAKE_CURRENT_LIST_FILE}" RESULT_VARIABLE exit_code)
	endif()
	
	
#	set(DKCMAKE_FUNCTIONS_DIR_ "C:/Users/Administrator/DigitalKnob/Development/DKCmake/functions")
#	file(TO_NATIVE_PATH "${DKCMAKE_FUNCTIONS_DIR_}" DKCMAKE_FUNCTIONS_DIR_)
#	message("DKCMAKE_FUNCTIONS_DIR_ = ${DKCMAKE_FUNCTIONS_DIR_}")

#	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
#		cmake_policy(SET CMP0009 NEW)
#		file(GLOB_RECURSE DK_cmake "/DK.cmake")
#		list(GET DK_cmake 0 DK_cmake)
#		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
#		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
#	endif()
#	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
#	set(DK.cmake "${DK.cmake}" CACHE INTERNAL "" FORCE)
endif()
#########################################################################



####################################################################
# TEST_ENTRY()
#
#
function(TEST_ENTRY)
	dk_echo("########## TEST_ENTRY() ###############")
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	TEST_ENTRY()
endfunction()	