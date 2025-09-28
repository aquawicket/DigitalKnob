import sys
import subprocess
sys.path.append(".")
from DK import *
from dk_echo import *

    
####################################################################
# dk_testReturn(input, output)
#
def dk_testReturn(*args):
    #dk_debugFunc 1, 2
       
    global testReturn; 
    testReturn = args[0].replace("input", "output")
    
    if len(args) == 2:
        args[1][0] = testReturn

    return testReturn
#endfunction








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_debugFunc 0

   	### Result as global variable                   [GLOBAL]
    dk_echo("")
    dk_testReturn("inputA")
    dk_echo("testReturn = "+testReturn)
	
    
    ### Result as parameter variable                [GLOBAL][PARAM]
    dk_echo("")
    resultB = ['']                                  # we must use a list to pass by reference
    dk_testReturn("inputB", resultB)
    resultB = resultB[0]                            # now we can convert the list item back to a string
    dk_echo("resultB = "+resultB)
    dk_echo("testReturn = "+testReturn)
	
    
    ### Result as return value                     [GLOBAL][RETURN]
    dk_echo("")
    resultC = dk_testReturn("inputC")
    dk_echo("resultC = "+resultC)
    dk_echo("testReturn = "+testReturn)
    
    
    ### Result as parameter variable               [GLOBAL][PARAM][RETURN]
    dk_echo("")
    resultD = ['']                    # we must use a list to pass by reference
    resultE = dk_testReturn("inputDE", resultD)
    resultD = resultD[0]              # now we can convert the list item back to a string
    dk_echo("resultD = "+resultD)
    dk_echo("resultE = "+resultE)
    dk_echo("testReturn = "+testReturn)
    
    
    ### Result from stdout                          [STDOUT]
	# https://docs.python.org/3.5/library/subprocess.html#subprocess.run
    
    #run(args, *, stdin=None, input=None, stdout=None, stderr=None, shell=False, timeout=None, check=False)
    resultF = subprocess.run(["%python3_exe:\=/%", "dk_basename.py", "C:/Windows/System32"], shell=True, capture_output=True, text=True)
    dk_echo("resultF = "+resultF.stdout)


#endfunction

