# https://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/MSYS-20111123.zip
if(NOT WIN_HOST)
	dk_return()
endif()

WIN32_dk_depend(mingw32)
WIN64_dk_depend(mingw64)

dk_import(https://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/MSYS-20111123.zip)
