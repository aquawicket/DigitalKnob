import sys 
sys.path.append("C:/Users/Administrator/digitalknob/Development/DKPython/functions")
from DK import *

####################################################################
# dk_test()
#
def dk_test(*args):
#   dk_debugFunc 0 99

    #print(f" ################# dk_test.py ################ ")
    if len(args) > 0:                           print(f"                       0 = {args[0]}")
    if len(args) > 1:                           print(f"                       1 = {args[1]}")
    if len(args) > 2:                           print(f"                       2 = {args[2]}")
    if len(args) > 3:                           print(f"                       3 = {args[3]}")
    if len(args) > 4:                           print(f"                       4 = {args[4]}")
    if len(args) > 5:                           print(f"                       5 = {args[5]}")
    if len(args) > 6:                           print(f"                       6 = {args[6]}")
    if len(args) > 7:                           print(f"                       7 = {args[7]}")
    if len(args) > 8:                           print(f"                       8 = {args[8]}")
    if len(args) > 9:                           print(f"                       9 = {args[9]}")
    if 'args' in globals():                     print(f"                       * = {args}")
    if 'ERRORLEVEL' in globals():               print(f"              ERRORLEVEL = {ERRORLEVEL}")
    if 'LVL' in globals():                      print(f"                     LVL = {LVL}")
    if '__TIME__' in globals():                 print(f"                __TIME__ = {__TIME__}")
    if '__CMND__' in globals():                 print(f"                __CMND__ = {__CMND__}")
    if '__FILE__' in globals():                 print(f"                __FILE__ = {__FILE__}")
    if '__LINE__' in globals():                 print(f"                __LINE__ = {__LINE__}")
    if '__FUNC__' in globals():                 print(f"                __FUNC__ = {__FUNC__}")
    if '__ARGC__' in globals():                 print(f"                __ARGC__ = {__ARGC__}")
    if '__ARGV__' in globals():                 print(f"                __ARGV__ = {__ARGV__}")
    if 'DKSCRIPT_PATH' in globals():            print(f"           DKSCRIPT_PATH = {DKSCRIPT_PATH}")
    if 'DKSCRIPT_DIR' in globals():             print(f"            DKSCRIPT_DIR = {DKSCRIPT_DIR}")
    if 'DKSCRIPT_FILE' in globals():            print(f"           DKSCRIPT_FILE = {DKSCRIPT_FILE}")
    if 'DKSCRIPT_NAME' in globals():            print(f"           DKSCRIPT_NAME = {DKSCRIPT_NAME}")
    if 'DKSCRIPT_EXT' in globals():             print(f"            DKSCRIPT_EXT = {DKSCRIPT_EXT}")
    if 'DKSCRIPT_ARGS' in globals():            print(f"           DKSCRIPT_ARGS = {DKSCRIPT_ARGS}")
    if 'DKHOME_DIR' in globals():               print(f"              DKHOME_DIR = {DKHOME_DIR}")
    if 'DKCACHE_DIR' in globals():              print(f"             DKCACHE_DIR = {DKCACHE_DIR}")
    if 'DKDESKTOP_DIR' in globals():            print(f"           DKDESKTOP_DIR = {DKDESKTOP_DIR}")
    if 'DKCACHE_DIR' in globals():              print(f"             DIGITALKNOB = {DIGITALKNOB}")
    if 'DIGITALKNOB' in globals():              print(f"         DIGITALKNOB_DIR = {DIGITALKNOB_DIR}")
    if 'DKDOWNLOAD_DIR' in globals():           print(f"          DKDOWNLOAD_DIR = {DKDOWNLOAD_DIR}")
    if 'DKTOOLS_DIR' in globals():              print(f"             DKTOOLS_DIR = {DKTOOLS_DIR}")
    if 'DKBRANCH' in globals():                 print(f"                DKBRANCH = {DKBRANCH}")
    if 'DKBRANCH_DIR' in globals():             print(f"            DKBRANCH_DIR = {DKBRANCH_DIR}")
    if 'DK3RDPARTY_DIR' in globals():           print(f"          DK3RDPARTY_DIR = {DK3RDPARTY_DIR}")
    if 'DKCPP_APPS_DIR' in globals():               print(f"              DKCPP_APPS_DIR = {DKCPP_APPS_DIR}")
    if 'DKPYTHON_DIR' in globals():             print(f"            DKPYTHON_DIR = {DKPYTHON_DIR}")
    if 'DKPYTHON_FUNCTIONS_DIR' in globals():   print(f"  DKPYTHON_FUNCTIONS_DIR = {DKPYTHON_FUNCTIONS_DIR}")
    if 'DKPYTHON_FUNCTIONS_DIR_' in globals():  print(f" DKPYTHON_FUNCTIONS_DIR_ = {DKPYTHON_FUNCTIONS_DIR_}")
    
	
	
    #	setGlobal GLOBAL_VAR "This is a global variable"
    #	setReturn RETURN_VAR "This is a return variable"
    #	::SYNTAX ERROR

    #	print(f":
    #	print(f" dk_test()
    #	::print(f" dk.gbl.GLOBAL_VAR = %dk.gbl.GLOBAL_VAR%
    #	print(f" GLOBAL_VAR = %GLOBAL_VAR%
        
    #	::print(f" dk.rtn.RETURN_VAR = %dk.rtn.RETURN_VAR%
    #	print(f" RETURN_VAR = %RETURN_VAR%
        
    #:: FIXME: we only want endlocal once
    #::endlocal & set "dk_test=return value from dk_test.cmd"

#endfunction








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_debugFunc 0

    dk_test("from DKTEST()", "to dk_test()")
    print("")
#    print("GLOBAL_VAR = "+GLOBAL_VAR)
#    print("RETURN_VAR = "+RETURN_VAR)
	
#   sys.path.append("Test")
#    Test_dk_test("from DKTEST()", "to Test/dk_test()")
#    print("")
#    print("GLOBAL_VAR = "+GLOBAL_VAR)
#    print("RETURN_VAR = "+RETURN_VAR)
	
#    Test_Test_dk_test("from DKTEST()", "to Test/Test/dk_test()")
#    print("")
#    print("GLOBAL_VAR = "+GLOBAL_VAR)
#    print("RETURN_VAR = "+RETURN_VAR)
#endfunction

