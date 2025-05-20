@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

message("############################################################################")
message("#################### Linux_Arm64_Clang_Toolchain.cmake #####################")
message("############################################################################")

if(NOT Linux_Host)
	dk_exit()
endif()

#dk_depend(build-essential)
dk_depend(clang)
dk_depend(make)

dk_findProgram(CMAKE_MAKE_PROGRAM 	make)
dk_set(CMAKE_GENERATOR 				"Unix Makefiles")

#dk_set(USR_BIN						"/usr/bin")
#dk_set(USR_LOCAL_BIN				"/usr/local/bin")

###### CMAKE_C_COMPILER ######
if(EXISTS /usr/bin/clang)
	dk_set(CMAKE_C_COMPILER			/usr/bin/clang)
elseif(EXISTS /usr/local/bin/clang)
	dk_set(CMAKE_C_COMPILER			/usr/local/bin/clang)
endif()

###### CMAKE_CXX_COMPILER ######
if(EXISTS /usr/bin/clang++)
	dk_set(CMAKE_CXX_COMPILER		/usr/bin/clang++)
elseif(EXISTS /usr/local/bin/clang++)
	dk_set(CMAKE_CXX_COMPILER		/usr/local/bin/clang++)
endif()

#dk_set(CMAKE_RC_COMPILER			${CLANG_RC_COMPILER})
dk_append(CMAKE_C_FLAGS				-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu11)
dk_append(CMAKE_CXX_FLAGS			-march=x86-64 -DLINUX -DLINUX_ARM64 -std=gnu++17 -lstdc++fs)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)