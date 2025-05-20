@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

message("############################################################################")
message("####################### Mac_X86_Clang_Toolchain.cmake ######################")
message("############################################################################")

if(NOT Mac_Host)
	dk_exit()
endif()

dk_depend(xcode)
dk_depend(make)
	
dk_append(CMAKE_C_FLAGS				-DMAC i686 -DMAC_X86 -std=c17 -x objective-c)
dk_append(CMAKE_CXX_FLAGS			-DMAC i686 -DMAC_X86 -std=c++17 -x objective-c++)
dk_append(DKCONFIGURE_CFLAGS		-arch i686 -DMAC -DMAC_X86 -std=c17) #-x objective-c) # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
dk_append(DKCONFIGURE_CXXFLAGS		-arch i686 -DMAC -DMAC_X86 -std=c++17) #-x objective-c++) # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
dk_append(DKCMAKE_FLAGS				-DCMAKE_OSX_ARCHITECTURES=x86)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
	