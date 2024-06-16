include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##################################################################################
# __ARGV__(rtn_var, frame)
#
#
macro(__ARGV__ rtn_var)
	if(${ARGV1})
		set(_FRAME_ ${ARGV1})
	else()
		set(_FRAME_ 0)
	endif()
	
	set(${rtn_var} ${ARGV} PARENT_SCOPE)
#	local marker=0
#	for (( i=0; i<frame; i++ )); do
#		marker=$(($marker + ${BASH_ARGC[${i}]-}))
#	done
#
#	local argv=()	
#	local argc=${BASH_ARGC[${frame}]-}
#	local begin=$(($marker+$argc-1))
#	for (( i=$begin; i>((begin-argc)); i-- )); do
#		argv+=(${BASH_ARGV[${i}]-})
#	done
#	
#	local argv_string=${argv[@]}
#	dk_return "${argv_string}"
endmacro()



function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	#dk_debugFunc
	
	__ARGV__(ARGV)
	dk_info("\${ARGV} = ${ARGV}")
	
	__ARGV__(ARGV_0 0)
	dk_info("\${ARGV_0} = ${ARGV_0}")
	
	__ARGV__(ARGV_1 1)
	dk_info("\${ARGV_1} = ${ARGV_1}")

endfunction(DKTEST)