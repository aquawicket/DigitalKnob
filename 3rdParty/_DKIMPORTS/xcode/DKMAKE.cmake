# https://developer.apple.com/xcode/
# https://pewpewthespells.com/blog/buildsettings.html
# Apple Frameworks https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/SystemFrameworks/SystemFrameworks.html

if(NOT MAC_HOST)
	return()
endif()


### VERSION ###
#dk_set(XCODE_VERSION ???)
#dk_set(XCODE_NAME ???)
#dk_set(XCODE_DL ???)
#dk_set(XCODE ???)
#dk_set(XCODE_EXE ???)

### INSTALL ###
#dk_install(${XCODE_DL} Xcode ${XCODE})