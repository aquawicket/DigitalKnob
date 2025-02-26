function RunFile() {
	if(typeof ActiveXObject === "function"){
		WshShell = new ActiveXObject("WScript.Shell");
		WshShell.Run("c:/windows/system32/notepad.exe", 1, false);
	} else {
		console.error("ActiveXObject not available in browsers");
		alert("ActiveXObject not available in browsers");
	}
}
	
	
function main(){
	window.resizeTo(350, 350);
	window.moveTo(10, 10);
		
	var gui = '<input type="button" value="Run Notepad" onclick="RunFile();"/>'
	document.body.innerHTML = gui;
}