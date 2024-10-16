
###### DKBuilder ######

###### DKINIT ######
if(NOT EXISTS DKCMake)
	file(MAKE_DIRECTORY DKCMake)
endif()
if(NOT EXISTS DKCMake/functions)
	file(MAKE_DIRECTORY DKCMake/functions)
endif()
if(NOT EXISTS DKCMake/functions/DK.sh)
	file(DOWNLOAD "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKCMake/functions/DK.cmake" "DKCMake/functions/DK.cmake")
endif()
include(DKCMake/functions/DK.cmake)


###### Load Main Program ######
## [ $# -gt 0 ] && "$@" || dk_buildMain
dk_load(dk_buildMain)
dk_buildMain()