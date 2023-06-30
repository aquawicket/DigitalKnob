console.log("\n////// TEST_Browser.js //////")

//////////// Setup ////////////
const window = new DKSdlWindow()
console.log("window = "+window);

const dkRmlInterface = new DKRmlInterface(window);
console.log("dkRmlInterface = "+dkRmlInterface);

const dkRmlEventListener = new DKRmlEventListener()
console.log("dkRmlEventListener = "+dkRmlEventListener);

const location = new DKRmlLocation(dkRmlInterface, dkRmlEventListener)	
console.log("location = "+location);

const document = new DKRmlDocument(dkRmlInterface, dkRmlEventListener);
console.log("document = "+document);
///////////////////////////////


const url = "DKWebTest/index.html"
location.href = url;


function onHyperlink(event) {
	console.log("onHyperlink()");
	const target = event.target;
	console.log("target = "+target);
	const value = target.getAttribute("href");
	console.log("value = "+value);
	location.href = value;
}

function onLoad(event) {
	console.log("onLoad()");
	
	//////////// Post processing <a href></a> hyperlinks ////////////
	var aElements = document.getElementsByTagName("a");
	if(!aElements){
		console.error("aElements invalid!");
		return;
	}

	//console.log("aElement->length() = "+toString(aElements->length()));
	for(var i=0; i<aElements.length; i++){
		var item = aElements.item(i);
		if(!item){
			console.error("aElements.item("+i+") invalid!");
			return;
		}
		if (item.hasAttribute("href")) {
			//item.addEventListener("click", onHyperlink);
			const style = item.style;
			if(!style){
				console.error("style invalid!");
				return;
			}
			style.setProperty("color", "rgb(0,0,255)");
			style.setProperty("text-decoration", "underline");
		}
	}
}
//document.addEventListener('load', onLoad);
//document.dispatchEvent(new Event('load'));
onLoad();