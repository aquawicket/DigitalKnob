console = new Object;
console.log = function(msg){
	WScript.StdOut.Write(msg+"\n");
}