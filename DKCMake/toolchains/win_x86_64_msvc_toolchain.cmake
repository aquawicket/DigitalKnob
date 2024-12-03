message("######################################################################")
message("################ windoows_x86_64_msvc_toolchain.cmake ################")
message("######################################################################")

############ CMAKE COMPILER VARIABLES ############
#dk_depend(visualstudio)
dk_depend(visual-cpp-build-tools)

dk_set(CMAKE_C_COMPILER				${VISUAL_CPP_BUILD_TOOLS_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER			${VISUAL_CPP_BUILD_TOOLS_CXX_COMPILER})
dk_set(CMAKE_DUMPBIN				${VISUAL_CPP_BUILD_TOOLS_DUMPBIN})
dk_set(CMAKE_GENERATOR				${VISUAL_CPP_BUILD_TOOLS_GENERATOR})
dk_set(CMAKE_GENERATOR_PLATFORM		${VISUAL_CPP_BUILD_TOOLS_GENERATOR_PLATFORM})
dk_set(CMAKE_LINKER					${VISUAL_CPP_BUILD_TOOLS_LINKER})
dk_set(CMAKE_MAKE_PROGRAM 			${VISUAL_CPP_BUILD_TOOLS_MAKE_PROGRAM})
#dk_append(DKCONFIGURE_FLAGS		--build=x86_64-w64-msvc)
#dk_append(DKCONFIGURE_CFLAGS		${CMAKE_C_FLAGS})
#dk_append(DKCONFIGURE_CXXFLAGS		${CMAKE_CXX_FLAGS})

dk_append(CMAKE_C_FLAGS				/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /Zm500 /Zc:__cplusplus /bigobj)   #/MACHINE:X64 /D_WIN32_WINNT=0x0600
dk_append(CMAKE_CXX_FLAGS			/DWIN /DWIN_X86_64 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /Zm500 /Zc:__cplusplus /bigobj) #/MACHINE:X64 /D_WIN32_WINNT=0x0600
