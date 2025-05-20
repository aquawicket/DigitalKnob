#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://www.transmissionzero.co.uk/computing/win32-apps-with-mingw/
# https://github.com/TransmissionZero/MinGW-Win32-Application

#Windows_Host_dk_import(https://github.com/TransmissionZero/MinGW-Win32-Application.git)
Windows_Host_dk_import(https://github.com/TransmissionZero/MinGW-Win32-Application/archive/refs/heads/master.zip)
