import sys
import subprocess
sys.path.append(".")
from DK import *

import os.path
from dk_echo import *
############################################################################
# dk_basename()
#
#     Description
#
#     Args
#
def dk_basename(*args):
    #dk_debugFunc 0

    global basename; 
    basename = os.path.basename(args[0]);
    
    if len(args) == 2:
        args[1][0] = basename

    return basename
    
############################################################################






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
    #dk_debugFunc 0

   	### Result as global variable                   [GLOBAL]
    dk_echo("")
    dk_basename("A:/directoryA/filenameA.extA")
    dk_echo("basename = "+basename)
	
    
    ### Result as parameter variable                [GLOBAL][PARAM]
    dk_echo("")
    resultB = ['']                                  # we must use a list to pass by reference
    dk_basename("B:/directoryB/filenameB.extB", resultB)
    resultB = resultB[0]                            # now we can convert the list item back to a string
    dk_echo("resultB = "+resultB)
    dk_echo("basename = "+basename)
	
    
    ### Result as return value                     [GLOBAL][RETURN]
    dk_echo("")
    resultC = dk_basename("C:/directoryC/filenameC.extC")
    dk_echo("resultC = "+resultC)
    dk_echo("basename = "+basename)
    
    
    ### Result as parameter variable               [GLOBAL][PARAM][RETURN]
    dk_echo("")
    resultD = ['']                    # we must use a list to pass by reference
    resultE = dk_basename("DE:/directoryDE/filenameDE.extDE", resultD)
    resultD = resultD[0]              # now we can convert the list item back to a string
    dk_echo("resultD = "+resultD)
    dk_echo("resultE = "+resultE)
    dk_echo("basename = "+basename)
    
    
    ### Result from stdout                          [STDOUT]
	# https://docs.python.org/3.5/library/subprocess.html#subprocess.run
    resultF = subprocess.run(["cmd.exe", "/V:ON", "/c", "call", "%python3_exe:\=/%", "dk_basename.py", "F:/directoryF/filenameF.extF"], shell=True, capture_output=True, text=True)
    dk_echo("resultF = "+resultF.stdout)
    dk_echo("basename = "+basename)

