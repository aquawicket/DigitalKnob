"use strict";
// https://www.sitepoint.com/get-url-parameters-with-javascript/ 


const DKApp = function() {};
const dkapp = new DKApp;
let urlParams
let loadScript
let runScript

dkapp.loadFiles = function dkapp_loadFiles(event) {
	console.log("loadFiles()")
	const wls = decodeURIComponent(event.currentTarget.ownerDocument.location.search);
	const queryString = wls;
	urlParams = new URLSearchParams(queryString)
	loadScript = urlParams.get('l')
	if(loadScript)
		eval(loadScript)
}

dkapp.runApp = function dkapp_runApp(event) {	
	console.log("runApp()")
	const wls = decodeURIComponent(event.currentTarget.location.search);
	const queryString = wls;
	urlParams = new URLSearchParams(queryString)
	loadScript = urlParams.get('r')
	if(loadScript)
		eval(loadScript)
	
	if(!loadScript && !runScript){
		const div = document.createElement("div")
		div.style.position = "absolute"
		div.style.top = "5rem"
		div.style.left = "5rem"
		div.style.bottom = "5rem"
		div.style.right = "5rem"
		div.style.backgroundColor = "rgb(250,250,250)"
		document.body.appendChild(div)

		const loadarea = document.createElement("textarea")
		loadarea.style.position = "absolute"
		loadarea.style.top = "0rem"
		loadarea.style.left = "0rem"
		loadarea.style.bottom = "44%"
		loadarea.style.right = "0rem"
		loadarea.style.width = "100%"
		loadarea.style.fontSize = "14rem"
		loadarea.style.color = "rgb(200,200,200)"
		loadarea.style.backgroundColor = "rgb(30,30,30)"
		div.appendChild(loadarea)
		
		const runarea = document.createElement("textarea")
		runarea.style.position = "absolute"
		runarea.style.top = "46%"
		runarea.style.left = "0rem"
		runarea.style.bottom = "30rem"
		runarea.style.right = "0rem"
		runarea.style.width = "100%"
		runarea.style.fontSize = "14rem"
		runarea.style.color = "rgb(200,200,200)"
		runarea.style.backgroundColor = "rgb(30,30,30)"
		div.appendChild(runarea)
		
		const testCode = document.createElement("button")
		testCode.innerHTML = "Test Code";
		testCode.style.position = "absolute"
		testCode.style.bottom = "2rem"
		testCode.style.right = "218rem"
		testCode.style.width = "100rem"
		testCode.style.height = "25rem"
		div.appendChild(testCode);
		testCode.onclick = function(){
			loadarea.value = "DKPlugin('DKGui/DKGui.js')\nDKPlugin('DKGui/DKConsole.js')" //test code
			runarea.value = "DKConsole.prototype.create(document.body, '', '0rem', '0rem', '0rem', '100%', '25%');" //test code
		}
		
		const encodeIt = document.createElement("button")
		encodeIt.innerHTML = "Encode Uri";
		encodeIt.style.position = "absolute"
		encodeIt.style.bottom = "2rem"
		encodeIt.style.right = "110rem"
		encodeIt.style.width = "100rem"
		encodeIt.style.height = "25rem"
		div.appendChild(encodeIt);
		
		const runCode = document.createElement("button")
		runCode.innerHTML = "Run Code";
		runCode.style.position = "absolute"
		runCode.style.bottom = "2rem"
		runCode.style.right = "2rem"
		runCode.style.width = "100rem"
		runCode.style.height = "25rem"
		div.appendChild(runCode);
		runCode.disabled = true;
		
		encodeIt.onclick = function(){
			console.log("Encoding data . . .")
			let url_string = location.href +"?l="+loadarea.value+"&r="+runarea.value
			const url_encoded = encodeURI(url_string)
			loadarea.value = url_string
			runarea.value = url_encoded
			runCode.disabled = false;
		
			runCode.onclick = function(){
				window.location = url_encoded
			}
		}
	}
}

DUKTAPE && dkapp.loadFiles();
DUKTAPE && dkapp.loadFApp();