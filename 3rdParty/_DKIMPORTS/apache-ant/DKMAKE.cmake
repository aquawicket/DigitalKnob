## https://mirror.cogentco.com/pub/apache/ant/binaries/apache-ant-1.9.15-bin.zip


### VERSION ####
DKSET(ANT_VERSION 1.9.16)
DKSET(ANT_NAME apache-ant-${ANT_VERSION})
DKSET(ANT_DL https://mirror.cogentco.com/pub/apache/ant/binaries/${ANT_NAME}-bin.zip)
DKSET(ANT ${3RDPARTY}/${ANT_NAME})

DKSETENV("ANT_HOME" ${ANT})
DKSETENV("VS_AntHome" ${ANT})


### INSTALL ###
DKINSTALL(${ANT_DL} apache-ant ${ANT})
