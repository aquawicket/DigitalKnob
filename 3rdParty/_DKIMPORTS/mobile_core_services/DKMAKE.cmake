# https://developer.apple.com/documentation/mobilecoreservices

if(NOT IOS AND NOT IOSSIM)
	dk_undepend(mobile_core_services)
	return()
endif()

dk_findLibrary(MobileCoreServices)
