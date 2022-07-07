# https://developer.apple.com/documentation/mobilecoreservices
if(NOT MAC_HOST)
	dk_undepend(mobile_core_services)
	return()
endif()

dk_findLibrary(MobileCoreServices)
