#dk_depend(boost Boost_Thread)
dk_depend(threadpool)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


dk_generateCmake(DKThread)
dk_assets(DKThread)
dk_include(${THREADPOOL})
