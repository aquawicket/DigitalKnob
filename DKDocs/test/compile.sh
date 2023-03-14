#!/bin/bash

cd /c/Users/Administrator/digitalknob/DK/DKDocs/test

export PATH=/c/Users/Administrator/digitalknob/DK/3rdParty/msys2-x86_64-20221216/mingw32/bin:$PATH
export PATH=/c/Users/Administrator/digitalknob/DK/3rdParty/msys2-x86_64-20221216/usr/bin:$PATH

echo "compiling . . ."
/c/Users/Administrator/digitalknob/DK/3rdParty/msys2-x86_64-20221216/mingw32/bin/g++.exe /c/Users/Administrator/digitalknob/DK/DKDocs/test/main.cpp
exit