#DKDEPEND(boost Boost_Thread)
DKDEPEND(threadpool)
IF(HAVE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	DKDEPEND(DKCef)
ENDIF()


generateCmake(DKThread)
DKASSETS(DKThread)
DKINCLUDE(${THREADPOOL})
