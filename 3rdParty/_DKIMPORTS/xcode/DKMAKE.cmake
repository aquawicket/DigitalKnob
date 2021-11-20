if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/xcode/
# https://pewpewthespells.com/blog/buildsettings.html
# Apple Frameworks https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/SystemFrameworks/SystemFrameworks.html

### VERSION ###
#DKSET(XCODE_VERSION ???)
#DKSET(XCODE_NAME ???)
#DKSET(XCODE_DL ???)
#DKSET(XCODE ???)
#DKSET(XCODE_EXE ???)

### INSTALL ###
#DKINSTALL(${XCODE_DL} Xcode ${XCODE})