# C:/Users/Administrator/digitalknob/DK/3rdParty/android-sdk/ndk/22.1.7171670/toolchains/llvm/prebuilt/windows-x86_64/sysroot/usr/lib/arm-linux-androideabi/libdl.a
ANDROID_dk_depend(android-ndk)


if(dl_processed)
	find_library(dl_LIBRARY NAMES dl) #HINTS "C:/Users/Administrator/digitalknob/DK/3rdParty/android-sdk/ndk/22.1.7171670/toolchains/llvm/prebuilt/windows-x86_64/sysroot/usr/lib/arm-linux-androideabi")
	if(dl_LIBRARY)
		dk_info(dl_LIBRARY)
		dk_lib(${dl_LIBRARY})
	else()
		dk_assert("Could not locate dl libraries") 
	endif()
endif()
dk_set(dl_processed true)
