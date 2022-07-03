# https://github.com/nodeca/js-yaml
# https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/3.14.1 



#dk_import(https://github.com/nodeca/js-yaml)
dk_import(https://github.com/nodeca/js-yaml/archive/49baadd52af887d2991e2c39a6639baa56d6c71b.zip)
#dk_set(JSYAML_VERSION 3.14.1)
#dk_set(JSYAML_NAME js-yaml-${JSYAML_VERSION})
#dk_set(JSYAML_DL https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/${JSYAML_VERSION})
#dk_set(JSYAML ${3RDPARTY}/${JSYAML_NAME})
#dk_import(${JSYAML_DL} ${JSYAML})
