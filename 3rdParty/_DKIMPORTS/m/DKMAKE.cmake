ANDROID_dk_depend(android-ndk)

find_library(m_LIBRARY m)
if(NOT m_LIBRARY)
	dk_assert("Could not locate m libraries") 
endif()
dk_info(m_LIBRARY)
dk_lib(${m_LIBRARY})
