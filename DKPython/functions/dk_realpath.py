import DKPYTHON_FUNCTIONS_DIR+"DK.py"
import os 
#include_guard()

##################################################################################
# dk_realpath(path) -> rtn_var
#
#    PYTHON: https://docs.python.org/3/library/os.path.html#os.path.realpath
#
def dk_realpath(path):
    dk_debugFunc()
#   if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }	
	
	_realpath_ = os.path.realpath(path, *)
	dk_printVar(_realpath_)
	return _realpath_








####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
def DKTEST():
	dk_debugFunc()
	
	realpath = dk_realpath("bash")
	dk_info("realpath = "+realpath)
