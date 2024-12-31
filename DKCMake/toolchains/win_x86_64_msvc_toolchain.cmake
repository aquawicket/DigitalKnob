message("######################################################################")
message("################ windoows_x86_64_msvc_toolchain.cmake ################")
message("######################################################################")

#dk_depend(visualstudio)
dk_depend(visual-cpp-build-tools)

dk_set(CMAKE_GENERATOR				${VS_BUILDTOOLS_GENERATOR})
dk_set(CMAKE_MAKE_PROGRAM 			${VS_BUILDTOOLS_MAKE_PROGRAM})

dk_set(CMAKE_GENERATOR_PLATFORM		${VS_BUILDTOOLS_X64_GENERATOR_PLATFORM})
dk_set(CMAKE_CXX_COMPILER			${VS_BUILDTOOLS_X64_COMPILER})
dk_set(CMAKE_C_COMPILER				${VS_BUILDTOOLS_X64_COMPILER})
dk_set(CMAKE_DUMPBIN				${VS_BUILDTOOLS_X64_DUMPBIN})
dk_set(CMAKE_LINKER					${VS_BUILDTOOLS_X64_LINKER})
#dk_append(DKCONFIGURE_FLAGS		--build=x86_64-w64-msvc)

dk_append(CMAKE_C_FLAGS				/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /Zm500 /Zc:__cplusplus /bigobj)   #/MACHINE:X64 /D_WIN32_WINNT=0x0600
dk_append(CMAKE_CXX_FLAGS			/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /Zm500 /Zc:__cplusplus /bigobj) #/MACHINE:X64 /D_WIN32_WINNT=0x0600
