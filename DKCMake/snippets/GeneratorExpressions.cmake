#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################



set(myHand "JackOfClubs;QueenOfHearts;Joker;2ofClubs;BaseballCard")

# The $<BOOL:...> check prevents adding anything if the property is empty,
# assuming the property value cannot be one of CMake's false constants.
set(prop "$<TARGET_PROPERTY:tgt,INCLUDE_DIRECTORIES>")
add_custom_target(run_some_tool
  COMMAND some_tool "$<$<BOOL:${prop}>:-I$<JOIN:${prop},;-I>>"
  COMMAND_EXPAND_LISTS
  VERBATIM
)


if(myHand MATCHES "QueenOfHearts")
	message(STATUS "Lady Luck!")
else()
	message(STATUS "no dice.")
endif()


if($<IN_LIST:"QueenOfHearts", myHand>)
	message(STATUS "Lady Luck!")
else()
	message(STATUS "no dice.")
endif()