#!/bin/python
import __main__
import os
import sys
import platform

DKSCRIPT_PATH = __main__.__file__

#[ -n "${DKINIT-}" ] && return  || export DKINIT=1  # include_guard

### Print Shell Path ad Version ###
ESC=""  # escape character
DKSHELL="PYTHON"
DKSHELL_VERSION = platform.python_version()
DKSHELL_PATH = sys.executable
print("")
print(ESC+"[45m"+ESC+"[10m "+DKSHELL+" Version "+DKSHELL_VERSION+" "+ESC+"[0m")
print("DKSHELL_PATH  = "+DKSHELL_PATH)
print("DKSCRIPT_PATH = "+DKSCRIPT_PATH)
print("")


# TODO:  each DK.ext file displays the context it's in the version and path to the shell and the DKSCRIPT_PATH



DKSCRIPT_PATH = __main__.__file__
print("DKSCRIPT_PATH = "+DKSCRIPT_PATH)

DKSCRIPT_DIR = os.path.dirname(DKSCRIPT_PATH)
print("DKSCRIPT_DIR = "+DKSCRIPT_DIR)

DKSCRIPT_NAME = os.path.basename(DKSCRIPT_PATH)
print("DKSCRIPT_NAME = "+DKSCRIPT_NAME)

DKSCRIPT_EXT = os.path.splitext(DKSCRIPT_NAME)[1]
print("DKSCRIPT_EXT = "+DKSCRIPT_EXT)
