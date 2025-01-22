import sys 
sys.path.append(".")
from DK import *

from dk_log import *

##################################################################################
# dk_notice(<message>)
#
#    Print a notice message to the console
#
#    @message - The message to print
#
def dk_notice(*args):
#    dk_call dk_debugFunc 1

    dk_log(NOTICE, args[0])





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_call dk_debugFunc 0

    dk_notice("test dk_notice message")
