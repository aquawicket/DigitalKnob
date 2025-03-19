#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ microsoft.ui.xaml ############
# https://www.nuget.org/packages/Microsoft.UI.Xaml

dk_validate(NUGET_EXE "dk_depend(nuget)")
execute_process(COMMAND ${NUGET_EXE} install Microsoft.UI.Xaml)