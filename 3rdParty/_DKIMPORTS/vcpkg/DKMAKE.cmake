if(NOT WIN_HOST)
	return()
endif()

# Getting Started  https://vcpkg.io/en/getting-started.html
# Documentation    https://vcpkg.io/en/docs/README.html
#

DKDEPEND(git)

### VERSION ###
#DKSET(VCPKG_MAJOR ?)
#DKSET(VCPKG_MINOR ?)
#DKSET(VCPKG_BUILD ?)
#DKSET(VCPKG_VERSION ${VCPKG_MAJOR}.${VCPKG_MINOR}.${VCPKG_BUILD})
DKSET(VCPKG_NAME vcpkg)
#DKSET(VCPKG_DL https://sourceforge.net/projects/VCPKG/files/VCPKG2/${VCPKG_MAJOR}.${VCPKG_MINOR}.${VCPKG_BUILD}/${VCPKG_NAME}.tar.gz)
DKSET(VCPKG ${3RDPARTY}/${VCPKG_NAME})
DKSETPATH(${3RDPARTY})
WIN_DKQCOMMAND(git clone https://github.com/Microsoft/vcpkg.git)
DKSETPATH(${VCPKG})
WIN_DKQCOMMAND(bootstrap-vcpkg.bat)

