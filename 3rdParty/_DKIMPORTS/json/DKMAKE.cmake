# https://github.com/nlohmann/json.git


### NOTES ###
# This is a header only library, the compileable stuff below is unit testing
# include "json.hpp" to use this library 


### IMPORT ###
#dk_import(https://github.com/nlohmann/json/archive/d8a63291cbe50411a2c513d06f3ae7c8c1a43c33.zip)
dk_import(https://github.com/nlohmann/json.git)


### LINK ###
dk_include(${JSON}/include/nlohmann)


#dk_set(JSON_TESTS ON)
if(JSON_TESTS)
	### GENERATE ###
	dk_queueCommand(${DKCMAKE_BUILD} ${JSON})


	### COMPILE ###
	dk_build(${JSON} json_unit)
endif()
