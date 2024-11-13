public static class APP{
        	
//############################################################################
//# dk_fileExists(file)
//#

public static bool dk_fileExists(string file){
	bool exists = System.IO.File.Exists(file);
	System.Console.WriteLine("{0} exists = {1}", file, exists);
	return exists;
}
    
	
	
	
	
//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
public static void DKTEST(){
	bool exists = dk_fileExists("C:\\Windows\\System32\\cmd.exe");
	System.Console.WriteLine("exists = "+exists);
}

}
