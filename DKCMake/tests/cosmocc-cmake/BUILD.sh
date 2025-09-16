#!/bin/bash

rm -rf build

###### Configure helloWorld ######
cmake_exe="/C/Users/Administrator/DigitalKnob/DKTools/cmake-3.29.5-windows-x86_64/bin/cmake.exe"
CMAKE_SOURCE_DIR="${PWD}"
CMAKE_BINARY_DIR="${PWD}/build"
${cmake_exe} -G "MSYS Makefiles" -B${CMAKE_BINARY_DIR} -S${CMAKE_SOURCE_DIR}


###### Build helloWorld ######
${cmake_exe} --build "${CMAKE_BINARY_DIR}" --verbose


###### Execute helloWorld ######
echo ""
echo ""
${PWD}/build/helloWorld.com
 
read -p ''