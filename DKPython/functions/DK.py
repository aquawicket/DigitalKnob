<<<<<<< HEAD
import __main__
import os

DKSCRIPT_PATH = __main__.__file__
print("DKSCRIPT_PATH = "+DKSCRIPT_PATH)

DKSCRIPT_DIR = os.path.dirname(DKSCRIPT_PATH)
print("DKSCRIPT_DIR = "+DKSCRIPT_DIR)

DKSCRIPT_NAME = os.path.basename(DKSCRIPT_PATH)
print("DKSCRIPT_NAME = "+DKSCRIPT_NAME)

DKSCRIPT_EXT = os.path.splitext(DKSCRIPT_NAME)[1]
print("DKSCRIPT_EXT = "+DKSCRIPT_EXT)
=======
#!/bin/python
import __main__
import os
import sys
import platform

####################################################################
# dk_test()
#
def DK(*args):
    #   dk_debugFunc 0 99
    global DKSCRIPT_PATH;   DKSCRIPT_PATH = __main__.__file__

    #[ -n "${DKINIT-}" ] && return  || export DKINIT=1  # include_guard

    ### Print Shell Path ad Version ###
    global ESC;             ESC=""  # escape character
    global clr;             clr=ESC+"[0m"
    global white;           white=ESC+"[37m"
    global bg_magenta;      bg_magenta=ESC+"[45m"

    global DKSHELL;         DKSHELL="PYTHON"
    global DKSHELL_VERSION; DKSHELL_VERSION = platform.python_version()
    global DKSHELL_PATH;    DKSHELL_PATH = sys.executable
    print("")
    print(ESC+"[45m"+ESC+"[10m "+DKSHELL+" Version "+DKSHELL_VERSION+" "+ESC+"[0m")
    print("DKSHELL_PATH  = "+DKSHELL_PATH)
    print("DKSCRIPT_PATH = "+DKSCRIPT_PATH)
    print("")

    if sys.version_info[0] < 3:
        raise Exception("Python version 3 or greater required")
        
    # TODO:  each DK.ext file displays the context it's in the version and path to the shell and the DKSCRIPT_PATH
    global DKSCRIPT_DIR;            DKSCRIPT_DIR = os.path.dirname(DKSCRIPT_PATH)
    global DKSCRIPT_FILE;           DKSCRIPT_FILE = os.path.basename(DKSCRIPT_PATH)
    from pathlib import Path
    global DKSCRIPT_NAME;           DKSCRIPT_NAME = os.path.splitext(DKSCRIPT_FILE)[0]
    global DKSCRIPT_EXT;            DKSCRIPT_EXT = os.path.splitext(DKSCRIPT_FILE)[1]
    #global DKSCRIPT_ARGS;          DKSCRIPT_ARGS = ' '.join(sys.argv[1:])
    global DKSCRIPT_ARGS;           DKSCRIPT_ARGS = sys.argv[0]
    global DKHOME_DIR;              DKHOME_DIR = os.environ['USERPROFILE']
#    global DKDESKTOP_DIR;           DKDESKTOP_DIR = f"{DKHOME_DIR}\\Desktop"
#   global DKCACHE_DIR;             DKCACHE_DIR = f"{DKHOME_DIR}\\.dk"
#    global DIGITALKNOB;             DIGITALKNOB = "DigitalKnob"
#    global DIGITALKNOB_DIR;         DIGITALKNOB_DIR = f"{DKHOME_DIR}\\{DIGITALKNOB}"
#    global DKDOWNLOAD_DIR;          DKDOWNLOAD_DIR = f"{DIGITALKNOB_DIR}\\download"
#    global DKTOOLS_DIR;             DKTOOLS_DIR = f"{DIGITALKNOB_DIR}\\DKTools"
#    global DKBRANCH;                DKBRANCH = "Developemnt"
#    global DKBRANCH_DIR;            DKBRANCH_DIR = f"{DIGITALKNOB_DIR}\\{DKBRANCH}"
#    global DK3RDPARTY_DIR;          DK3RDPARTY_DIR = f"{DKBRANCH_DIR}\\3rdParty"
#    global DKCPP_APPS_DIR;          DKCPP_APPS_DIR = f"{DKBRANCH_DIR}\\DKCpp\\apps"
#    global DKPYTHON_DIR;            DKPYTHON_DIR = f"{DKBRANCH_DIR}\\DKPython"
#    global DKPYTHON_FUNCTIONS_DIR;  DKPYTHON_FUNCTIONS_DIR = f"{DKPYTHON_DIR}\\function"
#    global DKPYTHON_FUNCTIONS_DIR_; DKPYTHON_FUNCTIONS_DIR_ = f"{DKPYTHON_FUNCTIONS_DIR}\\"

DK()


###### DKTEST MODE ######
if DKSCRIPT_EXT == ".py": 
    #dk_fileContains "%DKSCRIPT_PATH%" ":DKTEST" || exit /b 0
    print()
    print(f"{bg_magenta}{white}###### DKTEST MODE ###### {DKSCRIPT_FILE} ###### DKTEST MODE ######{clr}")
    print()

#    if DKSCRIPT_NAME == "DK":
#        return
    if DKSCRIPT_NAME != "DK":
        mod = __import__(DKSCRIPT_NAME)
        mod.DKTEST()

        print()
        print(f"{bg_magenta}{white}######## END TEST ####### {DKSCRIPT_FILE} ######## END TEST #######{clr}")
        print()
        #pause
        #exit %ERRORLEVEL%
    
    

>>>>>>> Development
