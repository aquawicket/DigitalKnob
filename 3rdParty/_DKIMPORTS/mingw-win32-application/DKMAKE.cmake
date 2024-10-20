#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://www.transmissionzero.co.uk/computing/win32-apps-with-mingw/
# https://github.com/TransmissionZero/MinGW-Win32-Application

#WIN_HOST_dk_import(https://github.com/TransmissionZero/MinGW-Win32-Application.git)
WIN_HOST_dk_import(https://github.com/TransmissionZero/MinGW-Win32-Application/archive/refs/heads/master.zip)
