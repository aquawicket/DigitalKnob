console.log("\n////// TEST_DKRmlDocument.js //////")


function printDKRmlDocumentProperties(dkRmlDocument){
	
	console.log("dkRmlDocument = "		+dkRmlDocument);
	
	printDocumentProperties(dkRmlDocument);		//requires TEST_Document.js
}


const dkRmlDocument = new DKRmlDocument(dkRmlInterface, dkRmlEventListener);		// requires TEST_DKRmlInterface.js and TEST_DKRmlEventListener.js

function onLoad(event){
	console.log("onLoad()");

	//////////// Post processing <a href></a> hyperlinks ////////////
	var aElements = dkRmlDocument.getElementsByTagName("a");
	
	if(aElements){
		console.error("aElements invalid!");
	}
	else{
		console.log("aElement.length() = "+aElements.length());
		for(var int i=0; i<aElements.length(); ++i){
			var item = aElements.item(i);
			if (!item)
				console.error("aElements.item(" + i + ") invalid!");
			if (item.hasAttribute("href")) {
				item.style.setProperty("color", "rgb(0,0,255)");
				item.style.setProperty("text-decoration", "underline");
				//item.addEventListener("click", onHyperlink);
			}
		}
	}
	printEventProperties(event)
}
dkRmlDocument.addEventListener('load', onLoad)		// FIXME
const load_event = new Event("load", "");
dkRmlDocument.dispatchEvent(load_event);

printDKRmlDocumentProperties(dkRmlDocument);

