include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/apache/ant.git
# https://mirror.cogentco.com/pub/apache/ant/binaries/apache-ant-1.9.15-bin.zip
# https://github.com/apache/ant/archive/0db467a379916a3d1fcf6956a0fedaf94cc25be3.zip


#dk_import(https://github.com/apache/ant.git)
dk_import(https://github.com/apache/ant/archive/refs/heads/master.zip)



dk_setEnv("ANT_HOME" ${ANT})
dk_setEnv("VS_AntHome" ${ANT})
