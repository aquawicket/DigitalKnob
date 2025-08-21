import sys 
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

   	### Result as global variable
    dk_echo("")
    dk_testReturn("inputA")
    dk_echo("testReturn = "+testReturn)
	
    ### Result as parameter variable
    dk_echo("")
    resultB = ['']                      # we must use a list to pass by reference
    dk_testReturn("inputB", resultB)
    resultB = resultB[0]                # now we can convert the list item back to a string
    dk_echo("resultB = "+resultB)
    dk_echo("testReturn = "+testReturn)
	
    ### Result as return value
    dk_echo(" ")
    resultC = dk_testReturn("inputC")
    dk_echo("resultC = "+resultC)
    dk_echo("testReturn = "+testReturn)

#endfunction

