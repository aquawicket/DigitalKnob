alert = function(msg){
	var objShell = WScript.CreateObject("WScript.Shell");
	objShell.Popup(msg, 5, "Alert");
}