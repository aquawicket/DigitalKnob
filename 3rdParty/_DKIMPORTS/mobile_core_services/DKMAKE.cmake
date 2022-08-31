# https://developer.apple.com/documentation/mobilecoreservices
#if(NOT MAC_HOST)
if(NOT IOS AND NOT IOSSIM)
	dk_undepend(mobile_core_services)
	return()
endif()

dk_findLibrary(MobileCoreServices)
