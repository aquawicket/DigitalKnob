# https://slproweb.com/products/Win32OpenSSL.html
#
# https://slproweb.com/download/Win64OpenSSL-3_0_2.exe


#dk_import(https://slproweb.com/download/Win64OpenSSL-3_0_3.exe)

dk_set(OPENSSL_BINARY_VERSION 3.0.1)
WIN_HOST_dk_set(OPENSSL_BINARY_DL https://slproweb.com/download/Win64OpenSSL-3_0_3.exe)


### INSTALL ###
dk_set(OPENSSL_BINARY_NAME Win64OpenSSL-${OPENSSL_BINARY_VERSION})
WIN_HOST_dk_set(OPENSSL_BINARY "C:/Program Files/OpenSSL-Win64")
#MAC_HOST_dk_set(OPENSSL_BINARY /usr/bin)
#LINUX_HOST_dk_set(OPENSSL_BINARY /usr/bin)
WIN_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/bin/openssl.exe)
#MAC_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/git)
#LINUX_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/git)

#dk_info("looking for ${OPENSSL_BINARY_NAME} at ${OPENSSL_BINARY_EXE}")
if(NOT EXISTS ${OPENSSL_BINARY_EXE})
	dk_info("${OPENSSL_BINARY_NAME} NOT FOUND")
	dk_info("Installing ${OPENSSL_BINARY_NAME}")
	if(WIN_HOST)	
		dk_download(${OPENSSL_BINARY_DL} ${DKDOWNLOAD}/${OPENSSL_BINARY_NAME}.exe)
		dk_command(${DKDOWNLOAD}/${OPENSSL_BINARY_NAME}.exe)
	endif()
#	if(MAC_HOST)
#		dk_command(brew install git)
#	endif()
#	if(LINUX_HOST)
#		dk_command(sudo apt-get -y install git)
#	endif()
endif()

if(NOT EXISTS "${OPENSSL_BINARY_EXE}")
	dk_assert("OPENSSL_BINARY IS NOT FOUND OR INVALID")
endif()