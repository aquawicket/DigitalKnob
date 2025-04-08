executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

'##################################################################################
'# dk_test()
'#
public function dk_test(args)
	dk_echo("")
	ARGV = Join(args, ";")
	dk_echo("dk_test("+ARGV+")")
	dk_echo("")
	dk_echo("################# dk_test.vbs ################")
	ARGC = CStr(UBound(args)+1)
	if ARGC > 0 then 
		dk_echo("                           0 = "+args(0))
	end if
	if ARGC > 0 then 
		dk_echo("                           1 = "+args(1))
	end if
    if ARGC > 2 then 
		dk_echo("                           2 = "+args(2))
	end if
	if ARGC > 2 then 
		dk_echo("                           3 = "+args(3))
	end if
	if ARGC > 2 then 
		dk_echo("                           4 = "+args(4))
	end if
	if ARGC > 2 then 
		dk_echo("                           5 = "+args(5))
	end if
	if ARGC > 2 then 
		dk_echo("                           6 = "+args(6))
	end if 
	if ARGC > 2 then 
		dk_echo("                           7 = "+args(7))
	end if
	if ARGC > 2 then 
		dk_echo("                           8 = "+args(8))
	end if
	if ARGC > 2 then 
		dk _echo("                          9 = "+args(9))
	end if
        dk_echo("                  ERRORLEVEL = "+ERRORLEVEL)
    	dk_echo("                         LVL = "+LVL)
        'dk_echo("                       TIME = "+TIME)
        dk_echo("                        CMND = "+CMND)
        dk_echo("                        FILE = "+WScript.ScriptFullName)
        dk_echo("                        LINE = "+LINE)
        dk_echo("                        FUNC = "+FUNC)
        dk_echo("                        ARGC = "+ARGC)
        dk_echo("                        ARGV = "+ARGV)
        dk_echo("          ENV(DKSCRIPT_PATH) = "+ENV("DKSCRIPT_PATH"))
        dk_echo("           ENV(DKSCRIPT_DIR) = "+ENV("DKSCRIPT_DIR"))
        dk_echo("          ENV(DKSCRIPT_NAME) = "+ENV("DKSCRIPT_NAME"))
        dk_echo("           ENV(DKSCRIPT_EXT) = "+ENV("DKSCRIPT_EXT"))
        dk_echo("          ENV(DKSCRIPT_ARGS) = "+ENV("DKSCRIPT_ARGS"))
        dk_echo("             ENV(DKHOME_DIR) = "+ENV("DKHOME_DIR"))
        dk_echo("            ENV(DKCACHE_DIR) = "+ENV("DKCACHE_DIR"))
        dk_echo("          ENV(DKDESKTOP_DIR) = "+ENV("DKDESKTOP_DIR"))
        dk_echo("            ENV(DIGITALKNOB) = "+ENV("DIGITALKNOB"))
        dk_echo("        ENV(DIGITALKNOB_DIR) = "+ENV("DIGITALKNOB_DIR"))
        dk_echo("         ENV(DKDOWNLOAD_DIR) = "+ENV("DKDOWNLOAD_DIR"))
        dk_echo("            ENV(DKTOOLS_DIR) = "+ENV("DKTOOLS_DIR"))
        dk_echo("               ENV(DKBRANCH) = "+ENV("DKBRANCH"))
        dk_echo("           ENV(DKBRANCH_DIR) = "+ENV("DKBRANCH_DIR"))
        dk_echo("         ENV(DK3RDPARTY_DIR) = "+ENV("DK3RDPARTY_DIR"))
        dk_echo("         ENV(DKCPP_APPS_DIR) = "+ENV("DKCPP_APPS_DIR"))
        dk_echo("             ENV(DKBASH_DIR) = "+ENV("DKBASH_DIR"))
        dk_echo("   ENV(DKBASH_FUNCTIONS_DIR) = "+ENV("DKBASH_FUNCTIONS_DIR"))
        dk_echo("  ENV(DKBASH_FUNCTIONS_DIR_) = "+ENV("DKBASH_FUNCTIONS_DIR_"))
		dk_echo("            ENV(DKBATCH_DIR) = "+ENV("DKBATCH_DIR"))
        dk_echo("  ENV(DKBATCH_FUNCTIONS_DIR) = "+ENV("DKBATCH_FUNCTIONS_DIR"))
        dk_echo(" ENV(DKBATCH_FUNCTIONS_DIR_) = "+ENV("DKBATCH_FUNCTIONS_DIR_"))
		dk_echo("                ENV(DKC_DIR) = "+ENV("DKC_DIR"))
        dk_echo("      ENV(DKC_FUNCTIONS_DIR) = "+ENV("DKC_FUNCTIONS_DIR"))
        dk_echo("     ENV(DKC_FUNCTIONS_DIR_) = "+ENV("DKC_FUNCTIONS_DIR_"))
		dk_echo("            ENV(DKCMAKE_DIR) = "+ENV("DKCMAKE_DIR"))
        dk_echo("  ENV(DKCMAKE_FUNCTIONS_DIR) = "+ENV("DKCMAKE_FUNCTIONS_DIR"))
        dk_echo(" ENV(DKCMAKE_FUNCTIONS_DIR_) = "+ENV("DKCMAKE_FUNCTIONS_DIR_"))
		dk_echo("              ENV(DKCPP_DIR) = "+ENV("DKCPP_DIR"))
        dk_echo("    ENV(DKCPP_FUNCTIONS_DIR) = "+ENV("DKCPP_FUNCTIONS_DIR"))
        dk_echo("   ENV(DKCPP_FUNCTIONS_DIR_) = "+ENV("DKCPP_FUNCTIONS_DIR_"))
		dk_echo("           ENV(DKCSHARP_DIR) = "+ENV("DKCSHARP_DIR"))
        dk_echo(" ENV(DKCSHARP_FUNCTIONS_DIR) = "+ENV("DKCSHARP_FUNCTIONS_DIR"))
        dk_echo("ENV(DKCSHARP_FUNCTIONS_DIR_) = "+ENV("DKCSHARP_FUNCTIONS_DIR_"))
    	
'	%dk_call% setGlobal GLOBAL_VAR "This is a global variable"
'	%dk_call% setReturn RETURN_VAR "This is a return variable"
	GLOBAL_VAR = "This is a global variable"
	RETURN_VAR = "This is a return variable"
	
	dk_echo("GLOBAL_VAR = "+GLOBAL_VAR)
	dk_echo("RETURN_VAR = "+RETURN_VAR)
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_FILE") = "dk_test.vbs") then
	
	dk_test(Array("from :DKTEST", "to dk_test"))
'	dk_echo ""
'	dk_echo("GLOBAL_VAR = %GLOBAL_VAR%"
'	dk_echo("RETURN_VAR = %RETURN_VAR%"
	
'	Test::dk_test("from :DKTEST" "to Test::dk_test")
'	dk_echo ""
'	dk_echo("GLOBAL_VAR = %GLOBAL_VAR%"
'	dk_echo("RETURN_VAR = %RETURN_VAR%"
	
'	Test::Test::dk_test("from :DKTEST" "to Test::Test::dk_test")
'	dk_echo ""
'	dk_echo("GLOBAL_VAR = %GLOBAL_VAR%"
'	dk_echo("RETURN_VAR = %RETURN_VAR%"
	
	
end if