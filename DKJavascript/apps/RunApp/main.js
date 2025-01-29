function RunFile() {
	WshShell = new ActiveXObject("WScript.Shell");
	WshShell.Run("c:/windows/system32/notepad.exe", 1, false);
}
	
	
function main(){
	window.resizeTo(350, 350);
	window.moveTo(10, 10);
		
	var gui = '<input type="button" value="Run Notepad" onclick="RunFile();"/>'
	document.body.innerHTML = gui;
}