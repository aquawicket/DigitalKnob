
namespace DK{ public static class APP{
        	
//############################################################################
//# dk_info(message)
//#
public static int dk_info(string message){
	DKAPP.MAIN obj=new DKAPP.MAIN();
	//obj.CompileAndRun("dk_log");
	DKAPP.MAIN.myObj.CompileAndRun("dk_log");
	return 0;
}
    
	
	
	
	
//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
public static void DKTEST(){
	dk_info("dk_info()");
}

}}