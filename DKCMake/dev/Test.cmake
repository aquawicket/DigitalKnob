set(var "TEST123")
set(my_list ${my_list} "${var}")

list(FIND my_list ${var} index)
if(${index} GREATER -1)
	message(STATUS "Found ${var} in my_list")
else()
	message(STATUS "${var} NOT FOUND in my_list")
endif()