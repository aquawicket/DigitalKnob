#!/bin/bash

cd `dirname $0`

CC_ARM64="$(xcrun --sdk iphoneos --find clang) -isysroot $(xcrun --sdk iphoneos --show-sdk-path) -arch arm64 -miphoneos-version-min=11.0 -fembed-bitcode"

LIB_PATH="$(pwd)/ios/libs"
INCLUDE_PATH="$(pwd)/ios/include"

mkdir -p ${LIB_PATH}
mkdir -p ${INCLUDE_PATH}

check_success()
{
  if [ $? -eq 0 ]; then
    echo "Succeeded"
  else
    echo "Failed"
    exit
  fi
}

fat_create_and_clean()
{
  echo "Creating FAT binary"
  lipo -create ${LIB_PATH}/*_${1}.a -o ${LIB_PATH}/${1}.a
  check_success

  echo "Cleaning"
  rm -rf ${LIB_PATH}/*_${1}.a
}

# lz4

LZ4_FILE="lz4-1.9.3.tar.gz"
LZ4_FOLDER="lz4-1.9.3"
echo "Building lz4"
compile_lz4()
{
  echo "Unarchiving lz4"
  tar -xvJf ${LZ4_FILE} -C . >/dev/null 2>&1
  check_success

  cd $LZ4_FOLDER

  echo "Compiling for $1"
  export CC=$2
  export CXX=$2
  OUTPUT_PATH="$(pwd)/output"

  make -j4 install DESTDIR=${OUTPUT_PATH}
  check_success

  echo "Copying products"
  mkdir -p ${INCLUDE_PATH}/lz4
  cp -r output/usr/local/include/* ${INCLUDE_PATH}/lz4/
  cp output/usr/local/lib/liblz4.a ${LIB_PATH}/${1}_liblz4.a
  check_success

  echo "Cleaning"
  cd ..
  rm -rf $LZ4_FOLDER
}

compile_lz4 "arm64" "${CC_ARM64}"

fat_create_and_clean "liblz4"

# xz

XZ_FILE="xz-5.2.5.tar.gz"
XZ_FOLDER="xz-5.2.5"
echo "Building xz"
compile_xz()
{
  echo "Unarchiving xz"
  tar -xvJf ${XZ_FILE} -C . >/dev/null 2>&1
  check_success

  cd $XZ_FOLDER

  echo "Compiling for $1"
  export CC=$2
  export CXX=$2
  OUTPUT_PATH="$(pwd)/output"
  ./configure --disable-debug \
              --disable-dependency-tracking \
              --disable-silent-rules \
              --host=arm \
              --prefix=${OUTPUT_PATH}
  check_success

  make -j4 install
  check_success

  echo "Copying products"
  mkdir -p ${INCLUDE_PATH}/xz
  cp -r output/include/* ${INCLUDE_PATH}/xz/
  cp output/lib/liblzma.a ${LIB_PATH}/${1}_liblzma.a
  check_success

  echo "Cleaning"
  cd ..
  rm -rf $XZ_FOLDER
}

compile_xz "arm64" "${CC_ARM64}"

fat_create_and_clean "liblzma"

# libarchive

LIBARCHIVE_FILE="libarchive-3.5.2.tar.gz"
LIBARCHIVE_FOLDER="libarchive-3.5.2"
echo "Building libarchive"
compile_libarchive()
{
  echo "Unarchiving libarchive"
  tar -xvJf ${LIBARCHIVE_FILE} -C . >/dev/null 2>&1
  check_success

  cd $LIBARCHIVE_FOLDER

  echo "Compiling for $1"
  export CC=$2
  export CXX=$2
  OUTPUT_PATH="$(pwd)/output"
  autoreconf -f -i
  CFLAGS="$CFLAGS -I${INCLUDE_PATH}/xz -I${INCLUDE_PATH}/lz4" LDFLAGS="$LDFLAGS -L${LIB_PATH}" ./configure --without-lzo2 \
              --without-nettle \
              --without-xml2 \
              --without-openssl \
              --without-expat \
              --host=arm \
              --prefix=${OUTPUT_PATH}
  check_success

  make -j4 install
  check_success

  echo "Copying products"
  mkdir -p ${INCLUDE_PATH}/libarchive
  cp -r output/include/* ${INCLUDE_PATH}/libarchive/
  cp output/lib/libarchive.a ${LIB_PATH}/${1}_libarchive.a
  check_success

  echo "Cleaning"
  cd ..
  rm -rf $LIBARCHIVE_FOLDER
}

compile_libarchive "arm64" "${CC_ARM64}"

fat_create_and_clean "libarchive"