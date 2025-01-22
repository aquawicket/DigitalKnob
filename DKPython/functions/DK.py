#!/bin/python
import __main__
import os
import sys
import platform

DKSCRIPT_PATH = __main__.__file__

#[ -n "${DKINIT-}" ] && return  || export DKINIT=1  # include_guard

### Print Shell Path ad Version ###
ESC=""  # escape character
clr=ESC+"[0m"
white=ESC+"[37m"
bg_magenta=ESC+"[45m"

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

DKSCRIPT_FILE = os.path.basename(DKSCRIPT_PATH)
print("DKSCRIPT_FILE = "+DKSCRIPT_FILE)

from pathlib import Path
DKSCRIPT_NAME = Path(DKSCRIPT_FILE).stem
print("DKSCRIPT_NAME = "+DKSCRIPT_NAME)

DKSCRIPT_EXT = os.path.splitext(DKSCRIPT_FILE)[1]
print("DKSCRIPT_EXT = "+DKSCRIPT_EXT)






###### DKTEST MODE ######
if DKSCRIPT_EXT == ".py": 
    #dk_fileContains "%DKSCRIPT_PATH%" ":DKTEST" || exit /b 0
    print()
    print(f"{bg_magenta}{white}###### DKTEST MODE ###### {DKSCRIPT_NAME}.cmd ###### DKTEST MODE ######{clr}")
    print()

    #call :DKTEST || %return%
    mod = __import__(DKSCRIPT_NAME)
    mod.DKTEST()

    print()
    print(f"{bg_magenta}{white}######## END TEST ####### {DKSCRIPT_NAME}.cmd ######## END TEST #######{clr}")
    print()
    #pause
    #exit %ERRORLEVEL%
    
    

