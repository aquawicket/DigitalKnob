# https://developer.apple.com/xcode/
# https://pewpewthespells.com/blog/buildsettings.html
# Apple Frameworks https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/SystemFrameworks/SystemFrameworks.html

if(NOT MAC_HOST)
	dk_undepend(xcode)
	dk_return()
endif()


# xcode Variables
dk_set(XCODE_DEVROOT		/Applications/Xcode.app/Contents/Developer)
dk_set(XCODE_C_COMPILER		${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang)
dk_set(XCODE_CXX_COMPILER	${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++)
dk_set(XCODE_LIBTOOL		${XCODE_DEVROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/libtool)

# iOS variables
dk_set(IOS_DARWIN		darwin20.6.0)
dk_set(IOS_SDK			15.0)
dk_set(IOS_MIN_SDK		13.0)
dk_set(IOS_SYSROOT		${XCODE_DEVROOT}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS15.0.sdk)
dk_set(IOSSIM_SYSROOT	${XCODE_DEVROOT}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator15.0.sdk)


### VERSION ###
#dk_set(XCODE_VERSION ???)
#dk_set(XCODE_NAME ???)
#dk_set(XCODE_DL ???)
#dk_set(XCODE ???)
#dk_set(XCODE_EXE ???)

### INSTALL ###
#dk_import(${XCODE_DL} ${XCODE})
#dk_import(${XCODE_DL})