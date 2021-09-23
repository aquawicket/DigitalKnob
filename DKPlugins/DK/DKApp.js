//"use strict";
// https://www.sitepoint.com/get-url-parameters-with-javascript/ 


const DKApp = function() {};
const dkapp = new DKApp;
//let urlParams
//let loadScript
//let runScript



// Getting a URL Parameter
// https://www.sitepoint.com/get-url-parameters-with-javascript/
function getUrlParametersString(){
	const queryString = window.location.search;
	console.log(queryString);
	// ?product=shirt&color=blue&newuser&size=m
}
// Get Parameter value by Name
https://www.sitepoint.com/get-url-parameters-with-javascript/
function GetParameteByName(name, result){
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
	const value = urlParams.get(name)
	result = value
	console.log(result)
	return resuilt
}
// Checking for the Presence of a Parameter
https://www.sitepoint.com/get-url-parameters-with-javascript/
function HasParameter(name, result){
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
	result = urlParams.has(name)
	return result
}
// Rolling Your Own Query String Parsing Function
// https://www.sitepoint.com/get-url-parameters-with-javascript/
function getAllUrlParams(url) {
	var queryString = url ? url.split('?')[1] : window.location.search.slice(1); // get query string from url (optional) or window
	var obj = {}; // we'll store the parameters here
	if (queryString) { // if query string exists
		queryString = queryString.split('#')[0]; // stuff after # is not part of query string, so get rid of it
		var arr = queryString.split('&'); // split our query string into its component parts
		for (var i = 0; i < arr.length; i++) {
			var a = arr[i].split('='); // separate the keys and the values
			var paramName = a[0];  // set parameter name and value (use 'true' if empty)
			var paramValue = typeof (a[1]) === 'undefined' ? true : a[1];
			paramName = paramName.toLowerCase(); // (optional) keep case consistent
			if (typeof paramValue === 'string') paramValue = paramValue.toLowerCase();
			if (paramName.match(/\[(\d+)?\]$/)) { // if the paramName ends with square brackets, e.g. colors[] or colors[2]
			var key = paramName.replace(/\[(\d+)?\]/, '');  // create key if it doesn't exist
			if (!obj[key]) obj[key] = [];       
				if (paramName.match(/\[\d+\]$/)) {  // if it's an indexed array e.g. colors[2]
					var index = /\[(\d+)\]/.exec(paramName)[1]; // get the index value and add the entry at the appropriate position
				obj[key][index] = paramValue;
			} 
			else {
				obj[key].push(paramValue); // otherwise add the value to the end of the array
			}
		} 
		else {
			if (!obj[paramName]) { // we're dealing with a string
				obj[paramName] = paramValue;  // if it doesn't exist, create property
			} 
			else if (obj[paramName] && typeof obj[paramName] === 'string'){
				obj[paramName] = [obj[paramName]]; // if property does exist and it's a string, convert it to an array
				obj[paramName].push(paramValue);
			} 
			else {
				obj[paramName].push(paramValue); // otherwise add the property
			}
		}
    }
	return obj;
}







dkapp.loadFiles = function dkapp_loadFiles(event) {
	console.log("loadFiles()")
	const wls = decodeURIComponent(event.currentTarget.ownerDocument.location.search);
	const queryString = wls;
	const urlParams = new URLSearchParams(queryString)
	const loadScript = urlParams.get('l')
	if(loadScript)
		eval(loadScript)
}

dkapp.runApp = function dkapp_runApp(event) {	
	console.log("runApp()")
	const wls = decodeURIComponent(event.currentTarget.location.search);
	const queryString = wls;
	const urlParams = new URLSearchParams(queryString)
	const runScript = urlParams.get('r')
	if(runScript)
		eval(runScript)
	
	if(/*!loadScript && */!runScript){
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