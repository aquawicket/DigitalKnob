DKDEPEND(duktape)
DKDEPEND(babel)

DKCOPY(${DUKTAPE}/src/duktape.c ${DKPLUGINS}/DKDuktape/duktape.cpp FALSE)
DKCOPY(${DUKTAPE}/examples/eventloop/poll.c ${DKPLUGINS}/DKDuktape/poll.cpp FALSE)
DKCOPY(${DUKTAPE}/examples/eventloop/ecma_eventloop.js ${DKPLUGINS}/DKDuktape/ecma_eventloop.js FALSE)
DKCOPY(${DUKTAPE}/examples/eventloop/c_eventloop.c ${DKPLUGINS}/DKDuktape/c_eventloop.cpp FALSE)
DKCOPY(${DUKTAPE}/examples/eventloop/c_eventloop.js ${DKPLUGINS}/DKDuktape/c_eventloop.js FALSE)
DKINCLUDE(${DKPLUGINS}/DKDuktape)
DKINCLUDE(${DUKTAPE}/src)
DKDEFINE(USE_DKDuktape)

DKPLUGIN(DKDuktape)
DKASSETS(DKDuktape)