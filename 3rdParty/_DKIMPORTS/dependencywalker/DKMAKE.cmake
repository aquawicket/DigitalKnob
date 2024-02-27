# https://www.dependencywalker.com

if(NOT WIN_HOST)
	dk_undepend(dependencywalker)
	dk_return()
endif()


#FIXME: WIN_X86_HOST_dkimport and WIN64_HOST_dk_import do not exist.
#WIN_X86_HOST_dkimport(https://www.dependencywalker.com/depends22_x86.zip)
#WIN64_HOST_dkimport(https://www.dependencywalker.com/depends22_x64.zip)
