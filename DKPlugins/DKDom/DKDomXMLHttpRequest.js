// https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
// https://xhr.spec.whatwg.org/

// https://xhr.spec.whatwg.org/#interface-xmlhttprequest

//IDL: [Exposed=(Window,DedicatedWorker,SharedWorker)]

var XMLHttpRequest = function(pointer) {
    XMLHttpRequest.prototype.open = function(method, url, async, user, password) {
        //console.warn("XMLHttpRequest.open("+method+","+url+","+async+")");
        this.method = method;
        this.url = url;
        this.async = async;
    }
    XMLHttpRequest.prototype.send = function() {
        //console.warn("XMLHttpRequest.send()");
        this.readyState = 4;
        this.status = 200;
        this.statusText = "TODO";
        this.responseText = CPP_DKDomXMLHttpRequest_send(this.method, this.url, this.async);
        this.onreadystatechange();
    }

    XMLHttpRequest.prototype.onreadystatechange = function() {
        console.log("TODO: XMLHttpRequest.prototype.onreadystatechange()");
    }

    return XMLHttpRequestEventTarget.call(this, pointer);
}
XMLHttpRequest.prototype = XMLHttpRequestEventTarget.prototype;
