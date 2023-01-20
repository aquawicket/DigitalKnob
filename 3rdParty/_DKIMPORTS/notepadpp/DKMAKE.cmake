# https://notepad-plus-plus.org/
# https://github.com/notepad-plus-plus.git

if(NOT WIN_HOST)
	dk_undepend(notepadpp)
	dk_return()
endif()
	

### INSTALL ###
dk_import(https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.8/npp.8.4.8.portable.zip)
