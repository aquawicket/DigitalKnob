dk_echo("############################################################################")
dk_echo("#################### Windows_X86_64_Msvc_toolchain.cmake ###################")
dk_echo("############################################################################")
# https://learn.microsoft.com/en-us/cpp/build/projects-and-build-systems-cpp?view=msvc-170

if(NOT Windows_Host)
	dk_exit()
endif()

dk_set(MSVC 1)
dk_depend(visualstudio)

dk_set(CMAKE_GENERATOR				${VS_GENERATOR})					# https://cmake.org/cmake/help/latest/variable/CMAKE_GENERATOR.html
dk_set(CMAKE_MAKE_PROGRAM 			${VS_MAKE_PROGRAM})					# https://cmake.org/cmake/help/latest/variable/CMAKE_MAKE_PROGRAM.html
dk_set(CMAKE_GENERATOR_PLATFORM		${VS_X86_64_GENERATOR_PLATFORM})	# https://cmake.org/cmake/help/latest/variable/CMAKE_GENERATOR_PLATFORM.html
dk_set(CMAKE_CXX_COMPILER			${VS_X86_64_COMPILER})				# https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER.html
dk_set(CMAKE_C_COMPILER				${VS_X86_64_COMPILER})				# https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER.html
#dk_set(CMAKE_DUMPBIN				${VS_X86_64_DUMPBIN})
#dk_set(CMAKE_LINKER				${VS_X86_64_LINKER})
#dk_append(DKCONFIGURE_FLAGS		--build=x86_64-w64-msvc)

###### C Compiler Options ######
# https://learn.microsoft.com/en-us/cpp/build/reference/compiler-options-listed-by-category?view=msvc-170
dk_append(CMAKE_C_FLAGS				
	/bigobj						# https://learn.microsoft.com/en-us/cpp/build/reference/bigobj-increase-number-of-sections-in-dot-obj-file?view=msvc-170
	/D_CRT_SECURE_NO_WARNINGS 	# https://learn.microsoft.com/en-us/cpp/build/reference/d-preprocessor-definitions?view=msvc-170
	/D_USING_V110_SDK71_ 		# "
	/D_WINDOWS 					# "
	/DWIN 						# "
	/DWIN_X86_64 				# "
	/nologo 					# https://learn.microsoft.com/en-us/cpp/build/reference/nologo-suppress-startup-banner-c-cpp?view=msvc-170
	/std:c17 					# https://learn.microsoft.com/en-us/cpp/build/reference/std-specify-language-standard-version?view=msvc-170
	/Zc:__cplusplus 			# https://learn.microsoft.com/en-us/cpp/build/reference/zc-cplusplus?view=msvc-170
	/Zm500 						# https://learn.microsoft.com/en-us/cpp/build/reference/zm-specify-precompiled-header-memory-allocation-limit?view=msvc-170
)

###### C++ Compiler Options ######
# https://learn.microsoft.com/en-us/cpp/build/reference/compiler-options-listed-by-category?view=msvc-170
dk_append(CMAKE_CXX_FLAGS			
	/bigobj						# https://learn.microsoft.com/en-us/cpp/build/reference/bigobj-increase-number-of-sections-in-dot-obj-file?view=msvc-170
	/D_CRT_SECURE_NO_WARNINGS 	# https://learn.microsoft.com/en-us/cpp/build/reference/d-preprocessor-definitions?view=msvc-170
	/D_USING_V110_SDK71_ 		# "
	/D_WINDOWS 					# "
	/DWIN 						# "
	/DWIN_X86_64 				# "
	/nologo 					# https://learn.microsoft.com/en-us/cpp/build/reference/nologo-suppress-startup-banner-c-cpp?view=msvc-170
	/std:c++17 					# https://learn.microsoft.com/en-us/cpp/build/reference/std-specify-language-standard-version?view=msvc-170
	/Zc:__cplusplus 			# https://learn.microsoft.com/en-us/cpp/build/reference/zc-cplusplus?view=msvc-170
	/Zm500 						# https://learn.microsoft.com/en-us/cpp/build/reference/zm-specify-precompiled-header-memory-allocation-limit?view=msvc-170
)

###### Linker Options ######
# https://learn.microsoft.com/en-us/cpp/build/reference/linker-options?view=msvc-170
dk_append(CMAKE_EXE_LINKER_FLAGS
	/ENTRY:mainCRTStartup		# https://learn.microsoft.com/en-us/cpp/build/reference/entry-entry-point-symbol?view=msvc-170
	/MANIFEST:NO				# https://learn.microsoft.com/en-us/cpp/build/reference/manifest-create-side-by-side-assembly-manifest?view=msvc-170
#	/MANIFESTUAC:NO				# https://learn.microsoft.com/en-us/cpp/build/reference/manifestuac-embeds-uac-information-in-manifest?view=msvc-170
	/MANIFESTUAC:"level='highestAvailable' uiAccess='true'"
	/SAFESEH:NO					# https://learn.microsoft.com/en-us/cpp/build/reference/safeseh-image-has-safe-exception-handlers?view=msvc-170
	/SUBSYSTEM:CONSOLE #,5.01	# https://learn.microsoft.com/en-us/cpp/build/reference/subsystem-specify-subsystem?view=msvc-170
)

###### Linker Options (Release) ######
dk_append(CMAKE_EXE_LINKER_FLAGS_RELEASE
	/INCREMENTAL:NO				# https://learn.microsoft.com/en-us/cpp/build/reference/incremental-link-incrementally?view=msvc-170
#	/OPT:NOREF					# https://learn.microsoft.com/en-us/cpp/build/reference/opt-optimizations?view=msvc-170
#	/FORCE 						# https://learn.microsoft.com/en-us/cpp/build/reference/force-force-file-output?view=msvc-170
								# MySQL lib needs /FORCE due to zlib redefinitions
)
