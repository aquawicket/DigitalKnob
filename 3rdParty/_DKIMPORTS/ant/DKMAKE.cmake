# https://github.com/apache/ant
if(NOT WIN_HOST)
	return()
endif()


dk_import(https://github.com/apache/ant.git)
#dk_import(https://github.com/apache/ant/archive/0db467a379916a3d1fcf6956a0fedaf94cc25be3.zip)

#dk_set(ANT_VERSION 1.9.16)
#dk_set(ANT_NAME apache-ant-${ANT_VERSION})
#dk_set(ANT_DL https://mirror.cogentco.com/pub/apache/ant/binaries/apache-ant-1.9.15-bin.zip)
#dk_set(ANT ${3RDPARTY}/${ANT_NAME})
#dk_install(${ANT_DL} apache-ant ${ANT})


DKSETENV("ANT_HOME" ${ANT})
DKSETENV("VS_AntHome" ${ANT})
