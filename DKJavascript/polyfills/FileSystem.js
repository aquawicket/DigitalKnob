
(function(fs){
	if(typeof WScript === "object"){
		var FileSystem = function(){ return new ActiveXObject("Scripting.FileSystemObject"); }
		globalThis.FileSystem = FileSystem
		var FileStream = function(){ return WScript.CreateObject('ADODB.Stream'); }
		globalThis.FileStream = FileStream
	}
})(this.FileSystem = this.FileSystem || {});