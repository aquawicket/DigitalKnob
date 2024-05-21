# https://github.com/curl/curl
# https://curl.se/
# https://robertying.io/posts/compile-openssl-and-curl-for-android
# https://curl.se/docs/install.html


### DEPEND ###
dk_depend(dl)
dk_depend(libbcrypt)
dk_depend(libpsl)
dk_depend(libssh2)
dk_depend(openssl)
dk_depend(pthread)
dk_depend(system_configuration)
dk_depend(ws2_32)
dk_depend(zlib)
dk_depend(zstd)


### IMPORT ###
#if(MSVC)
#	WIN_dk_import			(https://github.com/curl/curl/archive/refs/tags/curl-7_43_0.zip)
if(WIN)
	dk_import				(https://github.com/curl/curl.git)
else()
	#dk_import				(https://github.com/curl/curl/archive/refs/tags/curl-7_84_0.zip)
	dk_import				(https://github.com/curl/curl/releases/download/curl-8_6_0/curl-8.6.0.zip)
endif()


### LINK ###
dk_define				(CURL_STATICLIB)
dk_include				(${CURL}/include 								CURL_INCLUDE_DIR)
dk_include				(${CURL}/${OS}/include/curl						CURL_INCLUDE_DIR2)
DEBUG_dk_include		(${CURL}/${OS}/${DEBUG_DIR}/include/curl		CURL_INCLUDE_DIR2)
RELEASE_dk_include		(${CURL}/${OS}/${RELEASE_DIR}/include/curl		CURL_INCLUDE_DIR2)

if(MULTI_CONFIG)
	set(CURL_DEBUG_DIR ${CURL}/${OS}/lib/${DEBUG_DIR})
	set(CURL_RELEASE_DIR ${CURL}/${OS}/lib/${RELEASE_DIR})
else()
	set(CURL_DEBUG_DIR ${CURL}/${OS}/${DEBUG_DIR}/lib)
	set(CURL_RELEASE_DIR ${CURL}/${OS}/${RELEASE_DIR}/lib)
endif()

if(MSVC)
	WIN_dk_libDebug		(${CURL_DEBUG_DIR}/libcurl.lib					CURL_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${CURL_RELEASE_DIR}/libcurl.lib				CURL_LIBRARY_RELEASE)
else()	
	dk_libDebug		(${CURL_DEBUG_DIR}/libcurl-d.a					CURL_LIBRARY_DEBUG)
	dk_libRelease		(${CURL_RELEASE_DIR}/libcurl.a					CURL_LIBRARY_RELEASE)
endif()




### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set		(CURL_CMAKE -DCURL_INCLUDE_DIR=${CURL_INCLUDE_DIR} -DCURL_LIBRARY=${CURL_LIBRARY_RELEASE} "-DCMAKE_C_FLAGS=/I${CURL}/${OS}/include/curl")
elseif()
	dk_set			(CURL_CMAKE -DCURL_INCLUDE_DIR=${CURL_INCLUDE_DIR} -DCURL_LIBRARY=${CURL_LIBRARY_RELEASE} "-DCMAKE_C_FLAGS=-I${CURL}/${OS}/include")
endif()



### GENERATE ###
if(MSVC)
	WIN_dk_configure(${CURL}
		-DBUILD_CURL_EXE=ON								# "Set to ON to build curl executable." ON
		-DBUILD_LIBCURL_DOCS=OFF 						# "to build libcurl man pages" ON
		-DBUILD_SHARED_LIBS=OFF							# "Build shared libraries" ON
		-DBUILD_TESTING=OFF								# "Build tests" OFF
		-DCURL_BROTLI=OFF								# "Set to ON to enable building curl with brotli support." OFF
		-DCURL_DISABLE_ALTSVC=OFF						# "disables alt-svc support" OFF
		-DCURL_DISABLE_COOKIES=ON						# "disables cookies support" OFF
		-DCURL_DISABLE_DICT=OFF							# "disables DICT" OFF
		-DCURL_DISABLE_DOH=OFF							# "disables DNS-over-HTTPS" OFF
		-DCURL_DISABLE_FILE=OFF							# "disables FILE" OFF
		-DCURL_DISABLE_FTP=OFF							# "disables FTP" OFF
		-DCURL_DISABLE_GETOPTIONS=OFF					# "disables curl_easy_options API for existing options to curl_easy_setopt" OFF
		-DCURL_DISABLE_GOPHER=OFF						# "disables Gopher" OFF
		-DCURL_DISABLE_HSTS=OFF							# "disables HSTS support" OFF
		-DCURL_DISABLE_HTTP=OFF							# "disables HTTP" OFF
		-DCURL_DISABLE_HTTP_AUTH=OFF					# "disables all HTTP authentication methods" OFF
		-DCURL_DISABLE_IMAP=OFF							# "disables IMAP" OFF
		-DCURL_DISABLE_LDAP=ON							# "disables LDAP" OFF
		-DCURL_DISABLE_LDAPS=ON							# "disables LDAPS" OFF
		-DCURL_DISABLE_LIBCURL_OPTION=OFF				# "disables --libcurl option from the curl tool" OFF
		-DCURL_DISABLE_MIME=OFF							# "disables MIME support" OFF
		-DCURL_DISABLE_MQTT=OFF							# "disables MQTT" OFF
		-DCURL_DISABLE_NETRC=OFF						# "disables netrc parser" OFF
		-DCURL_DISABLE_NTLM=OFF							# "disables NTLM support" OFF
		-DCURL_DISABLE_OPENSSL_AUTO_LOAD_CONFIG=OFF		# "Disable automatic loading of OpenSSL configuration" OFF
		-DCURL_DISABLE_PARSEDATE=OFF					# "disables date parsing" OFF
		-DCURL_DISABLE_POP3=OFF							# "disables POP3" OFF
		-DCURL_DISABLE_PROGRESS_METER=OFF				# "disables built-in progress meter" OFF
		-DCURL_DISABLE_PROXY=OFF						# "disables proxy support" OFF
		-DCURL_DISABLE_RTSP=OFF							# "disables RTSP" OFF
		-DCURL_DISABLE_SHUFFLE_DNS=OFF					# "disables shuffle DNS feature" OFF
		-DCURL_DISABLE_SMB=OFF							# "disables SMB" OFF
		-DCURL_DISABLE_SMTP=OFF							# "disables SMTP" OFF
		-DCURL_DISABLE_SOCKETPAIR=OFF					# "disables use of socketpair for curl_multi_poll" OFF
		-DCURL_DISABLE_TELNET=OFF						# "disables Telnet" OFF
		-DCURL_DISABLE_TFTP=OFF							# "disables TFTP" OFF
		-DCURL_DISABLE_VERBOSE_STRINGS=OFF				# "disables verbose strings" OFF
		-DCURL_ENABLE_EXPORT_TARGET=ON					# "to enable cmake export target" ON
		-DCURL_ENABLE_SSL=ON							# "Enable SSL support" ON
		-DCURL_LTO=OFF									# "Turn on compiler Link Time Optimizations" OFF
		-DCURL_STATIC_CRT=OFF							# "Set to ON to build libcurl with static CRT on Windows /MT" OFF
		-DCURL_USE_BEARSSL=OFF							# "Enable BearSSL for SSL/TLS" OFF
		-DCURL_USE_GSSAPI=OFF							# "Use GSSAPI implementation 'right now only Heimdal is supported with CMake build'" OFF
		-DCURL_USE_LIBPSL=OFF							# "Use libPSL" ON
		-DCURL_USE_LIBSSH2=OFF							# "Use libSSH2" ON
		-DCURL_USE_LIBSSH=OFF							# "Use libSSH2" ON
		-DCURL_USE_OPENSSL=${OPENSSL}					# "Enable OpenSSL for SSL/TLS" ${openssl_default} CURL_ENABLE_SSL OFF
		-DCURL_USE_SCHANNEL=OFF							# "Enable Windows native SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_USE_SECTRANSP=OFF						# "Enable Apple OS native SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_USE_WOLFSSL=OFF							# "Enable wolfSSL for SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_WERROR=OFF								# "Turn compiler warnings into errors" OFF
		-DCURL_WINDOWS_SSPI=ON							# "Use windows libraries to allow NTLM authentication without OpenSSL" ON
		-DCURL_ZSTD=${ZSTD}								# "Set to ON to enable building curl with zstd support." OFF
		-DENABLE_ARES=OFF								# "Set to ON to enable c-ares support" OFF
		-DENABLE_CURLDEBUG=OFF							# "Set to ON to build with TrackMemory feature enabled" OFF
		-DENABLE_CURL_MANUAL=OFF						# "to build the man page for curl and enable its -M/--manual option" OFF
		-DENABLE_DEBUG=OFF								# "Set to ON to enable curl debug features" OFF
		-DENABLE_IPV6=OFF								# "Define to enable IPv6 support" ON
		-DENABLE_THREADED_RESOLVER=OFF					# "Set to ON to enable threaded DNS lookup" ON "NOT ENABLE_ARES" OFF
		-DENABLE_UNICODE=OFF							# "Set to ON to use the Unicode version of the Windows API functions" OFF
		-DENABLE_UNIX_SOCKETS=OFF						# "Define for want Unix domain sockets support" ON
		-DHTTP_ONLY=OFF									# "disables all protocols except HTTP 'This overrides all CURL_DISABLE_* options'" OFF
		-DPICKY_COMPILER=ON								# "Enable picky compiler options" ON
		-DUSE_LIBIDN2=OFF								# "Use libidn2 for IDN support" ON
		-DUSE_MSH3=OFF									# "Use msquic library for HTTP/3 support" OFF
		-DUSE_NGHTTP2=OFF								# "Use nghttp2 library" OFF
		-DUSE_NGTCP2=OFF								# "Use ngtcp2 and nghttp3 libraries for HTTP/3 support" OFF
		-DUSE_QUICHE=OFF								# "Use quiche library for HTTP/3 support" OFF
		-DUSE_WIN32_IDN=OFF								# "Use WinIDN for IDN support" OFF
		-DUSE_WIN32_LDAP=OFF					# "Use Windows LDAP implementation" ON
		${LIBBCRYPT_CMAKE}
		${LIBPSL_CMAKE}
		${LIBSSH2_CMAKE}
		${OPENSSL_CMAKE}
		${PTHREAD_CMAKE}
		${WS2_32_LIB_CMAKE}
		${ZLIB_CMAKE}
		${ZSTD_CMAKE})
elseif(ANDROID)
	dk_configure(${CURL}
		-DBUILD_CURL_EXE=OFF
		-DBUILD_CURL_TESTS=OFF
		-DBUILD_LIBCURL_DOCS=OFF 						# "to build libcurl man pages" ON
		-DCURL_DISABLE_LDAP=ON
		-DCURL_STATICLIB=ON
		-DCURL_USE_OPENSSL=OFF
		-DCURL_ZSTD=${ZSTD}
		-DHAVE_GLIBC_STRERROR_R=advanced
		-DHAVE_GLIBC_STRERROR_R__TRYRUN_OUTPUT=advanced
		-DHAVE_POSIX_STRERROR_R=0	#ANDROID_HOST
		${OPENSSL_CMAKE}
		${ZLIB_CMAKE}
		${ZSTD_CMAKE})
elseif(IOS OR IOSSIM)
	dk_configure(${CURL}
		#-DHAVE_POSIX_STRERROR_R=advanced
		#-DHAVE_POSIX_STRERROR_R__TRYRUN_OUTPUT=advanced
		-DBUILD_CURL_EXE=OFF
		-DBUILD_CURL_TESTS=OFF
		-DBUILD_LIBCURL_DOCS=OFF 						# "to build libcurl man pages" ON
		-DCURL_DISABLE_LDAP=ON
		-DCURL_STATICLIB=ON
		-DCURL_USE_OPENSSL=OFF
		-DCURL_ZSTD=${ZSTD}
		-DHAVE_GLIBC_STRERROR_R=advanced
		-DHAVE_GLIBC_STRERROR_R__TRYRUN_OUTPUT=advanced
		-DHAVE_POLL_FINE_EXITCODE=advanced
		-DHAVE_POLL_FINE_EXITCODE__TRYRUN_OUTPUT=advanced
		-DHAVE_POSIX_STRERROR_R=0
		${OPENSSL_CMAKE}
		${ZLIB_CMAKE}
		${ZSTD_CMAKE})
elseif(MAC)
	dk_configure(${CURL}
		-DBUILD_CURL_EXE=ON								# "Set to ON to build curl executable." ON
		-DBUILD_LIBCURL_DOCS=OFF 						# "to build libcurl man pages" ON
		-DBUILD_SHARED_LIBS=OFF							# "Build shared libraries" ON
		-DBUILD_TESTING=OFF								# "Build tests" OFF
		-DCURL_BROTLI=OFF								# "Set to ON to enable building curl with brotli support." OFF
		-DCURL_DISABLE_ALTSVC=OFF						# "disables alt-svc support" OFF
		-DCURL_DISABLE_COOKIES=ON						# "disables cookies support" OFF
		-DCURL_DISABLE_DICT=OFF							# "disables DICT" OFF
		-DCURL_DISABLE_DOH=OFF							# "disables DNS-over-HTTPS" OFF
		-DCURL_DISABLE_FILE=OFF							# "disables FILE" OFF
		-DCURL_DISABLE_FTP=OFF							# "disables FTP" OFF
		-DCURL_DISABLE_GETOPTIONS=OFF					# "disables curl_easy_options API for existing options to curl_easy_setopt" OFF
		-DCURL_DISABLE_GOPHER=OFF						# "disables Gopher" OFF
		-DCURL_DISABLE_HSTS=OFF							# "disables HSTS support" OFF
		-DCURL_DISABLE_HTTP=OFF							# "disables HTTP" OFF
		-DCURL_DISABLE_HTTP_AUTH=OFF					# "disables all HTTP authentication methods" OFF
		-DCURL_DISABLE_IMAP=OFF							# "disables IMAP" OFF
		-DCURL_DISABLE_LDAP=ON							# "disables LDAP" OFF
		-DCURL_DISABLE_LDAPS=ON							# "disables LDAPS" OFF
		-DCURL_DISABLE_LIBCURL_OPTION=OFF				# "disables --libcurl option from the curl tool" OFF
		-DCURL_DISABLE_MIME=OFF							# "disables MIME support" OFF
		-DCURL_DISABLE_MQTT=OFF							# "disables MQTT" OFF
		-DCURL_DISABLE_NETRC=OFF						# "disables netrc parser" OFF
		-DCURL_DISABLE_NTLM=OFF							# "disables NTLM support" OFF
		-DCURL_DISABLE_OPENSSL_AUTO_LOAD_CONFIG=OFF		# "Disable automatic loading of OpenSSL configuration" OFF
		-DCURL_DISABLE_PARSEDATE=OFF					# "disables date parsing" OFF
		-DCURL_DISABLE_POP3=OFF							# "disables POP3" OFF
		-DCURL_DISABLE_PROGRESS_METER=OFF				# "disables built-in progress meter" OFF
		-DCURL_DISABLE_PROXY=OFF						# "disables proxy support" OFF
		-DCURL_DISABLE_RTSP=OFF							# "disables RTSP" OFF
		-DCURL_DISABLE_SHUFFLE_DNS=OFF					# "disables shuffle DNS feature" OFF
		-DCURL_DISABLE_SMB=OFF							# "disables SMB" OFF
		-DCURL_DISABLE_SMTP=OFF							# "disables SMTP" OFF
		-DCURL_DISABLE_SOCKETPAIR=OFF					# "disables use of socketpair for curl_multi_poll" OFF
		-DCURL_DISABLE_TELNET=OFF						# "disables Telnet" OFF
		-DCURL_DISABLE_TFTP=OFF							# "disables TFTP" OFF
		-DCURL_DISABLE_VERBOSE_STRINGS=OFF				# "disables verbose strings" OFF
		-DCURL_ENABLE_EXPORT_TARGET=ON					# "to enable cmake export target" ON
		-DCURL_ENABLE_SSL=ON							# "Enable SSL support" ON
		-DCURL_LTO=OFF									# "Turn on compiler Link Time Optimizations" OFF
		-DCURL_STATIC_CRT=OFF							# "Set to ON to build libcurl with static CRT on Windows /MT" OFF
		-DCURL_USE_BEARSSL=OFF							# "Enable BearSSL for SSL/TLS" OFF
		-DCURL_USE_GSSAPI=OFF							# "Use GSSAPI implementation 'right now only Heimdal is supported with CMake build'" OFF
		-DCURL_USE_LIBPSL=OFF							# "Use libPSL" ON
		-DCURL_USE_LIBSSH2=OFF							# "Use libSSH2" ON
		-DCURL_USE_LIBSSH=OFF							# "Use libSSH2" ON
		-DCURL_USE_OPENSSL=${OPENSSL}					# "Enable OpenSSL for SSL/TLS" ${openssl_default} CURL_ENABLE_SSL OFF
		-DCURL_USE_SCHANNEL=OFF							# "Enable Windows native SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_USE_SECTRANSP=OFF						# "Enable Apple OS native SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_USE_WOLFSSL=OFF							# "Enable wolfSSL for SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_WERROR=OFF								# "Turn compiler warnings into errors" OFF
		-DCURL_WINDOWS_SSPI=OFF							# "Use windows libraries to allow NTLM authentication without OpenSSL" ON
		-DCURL_ZSTD=${ZSTD}								# "Set to ON to enable building curl with zstd support." OFF
		-DENABLE_ARES=OFF								# "Set to ON to enable c-ares support" OFF
		-DENABLE_CURLDEBUG=OFF							# "Set to ON to build with TrackMemory feature enabled" OFF
		-DENABLE_CURL_MANUAL=OFF						# "to build the man page for curl and enable its -M/--manual option" OFF
		-DENABLE_DEBUG=OFF								# "Set to ON to enable curl debug features" OFF
		-DENABLE_IPV6=OFF								# "Define to enable IPv6 support" ON
		-DENABLE_THREADED_RESOLVER=OFF					# "Set to ON to enable threaded DNS lookup" ON "NOT ENABLE_ARES" OFF
		-DENABLE_UNICODE=OFF							# "Set to ON to use the Unicode version of the Windows API functions" OFF
		-DENABLE_UNIX_SOCKETS=ON						# "Define for want Unix domain sockets support" ON
		-DHTTP_ONLY=OFF									# "disables all protocols except HTTP 'This overrides all CURL_DISABLE_* options'" OFF
		-DPICKY_COMPILER=ON								# "Enable picky compiler options" ON
		-DUSE_LIBIDN2=OFF								# "Use libidn2 for IDN support" ON
		-DUSE_MSH3=OFF									# "Use msquic library for HTTP/3 support" OFF
		-DUSE_NGHTTP2=OFF								# "Use nghttp2 library" OFF
		-DUSE_NGTCP2=OFF								# "Use ngtcp2 and nghttp3 libraries for HTTP/3 support" OFF
		-DUSE_QUICHE=OFF								# "Use quiche library for HTTP/3 support" OFF
		-DUSE_WIN32_IDN=OFF								# "Use WinIDN for IDN support" OFF
		-DUSE_WIN32_LDAP=OFF							# "Use Windows LDAP implementation" ON
		${OPENSSL_CMAKE}
		${ZLIB_CMAKE}
		${ZSTD_CMAKE})
elseif(LINUX)
	dk_configure(${CURL}
		-DBUILD_CURL_EXE=ON								# "Set to ON to build curl executable." ON
		-DBUILD_LIBCURL_DOCS=OFF 						# "to build libcurl man pages" ON
		-DBUILD_SHARED_LIBS=OFF							# "Build shared libraries" ON
		-DBUILD_TESTING=OFF								# "Build tests" OFF
		-DCURL_BROTLI=OFF								# "Set to ON to enable building curl with brotli support." OFF
		-DCURL_DISABLE_ALTSVC=OFF						# "disables alt-svc support" OFF
		-DCURL_DISABLE_COOKIES=ON						# "disables cookies support" OFF
		-DCURL_DISABLE_DICT=OFF							# "disables DICT" OFF
		-DCURL_DISABLE_DOH=OFF							# "disables DNS-over-HTTPS" OFF
		-DCURL_DISABLE_FILE=OFF							# "disables FILE" OFF
		-DCURL_DISABLE_FTP=OFF							# "disables FTP" OFF
		-DCURL_DISABLE_GETOPTIONS=OFF					# "disables curl_easy_options API for existing options to curl_easy_setopt" OFF
		-DCURL_DISABLE_GOPHER=OFF						# "disables Gopher" OFF
		-DCURL_DISABLE_HSTS=OFF							# "disables HSTS support" OFF
		-DCURL_DISABLE_HTTP=OFF							# "disables HTTP" OFF
		-DCURL_DISABLE_HTTP_AUTH=OFF					# "disables all HTTP authentication methods" OFF
		-DCURL_DISABLE_IMAP=OFF							# "disables IMAP" OFF
		-DCURL_DISABLE_LDAP=ON							# "disables LDAP" OFF
		-DCURL_DISABLE_LDAPS=ON							# "disables LDAPS" OFF
		-DCURL_DISABLE_LIBCURL_OPTION=OFF				# "disables --libcurl option from the curl tool" OFF
		-DCURL_DISABLE_MIME=OFF							# "disables MIME support" OFF
		-DCURL_DISABLE_MQTT=OFF							# "disables MQTT" OFF
		-DCURL_DISABLE_NETRC=OFF						# "disables netrc parser" OFF
		-DCURL_DISABLE_NTLM=OFF							# "disables NTLM support" OFF
		-DCURL_DISABLE_OPENSSL_AUTO_LOAD_CONFIG=OFF		# "Disable automatic loading of OpenSSL configuration" OFF
		-DCURL_DISABLE_PARSEDATE=OFF					# "disables date parsing" OFF
		-DCURL_DISABLE_POP3=OFF							# "disables POP3" OFF
		-DCURL_DISABLE_PROGRESS_METER=OFF				# "disables built-in progress meter" OFF
		-DCURL_DISABLE_PROXY=OFF						# "disables proxy support" OFF
		-DCURL_DISABLE_RTSP=OFF							# "disables RTSP" OFF
		-DCURL_DISABLE_SHUFFLE_DNS=OFF					# "disables shuffle DNS feature" OFF
		-DCURL_DISABLE_SMB=OFF							# "disables SMB" OFF
		-DCURL_DISABLE_SMTP=OFF							# "disables SMTP" OFF
		-DCURL_DISABLE_SOCKETPAIR=OFF					# "disables use of socketpair for curl_multi_poll" OFF
		-DCURL_DISABLE_TELNET=OFF						# "disables Telnet" OFF
		-DCURL_DISABLE_TFTP=OFF							# "disables TFTP" OFF
		-DCURL_DISABLE_VERBOSE_STRINGS=OFF				# "disables verbose strings" OFF
		-DCURL_ENABLE_EXPORT_TARGET=ON					# "to enable cmake export target" ON
		-DCURL_ENABLE_SSL=ON							# "Enable SSL support" ON
		-DCURL_LTO=OFF									# "Turn on compiler Link Time Optimizations" OFF
		-DCURL_STATIC_CRT=OFF							# "Set to ON to build libcurl with static CRT on Windows /MT" OFF
		-DCURL_USE_BEARSSL=OFF							# "Enable BearSSL for SSL/TLS" OFF
		-DCURL_USE_GSSAPI=OFF							# "Use GSSAPI implementation 'right now only Heimdal is supported with CMake build'" OFF
		-DCURL_USE_LIBPSL=OFF							# "Use libPSL" ON
		-DCURL_USE_LIBSSH2=OFF							# "Use libSSH2" ON
		-DCURL_USE_LIBSSH=OFF							# "Use libSSH2" ON
		-DCURL_USE_OPENSSL=${OPENSSL}					# "Enable OpenSSL for SSL/TLS" ${openssl_default} CURL_ENABLE_SSL OFF
		-DCURL_USE_SCHANNEL=OFF							# "Enable Windows native SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_USE_SECTRANSP=OFF						# "Enable Apple OS native SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_USE_WOLFSSL=OFF							# "Enable wolfSSL for SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_WERROR=OFF								# "Turn compiler warnings into errors" OFF
		-DCURL_WINDOWS_SSPI=OFF							# "Use windows libraries to allow NTLM authentication without OpenSSL" ON
		-DCURL_ZSTD=${ZSTD}								# "Set to ON to enable building curl with zstd support." OFF
		-DENABLE_ARES=OFF								# "Set to ON to enable c-ares support" OFF
		-DENABLE_CURLDEBUG=OFF							# "Set to ON to build with TrackMemory feature enabled" OFF
		-DENABLE_CURL_MANUAL=OFF						# "to build the man page for curl and enable its -M/--manual option" OFF
		-DENABLE_DEBUG=OFF								# "Set to ON to enable curl debug features" OFF
		-DENABLE_IPV6=OFF								# "Define to enable IPv6 support" ON
		-DENABLE_THREADED_RESOLVER=OFF					# "Set to ON to enable threaded DNS lookup" ON "NOT ENABLE_ARES" OFF
		-DENABLE_UNICODE=OFF							# "Set to ON to use the Unicode version of the Windows API functions" OFF
		-DENABLE_UNIX_SOCKETS=ON						# "Define for want Unix domain sockets support" ON
		-DHTTP_ONLY=OFF									# "disables all protocols except HTTP 'This overrides all CURL_DISABLE_* options'" OFF
		-DPICKY_COMPILER=ON								# "Enable picky compiler options" ON
		-DUSE_LIBIDN2=OFF								# "Use libidn2 for IDN support" ON
		-DUSE_MSH3=OFF									# "Use msquic library for HTTP/3 support" OFF
		-DUSE_NGHTTP2=OFF								# "Use nghttp2 library" OFF
		-DUSE_NGTCP2=OFF								# "Use ngtcp2 and nghttp3 libraries for HTTP/3 support" OFF
		-DUSE_QUICHE=OFF								# "Use quiche library for HTTP/3 support" OFF
		-DUSE_WIN32_IDN=OFF								# "Use WinIDN for IDN support" OFF
		-DUSE_WIN32_LDAP=OFF							# "Use Windows LDAP implementation" ON
		${OPENSSL_CMAKE}
		${ZLIB_CMAKE}
		${ZSTD_CMAKE})
else()
	dk_configure(${CURL}
		-DBUILD_CURL_EXE=ON								# "Set to ON to build curl executable." ON
		-DBUILD_LIBCURL_DOCS=OFF 						# "to build libcurl man pages" ON
		-DBUILD_SHARED_LIBS=OFF							# "Build shared libraries" ON
		-DBUILD_TESTING=OFF								# "Build tests" OFF
		-DCURL_BROTLI=OFF								# "Set to ON to enable building curl with brotli support." OFF
		-DCURL_DISABLE_ALTSVC=OFF						# "disables alt-svc support" OFF
		-DCURL_DISABLE_COOKIES=ON						# "disables cookies support" OFF
		-DCURL_DISABLE_DICT=OFF							# "disables DICT" OFF
		-DCURL_DISABLE_DOH=OFF							# "disables DNS-over-HTTPS" OFF
		-DCURL_DISABLE_FILE=OFF							# "disables FILE" OFF
		-DCURL_DISABLE_FTP=OFF							# "disables FTP" OFF
		-DCURL_DISABLE_GETOPTIONS=OFF					# "disables curl_easy_options API for existing options to curl_easy_setopt" OFF
		-DCURL_DISABLE_GOPHER=OFF						# "disables Gopher" OFF
		-DCURL_DISABLE_HSTS=OFF							# "disables HSTS support" OFF
		-DCURL_DISABLE_HTTP=OFF							# "disables HTTP" OFF
		-DCURL_DISABLE_HTTP_AUTH=OFF					# "disables all HTTP authentication methods" OFF
		-DCURL_DISABLE_IMAP=OFF							# "disables IMAP" OFF
		-DCURL_DISABLE_LDAP=ON							# "disables LDAP" OFF
		-DCURL_DISABLE_LDAPS=ON							# "disables LDAPS" OFF
		-DCURL_DISABLE_LIBCURL_OPTION=OFF				# "disables --libcurl option from the curl tool" OFF
		-DCURL_DISABLE_MIME=OFF							# "disables MIME support" OFF
		-DCURL_DISABLE_MQTT=OFF							# "disables MQTT" OFF
		-DCURL_DISABLE_NETRC=OFF						# "disables netrc parser" OFF
		-DCURL_DISABLE_NTLM=OFF							# "disables NTLM support" OFF
		-DCURL_DISABLE_OPENSSL_AUTO_LOAD_CONFIG=OFF		# "Disable automatic loading of OpenSSL configuration" OFF
		-DCURL_DISABLE_PARSEDATE=OFF					# "disables date parsing" OFF
		-DCURL_DISABLE_POP3=OFF							# "disables POP3" OFF
		-DCURL_DISABLE_PROGRESS_METER=OFF				# "disables built-in progress meter" OFF
		-DCURL_DISABLE_PROXY=OFF						# "disables proxy support" OFF
		-DCURL_DISABLE_RTSP=OFF							# "disables RTSP" OFF
		-DCURL_DISABLE_SHUFFLE_DNS=OFF					# "disables shuffle DNS feature" OFF
		-DCURL_DISABLE_SMB=OFF							# "disables SMB" OFF
		-DCURL_DISABLE_SMTP=OFF							# "disables SMTP" OFF
		-DCURL_DISABLE_SOCKETPAIR=OFF					# "disables use of socketpair for curl_multi_poll" OFF
		-DCURL_DISABLE_TELNET=OFF						# "disables Telnet" OFF
		-DCURL_DISABLE_TFTP=OFF							# "disables TFTP" OFF
		-DCURL_DISABLE_VERBOSE_STRINGS=OFF				# "disables verbose strings" OFF
		-DCURL_ENABLE_EXPORT_TARGET=ON					# "to enable cmake export target" ON
		-DCURL_ENABLE_SSL=ON							# "Enable SSL support" ON
		-DCURL_LTO=OFF									# "Turn on compiler Link Time Optimizations" OFF
		-DCURL_STATIC_CRT=OFF							# "Set to ON to build libcurl with static CRT on Windows /MT" OFF
		-DCURL_USE_BEARSSL=OFF							# "Enable BearSSL for SSL/TLS" OFF
		-DCURL_USE_GSSAPI=OFF							# "Use GSSAPI implementation 'right now only Heimdal is supported with CMake build'" OFF
		-DCURL_USE_LIBPSL=OFF							# "Use libPSL" ON
		-DCURL_USE_LIBSSH2=OFF							# "Use libSSH2" ON
		-DCURL_USE_LIBSSH=OFF							# "Use libSSH2" ON
		-DCURL_USE_OPENSSL=${OPENSSL}					# "Enable OpenSSL for SSL/TLS" ${openssl_default} CURL_ENABLE_SSL OFF
		-DCURL_USE_SCHANNEL=OFF							# "Enable Windows native SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_USE_SECTRANSP=OFF						# "Enable Apple OS native SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_USE_WOLFSSL=OFF							# "Enable wolfSSL for SSL/TLS" OFF CURL_ENABLE_SSL OFF
		-DCURL_WERROR=OFF								# "Turn compiler warnings into errors" OFF
		-DCURL_WINDOWS_SSPI=ON							# "Use windows libraries to allow NTLM authentication without OpenSSL" ON
		-DCURL_ZSTD=${ZSTD}								# "Set to ON to enable building curl with zstd support." OFF
		-DENABLE_ARES=OFF								# "Set to ON to enable c-ares support" OFF
		-DENABLE_CURLDEBUG=OFF							# "Set to ON to build with TrackMemory feature enabled" OFF
		-DENABLE_DEBUG=OFF								# "Set to ON to enable curl debug features" OFF
		-DENABLE_IPV6=OFF								# "Define to enable IPv6 support" ON
		-DENABLE_THREADED_RESOLVER=OFF					# "Set to ON to enable threaded DNS lookup" ON "NOT ENABLE_ARES" OFF
		-DENABLE_UNICODE=OFF							# "Set to ON to use the Unicode version of the Windows API functions" OFF
		-DENABLE_UNIX_SOCKETS=ON						# "Define for want Unix domain sockets support" ON
		-DHTTP_ONLY=OFF									# "disables all protocols except HTTP 'This overrides all CURL_DISABLE_* options'" OFF
		-DPICKY_COMPILER=ON								# "Enable picky compiler options" ON
		-DUSE_LIBIDN2=OFF								# "Use libidn2 for IDN support" ON
		-DUSE_MSH3=OFF									# "Use msquic library for HTTP/3 support" OFF
		-DUSE_NGHTTP2=OFF								# "Use nghttp2 library" OFF
		-DUSE_NGTCP2=OFF								# "Use ngtcp2 and nghttp3 libraries for HTTP/3 support" OFF
		-DUSE_QUICHE=OFF								# "Use quiche library for HTTP/3 support" OFF
		-DUSE_WIN32_IDN=OFF								# "Use WinIDN for IDN support" OFF
		-DUSE_WIN32_LDAP=OFF							# "Use Windows LDAP implementation" ON
		${OPENSSL_CMAKE}
		${ZLIB_CMAKE}
		${ZSTD_CMAKE})
endif()


### COMPILE ###
dk_build(${CURL}) # libcurl)


# arm64
#export TARGET_HOST=aarch64-linux-android
#export TOOLCHAIN=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$HOST_TAG
#export PATH=$TOOLCHAIN/bin:$PATH
#export AR=$TOOLCHAIN/bin/$TARGET_HOST-ar
#export AS=$TOOLCHAIN/bin/$TARGET_HOST-as
#export CC=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang
#export CXX=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang++
#export LD=$TOOLCHAIN/bin/$TARGET_HOST-ld
#export RANLIB=$TOOLCHAIN/bin/$TARGET_HOST-ranlib
#export STRIP=$TOOLCHAIN/bin/$TARGET_HOST-strip
#export SSL_DIR=$PWD/../openssl/build/arm64-v8a
#./configure --host=$TARGET_HOST --target=$TARGET_HOST --prefix=$PWD/build/arm64-v8a --disable-shared --with-ssl=$SSL_DIR
