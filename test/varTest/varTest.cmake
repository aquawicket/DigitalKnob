# shebang

set(myVar "value")											
#message("myVar = '${myVar}'")													# /w newline
execute_process(COMMAND ${CMAKE_COMMAND} -E echo_append "myVar = '${myVar}'")	# no newline
