
eval((new ActiveXObject("Scripting.FileSystemObject")).OpenTextFile("DK.js", 1).ReadAll());


dk_log = function(msg){
	dk_echo(msg);
}
	
	
dk_log("dk_log()")