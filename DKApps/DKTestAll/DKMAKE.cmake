## DKTestAll is the "include all plugins" app.
## Here we try to include all plugins and 3rd party libraries for all platforms.
## DKTestAll is handy for debugging purposes and adding new libraries and plugins

dk_enable(HAVE_DKCef) ##FIXME: Find a way to remove this requirement

dk_dependAll() ## ADD any and all plugins

if(LINUX_HOST)
	dk_set(EXCLUDE_ASSETS ON) #assets are too large to embed on my old 1gb x86 dell laptop
endif()
