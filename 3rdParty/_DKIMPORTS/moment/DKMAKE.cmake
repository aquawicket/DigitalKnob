# https://github.com/moment/moment
# https://momentjs.com/


dk_import(https://github.com/moment/moment/raw/e96809208c9d1b1bbe22d605e76985770024de42/moment.js)

#dk_set(MOMENTJS_VERSION 2.29.1)
#dk_set(MOMENTJS_NAME moment.js-${MOMENTJS_VERSION})
#dk_set(MOMENTJS_DL https://github.com/moment/moment/raw/2.29.1/moment.js)
#dk_set(MOMENTJS_DL https://momentjs.com/downloads/moment.min.js)
#dk_set(MOMENTJS ${3RDPARTY}/${MOMENTJS_NAME})
#dk_install(${MOMENTJS_DL} moment ${MOMENTJS})
