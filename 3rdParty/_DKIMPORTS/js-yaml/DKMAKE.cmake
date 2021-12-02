# https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/3.14.1 

### VERSION ###
DKSET(JSYAML_VERSION 3.14.1)
DKSET(JSYAML_NAME js-yaml-${JSYAML_VERSION})
DKSET(JSYAML_DL https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/${JSYAML_VERSION})
DKSET(JSYAML ${3RDPARTY}/${JSYAML_NAME})

### INSTALL ###
DKINSTALL(${JSYAML_DL} js-yaml ${JSYAML})
