#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ imm32 ############
# https://learn.microsoft.com/en-us/windows/win32/api/imm/nf-imm-immgetcontext
dk_validate(host_triple "dk_host_triple()")
if(NOT WIN)
	dk_undepend(imm32)
	dk_return()
endif()

dk_findLibrary(imm32.lib)

# MSYS2 (-limm32)
if(MSYSTEM)
	dk_set(IMM32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-limm32")
endif()
