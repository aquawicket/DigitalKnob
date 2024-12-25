console.log("dk_XMLHttpRequest.js");

// dk_XMLHttpRequest()
dk_XMLHttpRequest = function dk_XMLHttpRequest(httpMethod, url, dk_sendRequest_callback){

    if (httpMethod){
        switch (httpMethod){
        case "GET":
        case "POST":
        case "PUT":
        case "HEAD":
        case "DELETE":
        case "PATCH":
        case "OPTIONS":
        case "CONNECT":
        case "TRACE":
            break;
        default:
            //return error("httpMethod '" + httpMethod + "' invalid", dk_sendRequest_callback(false));
			console.log("httpMethod '" + httpMethod + "' invalid");
        }
    }
    if (dk_sendRequest_callback.length < 3)
        //return error("dk_sendRequest_callback requires 3 arguments (success, url, data)", dk_sendRequest_callback(false));
		console.log("dk_sendRequest_callback requires 3 arguments (success, url, data)");
		
    var xhr;
    try {
        !xhr && (xhr = new XMLHttpRequest());
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml3.XMLHTTP"));
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml2.XMLHTTP.6.0"));
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml2.XMLHTTP.3.0"));
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml2.XMLHTTP"));
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Microsoft.XMLHTTP"));
    } catch (e){}
	
    if (!xhr)
        //return error("Error creating xhr object", dk_sendRequest_callback(false));
		console.log("Error creating xhr object");

    //FIXME: duktape
    //url = encodeURIComponent(url).replace(";", "%3B");  
	
    //https://en.wikipedia.org/wiki/List_of_HTTP_header_fields
	// if (httpMethod === "POST" || httpMethod === "Put")
	//     xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
	// xhr.timeout = 20000;

/*
    //Possible error codes
    //https://github.com/richardwilkes/cef/blob/master/cef/enums_gen.go
    xhr.onabort = function xhr_onabort(event){
        //dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> onabort");
        console.log("XMLHttpRequest.onabort()");//: " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        //return dk_sendRequest_callback(false, url, xhr.responseText);
    }
    xhr.onerror = function xhr_onerror(event){
        //dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> onerror");
        console.log("XMLHttpRequest.onerror()");//: " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        //return dk_sendRequest_callback(false, url, xhr.responseText);
    }
    xhr.onload = function xhr_onload(event){
        console.log("XMLHttpRequest.onload()");//: " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        //return dk_sendRequest_callback(true, url, xhr.responseText);
    }
    xhr.onloadend = function xhr_onloadend(event){
		console.log("XMLHttpRequest.onloadend()");//: " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onloadstart = function xhr_onloadstart(event){
		console.log("XMLHttpRequest.onloadstart()");//: " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onprogress = function xhr_onprogress(event){
		console.log("XMLHttpRequest.onprogress()");// " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
*/ 
	xhr.onreadystatechange = function xhr_onreadystatechange(){
		/*
		console.log("readyState = "+xhr.readyState)
		console.log("responseBody = "+xhr.responseBody)
		console.log("responseStream = "+xhr.responseStream)
		console.log("responseText = "+xhr.responseText)
		console.log("responseXML = "+xhr.responseXML)
		console.log("status = "+xhr.status)
		console.log("statusText = "+xhr.statusText)
		*/	
		(1, eval)(xhr.responseText)
		
        if (xhr.readyState === 4){
            if (xhr.status >= 200 && xhr.status < 400 || !xhr.status)
                dk_sendRequest_callback(true, url, xhr.responseText);
            else
                dk_sendRequest_callback(false, url, xhr.responseText);
        }
    }

    //console.log("dk.sendRequest("+httpMethod+","+decodeURIComponent(url)+")")
	xhr.open("GET", url, false);
	xhr.send();
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function(){
	//dk_debugFunc(0);
	
	var url = "file:///C:/Users/Administrator/digitalknob/Development/DKJavascript/functions/dk_echo.js"
	
	dk_XMLHttpRequest("GET", url, function dk_sendRequest_callback(success, url, data){
		if(!success){
			console.log("ERROR: dk_XMLHttpRequest() failed");
			return;
		}
		console.log("success");
		DKTEST();
	});
}



