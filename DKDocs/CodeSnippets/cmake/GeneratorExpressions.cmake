set(myHand "JackOfClubs;QueenOfHearts;Joker;2ofClubs;BaseballCard")


string(FIND "${myHand}" "QueenOfHearts" index)
if(${index} GREATER -1)
	message(STATUS "Lady Luck!")
else()
	message(STATUS "no dice.")
endif()


if($<IN_LIST:"QueenOfHearts", myHand>)
	message(STATUS "Lady Luck!")
else()
	message(STATUS "no dice.")
endif()