set(myHand "JackOfClubs;QueenOfHearts;Joker;2ofClubs;BaseballCard")


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