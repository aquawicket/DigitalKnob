#DKDEPEND(boost Boost_Thread)
DKDEPEND(threadpool)
IF(USE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(USE_DKCef)
	DKDEPEND(DKCef)
ENDIF()


generateCmake(DKThread)
DKASSETS(DKThread)
DKINCLUDE(${THREADPOOL})
