# https://slproweb.com/products/Win32OpenSSL.html
# https://slproweb.com/download/Win64OpenSSL-3_0_4.exe


### INSTALL ###
WIN_HOST_dk_set(OPENSSL_BINARY "C:/Program Files/OpenSSL-Win64")
WIN_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/bin/openssl.exe)

MAC_HOST_dk_set(OPENSSL_BINARY /usr/bin)
MAC_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/openssl)

LINUX_HOST_dk_set(OPENSSL_BINARY /usr/bin)
LINUX_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/openssl)

if(NOT EXISTS ${OPENSSL_BINARY_EXE})
	dk_info("Installing openssl_binary")
	if(WIN_HOST)	
		dk_download(https://slproweb.com/download/Win64OpenSSL-3_0_4.exe ${DKDOWNLOAD}/Win64OpenSSL-3_0_4.exe)
		dk_command(${DKDOWNLOAD}/Win64OpenSSL-3_0_4.exe)
		#dk_import(https://slproweb.com/download/Win64OpenSSL-3_0_4.exe)
	endif()
	if(MAC_HOST)
		dk_command(brew install openssl)
	endif()
	if(LINUX_HOST)
		dk_command(sudo apt-get -y install openssl)
	endif()
endif()

if(NOT EXISTS "${OPENSSL_BINARY_EXE}")
	dk_assert("openssl_binary IS NOT FOUND OR INVALID")
endif()