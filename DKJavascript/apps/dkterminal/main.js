//alert("DKTerminal")

function main(){
	dk_source(DKJAVASCRIPT_DIR+"/functions/DKHtmlConsole.js", function(){
		dkconsole = new DKHtmlConsole;
		dkconsole.create("","0px","0px","0px","","25%");
		dk_source(DKJAVASCRIPT_DIR+"/functions/DKEventMonitor.js", function(){
			eventmonitor = new DKEventMonitor;
			eventmonitor.monitorEvents(window);
			eventmonitor.monitorEvents(document);
			eventmonitor.monitorEvents(document.body);
		});
	});	
}