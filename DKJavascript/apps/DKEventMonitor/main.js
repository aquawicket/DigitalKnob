//alert("DKEventMonitor")

function main(){
	dk_source(DKJAVASCRIPT_DIR+"/apps/DKHtmlConsole/DKHtmlConsole.js", function(){
		dkconsole = new DKHtmlConsole;
		dkconsole.create("","0px","0px","0px","","25%");
		dk_source(DKJAVASCRIPT_DIR+"/apps/DKEventMonitor/DKEventMonitor.js", function(){
			eventmonitor = new DKEventMonitor;
			eventmonitor.monitorEvents(window);
			eventmonitor.monitorEvents(document);
			eventmonitor.monitorEvents(document.body);
		});
	});	
}