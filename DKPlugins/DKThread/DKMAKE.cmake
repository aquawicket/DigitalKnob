#dk_depend(boost Boost_Thread)
dk_depend(threadpool)
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()


generateCmake(DKThread)
dk_assets(DKThread)
dk_include(${THREADPOOL})
