include(CMakeFindDependencyMacro)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
find_dependency(Threads)
include("${CMAKE_CURRENT_LIST_DIR}/liblzmaTargets.cmake")
