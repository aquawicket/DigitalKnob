#NOTE: Use ${CMAKE_PROJECT_NAME} to reference the root parent project if needed

#dk_require(cef_binary)

ANDROID_dk_return()
IOS_dk_return()
IOSSIM_dk_return()

if(WIN)
	dk_depend(winmm.lib)
endif()
if(MAC)
	#dk_depend(appkit)
	#dk_depend(foundation)
endif()
if(LINUX)
	#dk_depend(libgtk2.0-dev)
endif()
if(RASPBERRY)
	dk_depend(libglib2.0-dev)
	dk_depend(libgtk2.0-dev)
endif()
dk_depend(cef_binary)
dk_depend(DK)
dk_depend(DKDuktape)


dk_generateCmake(DKCef)
dk_assets(DKCef)


if(WIN_32)
	dk_copy(${CEF_BINARY}/Resources/ ${DKPROJECT}/assets/DKCef OVERWRITE)
	if(DEBUG)
		dk_copy(${CEF_BINARY}/Debug/ ${DKPROJECT}/assets/DKCef/win32Debug OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef/win32Debug OVERWRITE)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win32Debug/cef_sandbox.lib)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win32Debug/libcef.lib)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win32Debug/wow_helper.exe)
	endif()
	if(RELEASE)
		##UPX_COMPRESS(${CEF_BINARY}/Release/libcef.dll)
		dk_copy(${CEF_BINARY}/Release/ ${DKPROJECT}/assets/DKCef/win32Release OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef/win32Release OVERWRITE)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win32Release/cef_sandbox.lib)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win32Release/libcef.lib)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win32Release/wow_helper.exe)
	endif()
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/icudtl.dat)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:libcef.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:libcef.dll)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:chrome_elf.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:chrome_elf.dll)
endif()

if(WIN_64)
	dk_copy(${CEF_BINARY}/Resources/ ${DKPROJECT}/assets/DKCef OVERWRITE)
	if(DEBUG)
		dk_copy(${CEF_BINARY}/Debug/ ${DKPROJECT}/assets/DKCef/win64Debug OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef/win64Debug OVERWRITE)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win64Debug/cef_sandbox.lib)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win64Debug/libcef.lib)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win64Debug/wow_helper.exe)
	endif()
	if(RELEASE)
		#UPX_COMPRESS(${CEF_BINARY}/Release/libcef.dll)
		dk_copy(${CEF_BINARY}/Release/ ${DKPROJECT}/assets/DKCef/win64Release OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef/win64Release OVERWRITE)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win64Release/cef_sandbox.lib)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win64Release/libcef.lib)
		FILE(REMOVE ${DKPROJECT}/assets/DKCef/win64Release/wow_helper.exe)
	endif()
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/icudtl.dat)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:libcef.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:libcef.dll)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:chrome_elf.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:chrome_elf.dll)
endif()

#https://bitbucket.org/chromiumembedded/cef/wiki/Tutorial#markdown-header-mac-os-x-build-steps
if(MAC_64)
	#dk_info("Adding Chromium Embedded Framework.framework to bundle . . .")
	#add_custom_command(
	#	TARGET DKCef
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E copy_directory
	#		"${CEF_BINARY}/$<CONFIG>/Chromium Embedded Framework.framework"
	#		"$<TARGET_FILE_DIR:${CMAKE_PROJECT_NAME}>/../Frameworks/Chromium Embedded Framework.framework"
	#)
endif()

if(LINUX_32)
if(NOT RASPBERRY)
	if(DEBUG)
		dk_copy(${CEF_BINARY}/Debug ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Debug ${DKPROJECT}/linux32/Debug OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/linux32/Debug OVERWRITE)
	endif()
	if(RELEASE)
		dk_copy(${CEF_BINARY}/Release ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Release ${DKPROJECT}/linux32/Release OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/linux32/Release OVERWRITE)
	endif()
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/cef_sandbox.a)
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/libcef.a)
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/wow_helper.exe)
endif()
endif()
if(LINUX_64)
if(NOT RASPBERRY)
	if(DEBUG)
		dk_copy(${CEF_BINARY}/Debug ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Debug ${DKPROJECT}/linux64/Debug OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/linux64/Debug OVERWRITE)
	endif()
	if(RELEASE)
		dk_copy(${CEF_BINARY}/Release ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Release ${DKPROJECT}/linux64/Release OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/linux64/Release OVERWRITE)
	endif()
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/cef_sandbox.a)
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/libcef.a)
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/wow_helper.exe)
endif()
endif()

if(RASPBERRY_32)
	if(DEBUG)
		dk_copy(${CEF_BINARY}/Debug ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Debug ${DKPROJECT}/raspberry32/Debug OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/raspberry32/Debug OVERWRITE)
	endif()
	if(RELEASE)
		dk_copy(${CEF_BINARY}/Release ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Release ${DKPROJECT}/raspberry32/Release OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/raspberry32/Release OVERWRITE)
	endif()
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/cef_sandbox.a)
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/libcef.a)
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/wow_helper.exe)
endif()
if(RASPBERRY_64)
	if(DEBUG)
		dk_copy(${CEF_BINARY}/Debug ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Debug ${DKPROJECT}/raspberry64/Debug OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/raspberry64/Debug OVERWRITE)
	endif()
	if(RELEASE)
		dk_copy(${CEF_BINARY}/Release ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources ${DKPROJECT}/assets/DKCef OVERWRITE)
		dk_copy(${CEF_BINARY}/Release ${DKPROJECT}/raspberry64/Release OVERWRITE)
		dk_copy(${CEF_BINARY}/Resources/icudtl.dat ${DKPROJECT}/raspberry64/Release OVERWRITE)
	endif()
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/cef_sandbox.a)
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/libcef.a)
	FILE(REMOVE ${DKPROJECT}/assets/DKCef/wow_helper.exe)
endif()
