DK = "DK.py"
import DK
import os 
#include_guard()

##################################################################################
# dk_realpath(path) -> rtn_var
#
#    PYTHON: https://docs.python.org/3/library/os.path.html#os.path.realpath
#
def dk_realpath(path):
    #dk_debugFunc()
    #if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
    
    _realpath_ = os.path.realpath(path)
    return _realpath_
    
    
    
    
    
    
###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######   
def DKTEST():

    rp = dk_realpath("../functions/DK.py")
    print(rp)
    
    
DKTEST()