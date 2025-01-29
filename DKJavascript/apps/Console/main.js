dk_source(DKJAVASCRIPT_DIR+"/functions/DKHtmlConsole.js");

function main(){
	var DKHtml = 1;
	dkTitle = "DigitalKnob - " + location.href;
	document.title = dkTitle;

	document.addEventListener("DOMContentLoaded", onDOMContentLoaded() );
	function onDOMContentLoaded() {
		dkconsole = new DKHtmlConsole;
		dkconsole.create("","0px","0px","0px","","25%");

		console.log(dkTitle + "<br></br>");
		console.log("HOST = "+HOST);
	}
}