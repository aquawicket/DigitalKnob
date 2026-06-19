message("")
message("")

# You can find substrings in a list using the MATCHES conditional inside of an iteration.
#
# https://cmake.org/cmake/help/latest/command/if.html#matches
# if(<variable|string> MATCHES <regex>)
#	True if the given string or variable's value matches the given regular expression. 
#
#	Here are a few examples without going to deep into the regex side of things. Also note that as of cmake 2.6 
#   you can use the CMAKE_MATCH_<n> and CMAKE_MATCH_COUNT variables along with the MATCHES conditional.


#################################################
# Find substring in string example
message("\n### Find substring in string example")
set(haystack "Ouch! There is a needle in this haystack")
if(haystack MATCHES "needle")
	message("${haystack}")
	message("needle FOUND in haystack string")
else()
	message("needle NOT FOUND")
endif()

#################################	
# Find substring in list example 
message("\n### Find substring in list example ")
set(haystack "hay;hay;hayhay;hayneedlehay;hayhay;needlehay;hay;needle;hay;hayhay")
set(n 0)
foreach(item IN LISTS haystack)
	if(item MATCHES "needle")
		message("needle FOUND haystack list at index:${n}")
	endif()
	math(EXPR n "${n}+1")
endforeach()	



######################################################################
# list_search function with fisrt and last, row and column, occurences
#
list(APPEND myList "abcdef abcdef abcdef")
list(APPEND myList "zyxwvu,zyxwvu,zyxwvu")
list(APPEND myList "123456\;123456\;123456")
list(APPEND myList "987654.987654.987654")
list(APPEND myList "bcdefg_bcdefg_bcdefg")
list(APPEND myList "234567-234567-234567")
list(APPEND myList "yxwvut<yxwvut<yxwvut")
list(APPEND myList "876543>876543>876543")
list(APPEND myList "cdefghi)cdefghi)cdefghi")
list(APPEND myList "3456789 / 345678 / 3456789")
list(APPEND myList "xwvutsr\\xwvutsrz\\xwvutsr")
list(APPEND myList "7654321 = 7654321 = 7654321")

message("\n\n###### myList ######")
message("${myList}")

set(n 0)
message("\n\n###### myList Items ######")
foreach(item IN LISTS myList)
	message("(${n}):${item}")
	math(EXPR n "${n}+1")
endforeach()


function(list_search _list_ _search_)
	message("\n\n###### list_search list:${_list_} '${_search_}' ######")
	set(_list_ "${ARGV0}")
	set(_search_ "${ARGV1}")
	
	set(row 0)
	foreach(item IN LISTS ${_list_})
		if(item MATCHES "${_search_}")
			string(FIND "${item}" "${_search_}" col)
			string(FIND "${item}" "${_search_}" last_col REVERSE)
			
			if(DEFINED row)
				set(last_${_search_}_row "${row}")
			endif()
			if(DEFINED last_col)
				set(last_${_search_}_col "${last_col}")
			endif()
			if(DEFINED item)
				set(last_${_search_}_val "${item}")
			endif()
			
			if(NOT DEFINED first_${_search_}_row)
				set(first_${_search_}_row "${row}")
			endif()
			if(NOT DEFINED first_${_search_}_col)
				set(first_${_search_}_col "${col}")
			endif()
			if(NOT DEFINED first_${_search_}_val)
				set(first_${_search_}_val "${item}")
			endif()
			
			message("'${_search_}' found at row:${row} col:${col} with value of '${item}'")
		endif()
		math(EXPR row "${row}+1")
	endforeach()

	message("")
	message("First '${_search_}' found in list at row:${first_${_search_}_row} col:${first_${_search_}_col} With the value of '${first_${_search_}_val}'")
	message("Last  '${_search_}' found in list at row:${last_${_search_}_row} col:${last_${_search_}_col} With the value of '${last_${_search_}_val}'")
endfunction()

list_search(myList "456")
list_search(myList "yxw")
list_search(myList "654")





message("")
message("")