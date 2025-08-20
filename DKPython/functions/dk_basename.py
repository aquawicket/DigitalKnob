import sys 
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
    
    #path = {args[0]};
    #dk_echo("args0 = "+{args[0]})
    #print(f"     args0 = {args[0]}")
    path = "C:/Users/Administrator"
    dk_basename = os.path.basename(path)
    #dk_echo("basename = "+basename)
    ###### TODO ######
    
############################################################################






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
    #dk_debugFunc 0

    dk_basename("C:/Users/Administrator")
    
    ### Result as global variable
    dk_echo()
    dk_basename("A:/directoryA/filenameA.extA")
    #dk_echo("dk_basename = ${dk_basename}")
    print(f"   dk_basename = {dk_basename}")
	
    ### Result as variable parameter
#    dk_echo();
#    dk_basename("B:/directoryB/filenameB.extB" resultB);
#    dk_echo("resultB = ${resultB}");
#    dk_echo("dk_basename = ${dk_basename}");
	
    ### Result as return value
#    dk_echo();
#    resultC=dk_basename)"C:/directoryC/filenameC.extC");
#    dk_echo("resultC = ${resultC}");
#    #dk_echo("dk_basename = ${dk_basename}");					#NOTE: export cannot be seen outside of command substituion
	
    ### Result as hashtable parameter
#    dk_echo();
#    dk_basename("D:/directoryD/filenameD.extD" resultD[value]);
#    dk_echo("resultD[value] = ${resultD[value]}");
#    dk_echo("dk_basename = ${dk_basename}");

############################################################################
#DKTEST()
