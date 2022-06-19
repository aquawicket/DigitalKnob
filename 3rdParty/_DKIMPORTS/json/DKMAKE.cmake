# https://github.com/nlohmann/json
#
# https://github.com/nlohmann/json/archive/refs/tags/v3.9.1.zip


#dk_import(https://github.com/nlohmann/json)
dk_import(https://github.com/nlohmann/json/archive/d8a63291cbe50411a2c513d06f3ae7c8c1a43c33.zip)
#dk_set(JSON_MAJOR 3)
#dk_set(JSON_MINOR 9)
#dk_set(JSON_BUILD 1)
#dk_set(JSON_VERSION ${JSON_MAJOR}.${JSON_MINOR}.${JSON_BUILD})
#dk_set(JSON_NAME json-${JSON_VERSION})
#dk_set(JSON_DL https://github.com/nlohmann/json/archive/refs/tags/v3.9.1.zip)
#dk_set(JSON ${3RDPARTY}/${JSON_NAME})
#dk_install(${JSON_DL} json ${JSON})


dk_include(${JSON}/include/nlohmann)


# This is a header onlu library, the compileable stuff below is unit testing
# include "json.hpp" to use this library 


### COMPILE ###
if(JSON_TESTS)
	dk_setPath(${JSON}/${BUILD_DIR})
	dk_queueCommand(${DKCMAKE_BUILD} ${JSON})

	WIN_dk_visualStudio(${JSON_NAME} nlohmann_json.sln json_unit)
	MAC_dk_xcode(${JSON_NAME} json_unit)
	IOS_dk_xcode(${JSON_NAME} json_unit)
	IOSSIM_dk_xcode(${JSON_NAME} json_unit)
	LINUX_dk_queueCommand(make all)
	RASPBERRY_dk_queueCommand(make all)
	ANDROID_dk_visualStudio(${JSON_NAME} nlohmann_json.sln json_unit)
endif()
