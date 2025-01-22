import sys 
sys.path.append(".")
import DK

from dk_log import *

##################################################################################
# dk_fixme(<message>)
#
#    Print a fixme message to the console
#
#    @message - The message to print
#
def dk_fixme(*args):
#    dk_call dk_debugFunc 1

    dk_log(FIXME, args[0])





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_call dk_debugFunc 0

    dk_fixme("test dk_fixme message")
