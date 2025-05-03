//if(!dk_valid("DK")){ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){}); }

function runApp(){
	dk_run("C:/Windows/System32/notepad.exe");
}

function main() {
	window.resizeTo(350, 350);
	window.moveTo(10, 10);
	if(!dk_valid("dk_run"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_run.js", function() {
		document.body.innerHTML = '<input type="button" value="Run Notepad" onclick="runApp()"/>';
	});	}
};