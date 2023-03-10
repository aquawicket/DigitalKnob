// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
// [INTERFACE] https://xhr.spec.whatwg.org/#interface-xmlhttprequest


// [XMLHttpRequest()] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/XMLHttpRequest
var XMLHttpRequest = function XMLHttpRequest() {

	////// Instance properties //////
	// [XMLHttpRequest.readyState](Read only)
	Object.defineProperty(this, "readyState", {
        get: function readyState() {
            //TODO return CPP_DKXMLHttpRequest_readyState(_pointer)
        }
    })
	// [XMLHttpRequest.response](Read only)
	// [XMLHttpRequest.responseText](Read only)
	// [XMLHttpRequest.responseType]
	// [XMLHttpRequest.responseURL](Read only)
	// [XMLHttpRequest.responseXML](Read only)
	// [XMLHttpRequest.status](Read only)
	// [XMLHttpRequest.statusText](Read only)
	// [XMLHttpRequest.timeout]
	// [XMLHttpRequest.upload](Read only)
	// [XMLHttpRequest.withCredentials]


    XMLHttpRequest.prototype.open = function open(method, url, async, user, password) {
        console.warn("XMLHttpRequest.open(" + method + "," + url + "," + async + ")");
        this.method = method;
        this.url = url;
        this.async = async;
    }
    XMLHttpRequest.prototype.send = function send() {
        console.warn("XMLHttpRequest.send()");
        this.readyState = 4;
        this.status = 200;
        this.statusText = "TODO";
        this.responseText = CPP_DKXMLHttpRequest_send(this.method, this.url, this.async);
        this.onreadystatechange();
    }
	
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object XMLHttpRequest]"
		}
	}
}
