###############################################################################
# TestReturnValue(args RESULT)
#
#	Example function that uses returns value with a supplied variable 
#
#	Usage:
#		TestReturnValue("ABC" "123" 5 myResult)
#		message(STATUS "TestReturnValue() -> myResult = ${myResult}") # should print->  return value = ABC;123;5
#
function(TestReturnValue args RESULT)
	set(args ${ARGV})
	list(GET args -1 RESULT)
	list(REMOVE_AT args -1)
	set(${RESULT} ${args} PARENT_SCOPE) #just relay the arguments
endfunction()

TestReturnValue("ABC" "123" 5 myResult)
message(STATUS "TestReturnValue() -> myResult = ${myResult}") # should print->  return value = ABC;123;5


###############################################################################
# CreateFunction(name contents args)
#
#	Example that creates functions dynamicaly at run time
#
#	Usage:
#		CreateFunction(MyDynamicFunc 
#			"message(STATUS \"Test message\")") 
#			"foreach(arg IN LIST ${ARGN})
#				set(count 0) 
#				message(STATUS \"arg:${count} = ${arg}\")
#				MATH(EXPR count \"${cound}+1\")
#			endforeach()"
#			${ARGN})
#	
#	set(myVariable "myVariable")
#	MyDynamicFunc("myStringData" "My;List;Data" "${myVariable}" 17 moreData)
#
function(CreateFunction name contents) #args
	if(CMAKE_VERSION VERSION_LESS 3.18)
		if(NOT extFileCleared)
			file(WRITE functions_ext.cmake "")
			set(extFileCleared 1 CACHE INTERNAL "")
		endif()
		file(APPEND functions_ext.cmake "function(${name})\n	${contents}\nendfunction()\n")
		include(functions_ext.cmake)
	else()
		cmake_language(EVAL CODE "function(${name})\n	${contents}\nendfunction()\n")
	endif()	
endfunction()

CreateFunction(MyFunction 
	"message(STATUS \"Test message\") \ 
	foreach(arg IN LIST ${ARGN}) \
		set(count 0)  \
		message(STATUS \"arg:${count} = ${arg}\") \
		MATH(EXPR count \"${cound}+1\") \
	endforeach()"
${ARGN})