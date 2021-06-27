# Install script for directory: C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/cryptopp")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/Debug/cryptopp-shared.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/Release/cryptopp-shared.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/MinSizeRel/cryptopp-shared.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/RelWithDebInfo/cryptopp-shared.lib")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/Debug/cryptopp-shared.dll")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/Release/cryptopp-shared.dll")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/MinSizeRel/cryptopp-shared.dll")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/RelWithDebInfo/cryptopp-shared.dll")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/Debug/cryptopp-static.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/Release/cryptopp-static.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/MinSizeRel/cryptopp-static.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/RelWithDebInfo/cryptopp-static.lib")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/cryptopp" TYPE FILE FILES
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/3way.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/adler32.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/adv-simd.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/aes.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/algebra.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/algparam.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/arc4.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/argnames.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/aria.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/asn.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/authenc.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/base32.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/base64.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/basecode.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/blake2.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/blowfish.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/blumshub.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/camellia.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/cast.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/cbcmac.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/ccm.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/chacha.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/channels.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/cmac.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/config.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/cpu.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/crc.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/cryptlib.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/default.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/des.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/dh.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/dh2.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/dll.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/dmac.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/drbg.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/dsa.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/eax.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/ec2n.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/eccrypto.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/ecp.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/ecpoint.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/elgamal.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/emsa2.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/eprecomp.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/esign.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/factory.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/fhmqv.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/files.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/filters.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/fips140.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/fltrimpl.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/gcm.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/gf256.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/gf2_32.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/gf2n.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/gfpcrypt.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/gost.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/gzip.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/hashfwd.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/hex.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/hkdf.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/hmac.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/hmqv.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/hrtimer.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/ida.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/idea.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/integer.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/iterhash.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/kalyna.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/keccak.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/lubyrack.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/luc.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/mars.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/md2.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/md4.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/md5.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/mdc.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/mersenne.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/misc.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/modarith.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/modes.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/modexppc.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/mqueue.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/mqv.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/naclite.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/nbtheory.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/network.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/nr.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/oaep.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/oids.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/osrng.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/ossig.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/padlkrng.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/panama.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/pch.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/pkcspad.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/poly1305.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/polynomi.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/ppc-simd.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/pssr.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/pubkey.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/pwdbased.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/queue.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/rabin.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/randpool.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/rc2.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/rc5.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/rc6.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/rdrand.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/resource.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/rijndael.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/ripemd.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/rng.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/rsa.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/rw.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/safer.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/salsa.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/seal.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/secblock.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/seckey.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/seed.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/serpent.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/serpentp.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/sha.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/sha3.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/shacal2.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/shark.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/simon.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/simple.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/siphash.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/skipjack.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/sm3.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/sm4.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/smartptr.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/socketft.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/sosemanuk.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/speck.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/square.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/stdcpp.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/strciphr.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/tea.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/threefish.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/tiger.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/trap.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/trdlocal.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/trunhash.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/ttmac.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/tweetnacl.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/twofish.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/vmac.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/wait.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/wake.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/whrlpool.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/winpipes.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/words.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/xtr.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/xtrcrypt.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/zdeflate.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/zinflate.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/zlib.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp" TYPE FILE FILES
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/cryptopp-config.cmake"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/cryptopp-config-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp/cryptopp-targets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp/cryptopp-targets.cmake"
         "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/CMakeFiles/Export/lib/cmake/cryptopp/cryptopp-targets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp/cryptopp-targets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp/cryptopp-targets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/CMakeFiles/Export/lib/cmake/cryptopp/cryptopp-targets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/CMakeFiles/Export/lib/cmake/cryptopp/cryptopp-targets-debug.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/CMakeFiles/Export/lib/cmake/cryptopp/cryptopp-targets-minsizerel.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/CMakeFiles/Export/lib/cmake/cryptopp/cryptopp-targets-relwithdebinfo.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/cryptopp" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/CMakeFiles/Export/lib/cmake/cryptopp/cryptopp-targets-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/Debug/cryptest.exe")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/Release/cryptest.exe")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/MinSizeRel/cryptest.exe")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/RelWithDebInfo/cryptest.exe")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cryptopp" TYPE DIRECTORY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/TestData")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cryptopp" TYPE DIRECTORY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/TestVectors")
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "C:/Users/aquawicket/digitalknob/DK/3rdParty/cryptopp600/win32/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
