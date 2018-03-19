DKCreate("DKCurl");

//TODO
var str = DK_GetArgs(); //Get arguments
//DKLog("args = "+str+"\n", DKINFO);
var args = str.split(";");
if(args.length < 2){
	DKLog("Incorrect number of arguments");
}
DKCurl_Download(args[0], args[1]);
DK_Exit();