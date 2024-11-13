#!/bin/sh

rm -rf build

###### Configure helloWorld ######
CMAKE_EXE="/C/Users/Administrator/digitalknob/DKTools/cmake-3.29.5-windows-x86_64/bin/cmake.exe"
CMAKE_SOURCE_DIR="${PWD}"
CMAKE_BINARY_DIR="${PWD}/build"
${CMAKE_EXE} -G "MSYS Makefiles" -B${CMAKE_BINARY_DIR} -S${CMAKE_SOURCE_DIR}


###### Build helloWorld ######
${CMAKE_EXE} --build "${CMAKE_BINARY_DIR}" --verbose


###### Execute helloWorld ######
echo ""
echo ""
${PWD}/build/helloWorld.com
 
read -p ''