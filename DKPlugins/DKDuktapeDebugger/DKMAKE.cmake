dk_depend(DKDuktape)

if(NOT EXISTS ${DKPLUGINS}/DKDuktapeDebugger/duk_trans_dvalue.c)
	dk_copy(${DUKTAPE}/examples/debug-trans-dvalue/duk_trans_dvalue.h ${DKPLUGINS}/DKDuktapeDebugger/duk_trans_dvalue.h OVERWRITE)
	dk_copy(${DUKTAPE}/examples/debug-trans-dvalue/duk_trans_dvalue.c ${DKPLUGINS}/DKDuktapeDebugger/duk_trans_dvalue.c OVERWRITE)
endif()

dk_generateCmake(DKDuktapeDebugger)
dk_assets(DKDuktapeDebugger)
