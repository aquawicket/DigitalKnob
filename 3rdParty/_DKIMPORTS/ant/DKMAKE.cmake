#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/apache/ant.git
# https://mirror.cogentco.com/pub/apache/ant/binaries/apache-ant-1.9.15-bin.zip
# https://github.com/apache/ant/archive/0db467a379916a3d1fcf6956a0fedaf94cc25be3.zip


dk_import(https://github.com/apache/ant/archive/146baefac2d0d1e12fe86ee5215317a4bcb1ff9e.zip)
#dk_import(https://github.com/apache/ant/archive/refs/heads/master.zip)



dk_setEnv("ANT_HOME" ${ANT})
dk_setEnv("VS_AntHome" ${ANT})
