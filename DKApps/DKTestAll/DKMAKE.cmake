## DKTestAll is the "include all plugins" app.
## Here we try to include all plugins and 3rd party libraries for all platforms.
## DKTestAll is handy for debugging purposes and adding new libraries and plugins

DKENABLE(USE_DKCef) ##FIXME: Find a way to remove this requirement

## ADD any and all plugins here
DKDEPEND_ALL()

if(CMAKE_HOST_LINUX)
	DKSET(EXCLUDE_ASSETS ON) #assets are too large to embed on my old 1gb x86 dell laptop
endif()
