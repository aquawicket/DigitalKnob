# https://github.com/nodeca/js-yaml
# https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/3.14.1 



#DKIMPORT(https://github.com/nodeca/js-yaml)
DKIMPORT(https://github.com/nodeca/js-yaml/archive/49baadd52af887d2991e2c39a6639baa56d6c71b.zip)
#DKSET(JSYAML_VERSION 3.14.1)
#DKSET(JSYAML_NAME js-yaml-${JSYAML_VERSION})
#DKSET(JSYAML_DL https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/${JSYAML_VERSION})
#DKSET(JSYAML ${3RDPARTY}/${JSYAML_NAME})
#DKINSTALL(${JSYAML_DL} js-yaml ${JSYAML})
