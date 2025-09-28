message("############################################################################")
message("#################### Windows_X86_64_Msvc_Toolchain.cmake ###################")
message("############################################################################")
# https://learn.microsoft.com/en-us/cpp/build/projects-and-build-systems-cpp?view=msvc-170

if(NOT Windows_Host)
	dk_exit()
endif()

dk_depend(visualstudio)

dk_set(CMAKE_GENERATOR				${VS_GENERATOR})					# https://cmake.org/cmake/help/latest/variable/CMAKE_GENERATOR.html
dk_set(CMAKE_MAKE_PROGRAM 			${VS_MAKE_PROGRAM})					# https://cmake.org/cmake/help/latest/variable/CMAKE_MAKE_PROGRAM.html
dk_set(CMAKE_GENERATOR_PLATFORM		${VS_X86_64_GENERATOR_PLATFORM})	# https://cmake.org/cmake/help/latest/variable/CMAKE_GENERATOR_PLATFORM.html
dk_set(CMAKE_CXX_COMPILER			${VS_X86_64_COMPILER})				# https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER.html
dk_set(CMAKE_C_COMPILER				${VS_X86_64_COMPILER})				# https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER.html
dk_set(CMAKE_DUMPBIN				${VS_X86_64_DUMPBIN})
dk_set(CMAKE_LINKER					${VS_X86_64_LINKER})
#dk_append(DKCONFIGURE_FLAGS		--build=x86_64-w64-msvc)

###### C Compiler Options ######
# https://learn.microsoft.com/en-us/cpp/build/reference/compiler-options-listed-by-category?view=msvc-170
dk_append(CMAKE_C_FLAGS				
	/DWIN 						# https://learn.microsoft.com/en-us/cpp/build/reference/d-preprocessor-definitions?view=msvc-170
	/DWIN_X86_64 				# "
	/D_WINDOWS 					# "
	/D_CRT_SECURE_NO_WARNINGS 	# "
	/D_USING_V110_SDK71_ 		# "
	/std:c17 					# https://learn.microsoft.com/en-us/cpp/build/reference/std-specify-language-standard-version?view=msvc-170
	/nologo 					# https://learn.microsoft.com/en-us/cpp/build/reference/nologo-suppress-startup-banner-c-cpp?view=msvc-170
	/Zm500 						# https://learn.microsoft.com/en-us/cpp/build/reference/zm-specify-precompiled-header-memory-allocation-limit?view=msvc-170
	/Zc:__cplusplus 			# https://learn.microsoft.com/en-us/cpp/build/reference/zc-cplusplus?view=msvc-170
	/bigobj						# https://learn.microsoft.com/en-us/cpp/build/reference/bigobj-increase-number-of-sections-in-dot-obj-file?view=msvc-170
)

###### C++ Compiler Options ######
# https://learn.microsoft.com/en-us/cpp/build/reference/compiler-options-listed-by-category?view=msvc-170
dk_append(CMAKE_CXX_FLAGS			
	/DWIN 						# https://learn.microsoft.com/en-us/cpp/build/reference/d-preprocessor-definitions?view=msvc-170
	/DWIN_X86_64 				# "
	/D_WINDOWS 					# "
	/D_CRT_SECURE_NO_WARNINGS 	# "
	/D_USING_V110_SDK71_ 		# "
	/std:c++17 					# https://learn.microsoft.com/en-us/cpp/build/reference/std-specify-language-standard-version?view=msvc-170
	/nologo 					# https://learn.microsoft.com/en-us/cpp/build/reference/nologo-suppress-startup-banner-c-cpp?view=msvc-170
	/Zm500 						# https://learn.microsoft.com/en-us/cpp/build/reference/zm-specify-precompiled-header-memory-allocation-limit?view=msvc-170
	/Zc:__cplusplus 			# https://learn.microsoft.com/en-us/cpp/build/reference/zc-cplusplus?view=msvc-170
	/bigobj						# https://learn.microsoft.com/en-us/cpp/build/reference/bigobj-increase-number-of-sections-in-dot-obj-file?view=msvc-170
)

###### Linker Options ######
# https://learn.microsoft.com/en-us/cpp/build/reference/linker-options?view=msvc-170
dk_append(CMAKE_EXE_LINKER_FLAGS	
	/ENTRY:mainCRTStartup		# https://learn.microsoft.com/en-us/cpp/build/reference/entry-entry-point-symbol?view=msvc-170
)

list(APPEND DEBUG_LINK_FLAGS /MANIFEST:NO)
list(APPEND DEBUG_LINK_FLAGS /MANIFESTUAC:NO)
list(APPEND DEBUG_LINK_FLAGS /level='highestAvailable')
list(APPEND DEBUG_LINK_FLAGS /uiAccess='true')
#list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE)
list(APPEND DEBUG_LINK_FLAGS /SAFESEH:NO)

##list(APPEND RELEASE_LINK_FLAGS /FORCE) ## MySQL lib needs /FORCE due to zlib redefinitions
list(APPEND RELEASE_LINK_FLAGS /INCREMENTAL:NO)
list(APPEND RELEASE_LINK_FLAGS /OPT:NOREF)
list(APPEND RELEASE_LINK_FLAGS /MANIFEST:NO)
list(APPEND RELEASE_LINK_FLAGS /MANIFESTUAC:NO)
list(APPEND RELEASE_LINK_FLAGS /level='highestAvailable')
list(APPEND RELEASE_LINK_FLAGS /uiAccess='true')
#list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE)
list(APPEND RELEASE_LINK_FLAGS /SAFESEH:NO)
