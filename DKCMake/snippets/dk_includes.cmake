#!/usr/bin/cmake -P

set(myString "There is a needle in this haystack")
set(mySubstring "needle")
if(myString MATCHES ${mySubstring})
	message("myString contains mySubstring")
else()
	message("myString does NOT contain mySubstring")
endif()
	
if(myString MATCHES "nonexistant")
	message("myString contains nonexistant")
else()
	message("myString does NOT contain nonexistant")
endif()

list(APPEND myList "one")
list(APPEND myList "two")
list(APPEND myList "three")
if(myList MATCHES "two")
	message("myList contains two")
else()
	message("myList does NOT contain two")
endif()
if(myList MATCHES "nonexistant")
	message("myList contains nonexistant")
else()
	message("myList does NOT contain nonexistant")
endif()
if(myList MATCHES "wo;th")
	message("myList contains wo;th")
else()
	message("myList does NOT contain wo;th")
endif()





