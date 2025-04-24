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
    dk_echo("args0 = "+{args[0]})
    path = "C:/Users/Administrator"
    basename = os.path.basename(path)
    dk_echo("basename = "+basename)
    ###### TODO ######
    
############################################################################






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
    #dk_debugFunc 0

    dk_basename("C:/Users/Administrator")

############################################################################
#DKTEST()
