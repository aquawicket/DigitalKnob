import sys 
sys.path.append(".")
from DK import *

from dk_log import *

##################################################################################
# dk_warning(<message>)
#
#    Print a warning message to the console
#
#    @message - The message to print
#
def dk_warning(*args):
#    dk_call dk_debugFunc 1

    dk_log(WARNING, args[0])





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_call dk_debugFunc 0

    dk_warning("test dk_warning message")
