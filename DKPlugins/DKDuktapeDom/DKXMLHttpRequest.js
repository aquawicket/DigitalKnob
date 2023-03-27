// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
// [INTERFACE] https://xhr.spec.whatwg.org/#interface-xmlhttprequest


// [XMLHttpRequest()] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/XMLHttpRequest
var XMLHttpRequest = function XMLHttpRequest() {

	////// Instance properties //////
	// [XMLHttpRequest.readyState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/readyState
	Object.defineProperty(this, "readyState", {
        get: function readyState() {
            //TODO return CPP_DKXMLHttpRequest_readyState(_pointer)
        }
    })
	// [XMLHttpRequest.response](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/response
	Object.defineProperty(this, "response", {
        get: function response() {
            //TODO return CPP_DKXMLHttpRequest_response(_pointer)
        }
    })
	// [XMLHttpRequest.responseText](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/responseText
	Object.defineProperty(this, "responseText", {
        get: function responseText() {
            //TODO return CPP_DKXMLHttpRequest_responseText(_pointer)
        }
    })
	// [XMLHttpRequest.responseType] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/responseType
	Object.defineProperty(this, "responseType", {
        get: function responseType() {
            //TODO return CPP_DKXMLHttpRequest_responseType(_pointer)
        }
    })
	// [XMLHttpRequest.responseURL](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/responseURL
	Object.defineProperty(this, "responseURL", {
        get: function responseURL() {
            //TODO return CPP_DKXMLHttpRequest_responseURL(_pointer)
        }
    })
	// [XMLHttpRequest.responseXML](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/responseXML
	Object.defineProperty(this, "responseXML", {
        get: function responseXML() {
            //TODO return CPP_DKXMLHttpRequest_responseXML(_pointer)
        }
    })
	// [XMLHttpRequest.status](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/status
	Object.defineProperty(this, "status", {
        get: function status() {
            //TODO return CPP_DKXMLHttpRequest_status(_pointer)
        }
    })
	// [XMLHttpRequest.statusText](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/statusText
	Object.defineProperty(this, "statusText", {
        get: function statusText() {
            //TODO return CPP_DKXMLHttpRequest_statusText(_pointer)
        }
    })
	// [XMLHttpRequest.timeout] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/timeout
	Object.defineProperty(this, "timeout", {
        get: function timeout() {
            //TODO return CPP_DKXMLHttpRequest_timeout(_pointer)
        }
    })
	// [XMLHttpRequest.upload](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/upload
	Object.defineProperty(this, "upload", {
        get: function upload() {
            //TODO return CPP_DKXMLHttpRequest_upload(_pointer)
        }
    })
	// [XMLHttpRequest.withCredentials] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/withCredentials
	Object.defineProperty(this, "withCredentials", {
        get: function withCredentials() {
            //TODO return CPP_DKXMLHttpRequest_withCredentials(_pointer)
        }
    })


	////// Non-standard properties //////
	// [XMLHttpRequest.channel](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/channel
	Object.defineProperty(this, "channel", {
        get: function channel() {
            //TODO return CPP_DKXMLHttpRequest_channel(_pointer)
        }
    })
	// [XMLHttpRequest.mozAnon](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/mozAnon
	Object.defineProperty(this, "mozAnon", {
        get: function mozAnon() {
            //TODO return CPP_DKXMLHttpRequest_mozAnon(_pointer)
        }
    })
	// [XMLHttpRequest.mozSystem](Read only) https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/mozSystem
	Object.defineProperty(this, "mozSystem", {
        get: function mozSystem() {
            //TODO return CPP_DKXMLHttpRequest_mozSystem(_pointer)
        }
    })
	// [XMLHttpRequest.mozBackgroundRequest] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/mozBackgroundRequest
	Object.defineProperty(this, "mozBackgroundRequest", {
        get: function mozBackgroundRequest() {
            //TODO return CPP_DKXMLHttpRequest_mozBackgroundRequest(_pointer)
        }
    })
	
	
	////// Instance methods //////
	// [XMLHttpRequest.abort()] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/abort
	XMLHttpRequest.prototype.abort = function abort() {
		//TODO
    }
	// [XMLHttpRequest.getAllResponseHeaders()] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/getAllResponseHeaders
	XMLHttpRequest.prototype.getAllResponseHeaders = function getAllResponseHeaders() {
		//TODO
    }
	// [XMLHttpRequest.getResponseHeader()] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/getResponseHeader
	XMLHttpRequest.prototype.getResponseHeader = function getResponseHeader() {
		//TODO
    }
	// [XMLHttpRequest.open()] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/open
	XMLHttpRequest.prototype.open = function open(method, url, async, user, password) {
        console.warn("XMLHttpRequest.open(" + method + "," + url + "," + async + ")");
        this.method = method;
        this.url = url;
        this.async = async;
    }
	// [XMLHttpRequest.overrideMimeType()] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/overrideMimeType
	XMLHttpRequest.prototype.overrideMimeType = function overrideMimeType() {
		//TODO
    }
	// [XMLHttpRequest.send()] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/send
	XMLHttpRequest.prototype.send = function send() {
        console.warn("XMLHttpRequest.send()");
        this.readyState = 4;
        this.status = 200;
        this.statusText = "TODO";
        this.responseText = CPP_DKXMLHttpRequest_send(this.method, this.url, this.async);
        this.onreadystatechange();
    }
	// [XMLHttpRequest.setRequestHeader()] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/setRequestHeader
	XMLHttpRequest.prototype.setRequestHeader = function setRequestHeader() {
		//TODO
    }
	
	
	////// Events //////
	// [abort] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/abort_event
	// [error] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/error_event
	// [load] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/load_event
	// [loadend] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/loadend_event
	// [loadstart] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/loadstart_event
	// [progress] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/progress_event
	// [readystatechange] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/readystatechange_event
	// [timeout] https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/timeout_event


	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object XMLHttpRequest]"
		}
	}
}
