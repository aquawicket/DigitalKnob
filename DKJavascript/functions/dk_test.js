//################################################################################
//# dk_test()
//#
//#
dk_test = function dk_test_f(){
	//dk_debugFunc(0);
	
	console.log("################# dk_test.cmd ################");
	if(ARGC > 0)							{ console.log("               ARGV(0) = '"+ARGV(0)+"' ");			}
	if(ARGC > 1)							{ console.log("               ARGV(1) = '"+ARGV(1)+"' "); 			}
	if(ARGC > 2)							{ console.log("               ARGV(2) = '"+ARGV(2)+"' ");			}
	if(ARGC > 3)							{ console.log("               ARGV(3) = '"+ARGV(3)+"' ");			}
	if(ARGC > 4)							{ console.log("               ARGV(4) = '"+ARGV(4)+"' ");			}
	if(ARGC > 5)							{ console.log("               ARGV(5) = '"+ARGV(5)+"' ");			}
	if(ARGC > 6)							{ console.log("               ARGV(6) = '"+ARGV(6)+"' ");			}
	if(ARGC > 7)							{ console.log("               ARGV(7) = '"+ARGV(7)+"' ");			}
	if(ARGC > 8)							{ console.log("               ARGV(8) = '"+ARGV(8)+"' ");			}
	if(ARGC > 9)							{ console.log("               ARGV(9) = '"+ARGV(9)+"' ");			}
	if(typeof      __ARGV__ !== "undefined"){ console.log("              __ARGV__ = "+__ARGV__);				}
	if(typeof          ARGC !== "undefined"){ console.log("                  ARGC = "+ARGC);					}
	if(typeof  arguments[0] !== "undefined"){ console.log("          arguments[0] = '"+arguments[0]+"' ");		}
	if(typeof  arguments[1] !== "undefined"){ console.log("          arguments[1] = '"+arguments[1]+"' ");		}
	if(typeof  arguments[2] !== "undefined"){ console.log("          arguments[2] = '"+arguments[2]+"' ");		}
	if(typeof  arguments[3] !== "undefined"){ console.log("          arguments[3] = '"+arguments[3]+"' ");		}
	if(typeof  arguments[4] !== "undefined"){ console.log("          arguments[4] = '"+arguments[4]+"' ");		}
	if(typeof  arguments[5] !== "undefined"){ console.log("          arguments[5] = '"+arguments[5]+"' ");		}
	if(typeof  arguments[6] !== "undefined"){ console.log("          arguments[6] = '"+arguments[6]+"' ");		}
	if(typeof  arguments[7] !== "undefined"){ console.log("          arguments[7] = '"+arguments[7]+"' ");		}
	if(typeof  arguments[8] !== "undefined"){ console.log("          arguments[8] = '"+arguments[8]+"' ");		}
	if(typeof  arguments[9] !== "undefined"){ console.log("          arguments[9] = '"+arguments[9]+"' ");		}
	if(typeof 	 ERRORLEVEL !== "undefined"){ console.log("            ERRORLEVEL = "+ERRORLEVEL);				}
	if(typeof           LVL !== "undefined"){ console.log("                   LVL = "+LVL);						}
	if(typeof      __TIME__ !== "undefined"){ console.log("              __TIME__ = "+__TIME__);				}
	if(typeof      __CMND__ !== "undefined"){ console.log("              __CMND__ = "+__CMND__);				}
	if(typeof      __FILE__ !== "undefined"){ console.log("              __FILE__ = "+__FILE__);				}
	if(typeof      __LINE__ !== "undefined"){ console.log("              __LINE__ = "+__LINE__);				}
	if(typeof      __FUNC__ !== "undefined"){ console.log("              __FUNC__ = "+__FUNC__);				}
	if(typeof DKSCRIPT_PATH !== "undefined"){ console.log("         DKSCRIPT_PATH = "+DKSCRIPT_PATH);			}
	if(typeof  DKSCRIPT_DIR !== "undefined"){ console.log("          DKSCRIPT_DIR = "+DKSCRIPT_DIR); 			}
	if(typeof DKSCRIPT_FILE !== "undefined"){ console.log("         DKSCRIPT_FILE = "+DKSCRIPT_FILE);			}
	if(typeof DKSCRIPT_NAME !== "undefined"){ console.log("         DKSCRIPT_NAME = "+DKSCRIPT_NAME);			}
	if(typeof  DKSCRIPT_EXT !== "undefined"){ console.log("          DKSCRIPT_EXT = "+DKSCRIPT_EXT); 			}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("         DKSCRIPT_ARGS = "+DKSCRIPT_ARGS);			}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("            DKHOME_DIR = "+DKHOME_DIR);				}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("           DKCACHE_DIR = "+DKCACHE_DIR);				}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("         DKDESKTOP_DIR = "+DKDESKTOP_DIR);			}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("           DIGITALKNOB = "+DIGITALKNOB);				}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("       DIGITALKNOB_DIR = "+DIGITALKNOB_DIR);			}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("        DKDOWNLOAD_DIR = "+DKDOWNLOAD_DIR);			}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("           DKTOOLS_DIR = "+DKTOOLS_DIR);				}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("              DKBRANCH = "+DKBRANCH);				}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("          DKBRANCH_DIR = "+DKBRANCH_DIR);			}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("        DK3RDPARTY_DIR = "+DK3RDPARTY_DIR);			}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("            DKAPPS_DIR = "+DKAPPS_DIR);				}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("            DKBASH_DIR = "+DKBASH_DIR);				}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log("  DKBASH_FUNCTIONS_DIR = "+DKBASH_FUNCTIONS_DIR);	}
	if(typeof DKSCRIPT_ARGS !== "undefined"){ console.log(" DKBASH_FUNCTIONS_DIR_ = "+DKBASH_FUNCTIONS_DIR_);	}

	//setGlobal GLOBAL_VAR "This is a global variable"
	//setReturn RETURN_VAR "This is a return variable"

	//var GLOBAL_VAR = %GLOBAL_VAR%
	//var RETURN_VAR = %RETURN_VAR%
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	dk_test("from :DKTEST", "to dk_test");
	console.log("")
	//console.log("GLOBAL_VAR = "+GLOBAL_VAR)
	//console.log("RETURN_VAR = "+RETURN_VAR)

//	Test::dk_test("from :DKTEST", "to Test::dk_test")
	console.log("")
/*	console.log("GLOBAL_VAR = "+GLOBAL_VAR)
	console.log("RETURN_VAR = "+RETURN_VAR)

	Test::Test::dk_test("from :DKTEST", "to Test::Test::dk_test")
	console.log("")
	console.log("GLOBAL_VAR = "+GLOBAL_VAR)
	console.log("RETURN_VAR = "+RETURN_VAR)
*/
}