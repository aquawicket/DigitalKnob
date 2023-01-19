# https://developer.apple.com/documentation/ForceFeedback

if(NOT MAC)
	dk_return()
endif()


dk_findLibrary(ForceFeedback)
