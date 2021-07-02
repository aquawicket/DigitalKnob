## DKTestAll is the "include everything" app.
## Here we try to include all plugins and 3rd party libraries for all platforms.
## DKTestAll is handy for debugging purposes and adding libraries and plugins to DK.

DKSET(USE_DKCef ON) ##FIXME: Find a way to remove this requirement

## ADD any and all plugins here
DKDEPEND_ALL()
return()
