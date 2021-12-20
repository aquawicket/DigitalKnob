DKDEPEND(duktape)
DKDEPEND(DK)
if(USE_babel)
	DKDEPEND(babel)
endif()


DKCOPY(${DUKTAPE}/src/duktape.cpp ${DKPLUGINS}/DKDuktape/duktape.cpp FALSE)

#DKENABLE(DUK_POLL)
#if(USE_DUK_POLL)
 DKCOPY(${DUKTAPE}/examples/eventloop/poll.cpp ${DKPLUGINS}/DKDuktape/poll.cpp FALSE)
#endif()

#DKENABLE(DUK_EMCALOOP)
#if(USE_DUK_EMCALOOP)
DKCOPY(${DUKTAPE}/examples/eventloop/ecma_eventloop.js ${DKPLUGINS}/DKDuktape/ecma_eventloop.js FALSE)
#endif()

#DKENABLE(DUK_CLOOP)
#if(USE_DUK_CLOOP)
DKCOPY(${DUKTAPE}/examples/eventloop/c_eventloop.cpp ${DKPLUGINS}/DKDuktape/c_eventloop.cpp FALSE)
DKCOPY(${DUKTAPE}/examples/eventloop/c_eventloop.js ${DKPLUGINS}/DKDuktape/c_eventloop.js FALSE)
#endif()

DKINCLUDE(${DKPLUGINS}/DKDuktape)
DKINCLUDE(${DUKTAPE}/src)
DKDEFINE(HAVE_DKDuktape)

generateCmake(DKDuktape)
DKASSETS(DKDuktape)
