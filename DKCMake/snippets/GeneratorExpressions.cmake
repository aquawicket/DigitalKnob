set(myHand "JackOfClubs;QueenOfHearts;Joker;2ofClubs;BaseballCard")

<<<<<<< HEAD
=======
# The $<BOOL:...> check prevents adding anything if the property is empty,
# assuming the property value cannot be one of CMake's false constants.
set(prop "$<TARGET_PROPERTY:tgt,INCLUDE_DIRECTORIES>")
add_custom_target(run_some_tool
  COMMAND some_tool "$<$<BOOL:${prop}>:-I$<JOIN:${prop},;-I>>"
  COMMAND_EXPAND_LISTS
  VERBATIM
)

>>>>>>> Development

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