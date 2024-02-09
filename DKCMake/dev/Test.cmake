function(is_list sent var)
	message("")
	message("${sent} \${ARGV} = "${ARGV})
	message("${sent} \${ARGC} = "${ARGC})
	message("${sent} \${\${ARGV}} = "${${ARGV}})
	message("${sent} \${ARGV} = ${ARGV}")
	message("${sent} \${ARGC} = ${ARGC}")
	message("${sent} \${\${ARGV}} = ${${ARGV}}")
	message("")
	
	
	

	
	#message(STATUS "var =  ${ARGV} ${${ARGV}}")
	#string(COMPARE EQUAL ${${ARGV}} "${${ARGV}}" is_string)
	#if(is_string)
	#	message("${ARGV} is a string")
	#else()
	#	message("${ARGV} is a list")
	#endif()
endfunction()

set(MY_LIST 	"This;is;a;list")
set(MY_STRING 	"This is a string")

message(STATUS ${MY_LIST})
message(STATUS "${MY_LIST}")
message(STATUS ${MY_STRING})
message(STATUS "${MY_STRING}")

is_list("MY_STRING" 		MY_STRING)
is_list("\"MY_STRING\"" 	"MY_STRING")
is_list("\${MY_STRING}" 	${MY_STRING})
is_list("\"\${MY_STRING}\"" "${MY_STRING}")
is_list("MY_LIST" 			MY_LIST)
is_list("\"MY_LIST\"" 		"MY_LIST")
is_list("\${MY_LIST}" 		${MY_LIST})
is_list("\"\${MY_LIST}\"" 	"${MY_LIST}")





