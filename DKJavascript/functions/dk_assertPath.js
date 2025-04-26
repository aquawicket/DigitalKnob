//if(!dk_valid("DK"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}
if(!dk_valid("dk_error")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_error.js", function(){}); }

//################################################################################
//# dk_assertPath(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_assertPath = function dk_assertPath_f(){
	//dk_debugFunc(0 99);
	
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	console.log('dk_assertPath('+_ARGV_+')');
	
	if(dk_valid("ActiveXObject")){ 
		fileSystemObject = new ActiveXObject("Scripting.FileSystemObject");
	};
	if(dk_valid("fileSystemObject.FolderExists")){
		if(fileSystemObject.FolderExists(arguments[0]) || fileSystemObject.FileExists(arguments[0])){
			return 0
		};
	};
	
	dk_error("ASSERTION: dk_assertPath("+arguments[0]+"): path not found!");
	return 1;
};





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(callback){
	//dk_debugFunc 0

	//# correct path
	dk_assertPath("C:/Program Files/Common Files");		//OK
	//# back slashes
	dk_assertPath("C:\\Program Files\\Common Files");	//OK
	//# lower case
	dk_assertPath("c:/program files/common files");		//OK
	//# UPPER CASE
	dk_assertPath("C:/PROGRAM FILES/COMMON FILES");		//OK
	//# No quotes
//	dk_assertPath(C:/PROGRAM FILES/COMMON FILES)		//OK
	//# as Variable
    myPath = "C:/Program Files/Common Files";
	//# As a variable name
    dk_assertPath(myPath);								//OK
	//# As a variable name quoted
	dk_assertPath("myPath")								//ASSERT
	//# CMD.exe
//	dk_assertPath("%COMSPEC%")							//OK
	
    //dk_assertPath("C:/NonExistentPath");				//ASSERT
	
	if(callback){ callback(); }
};