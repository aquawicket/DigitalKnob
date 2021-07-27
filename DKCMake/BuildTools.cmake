### DEPENDS ###
if(CMAKE_HOST_WIN32 AND WIN)
	DKDEPEND(Git)
	DKDEPEND(VisualStudio)
	
	# NOTE: These Defines should be done per as needed in DKMAKE.cmake files
	## add_definitions(-D__WINDOWS_MM__)
	## add_definitions(-D__STDC_CONSTANT_MACROS)
	## add_definitions(-D_SCL_SECURE_NO_WARNINGS)
	## add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
	
	LIST(APPEND WIN_LIBS kernel32.lib)
	LIST(APPEND WIN_LIBS user32.lib)
	LIST(APPEND WIN_LIBS gdi32.lib)
	LIST(APPEND WIN_LIBS winspool.lib)
	LIST(APPEND WIN_LIBS shell32.lib)
	LIST(APPEND WIN_LIBS ole32.lib)
	LIST(APPEND WIN_LIBS oleaut32.lib)
	LIST(APPEND WIN_LIBS uuid.lib)
	LIST(APPEND WIN_LIBS comdlg32.lib)
	LIST(APPEND WIN_LIBS advapi32.lib)
	LIST(APPEND WIN_LIBS odbc32.lib)
	LIST(APPEND WIN_LIBS odbccp32.lib)
	LIST(APPEND WIN_LIBS opengl32.lib)
	LIST(APPEND WIN_LIBS DbgHelp.lib)
endif()


if(CMAKE_HOST_APPLE AND MAC OR IOS OR IOSSIM)
	DKDEPEND(Xcode)
endif()


if(CMAKE_HOST_LINUX AND LINUX)
	DKDEPEND(libx11-dev)
endif()


if(CMAKE_HOST_LINUX AND RASPBERRY)
	DKDEPEND(libx11-dev)
endif()


## TRACKER: error TRK0005: Failed to locate: "clang.exe" - https://stackoverflow.com/a/50924477/688352
if(CMAKE_HOST_WIN32 AND ANDROID)
	DKDEPEND(apache-ant)
	DKDEPEND(android-sdk)
	DKDEPEND(jdk)
	DKDEPEND(VisualStudio)
	DKDEPEND(mingw32)
	DKDEPEND(msys)
endif()