# https://developer.apple.com/documentation/ForceFeedback

if(NOT MAC)
	dk_undepend(force_feedback)
	dk_return()
endif()


dk_findLibrary(ForceFeedback)
