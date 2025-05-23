#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ macports ############
# https://guide.macports.org/#installing.macports
# https://github.com/macports/macports-base
# https://github.com/macports/macports-base/releases
# https://github.com/macports/macports-base/releases/download/v2.7.1/MacPorts-2.7.1-11-BigSur.pkg

if(NOT MAC_HOST)
	return()
endif()

dk_load(dk_builder)

### VERSION ###
dk_set(MACPORTS_DL https://github.com/macports/macports-base/releases/download/v2.7.1/MacPorts-2.7.1-11-BigSur.pkg)

if(NOT EXISTS $ENV{DKDOWNLOAD_DIR}/MacPorts-2.7.1-11-BigSur.pkg)
	dk_download(${MACPORTS_DL} $ENV{DKDOWNLOAD_DIR}/MacPorts-2.7.1-11-BigSur.pkg)		
	dk_command(chmod +x $ENV{DKDOWNLOAD_DIR}/MacPorts-2.7.1-11-BigSur.pkg)
	dk_set(QUEUE_BUILD ON)
	#MAC_dk_queueCommand($ENV{DKDOWNLOAD_DIR}/MacPorts-2.7.1-11-BigSur.pkg) #FIXME
endif()
