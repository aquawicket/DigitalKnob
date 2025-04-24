// https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
// https://xhr.spec.whatwg.org/

// https://xhr.spec.whatwg.org/#interface-xmlhttprequest

//IDL: [Exposed=(Window,DedicatedWorker,SharedWorker)]

<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequest.js
var XMLHttpRequest = function XMLHttpRequest(pointer) {
    XMLHttpRequest.prototype.open = function open(method, url, async, user, password) {
=======
var XMLHttpRequest = function XMLHttpRequest(pointer){
    XMLHttpRequest.prototype.open = function open(method, url, async, user, password){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequest.js
        //console.warn("XMLHttpRequest.open("+method+","+url+","+async+")");
        this.method = method;
        this.url = url;
        this.async = async;
    }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequest.js
    XMLHttpRequest.prototype.send = function send() {
=======
    XMLHttpRequest.prototype.send = function send(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequest.js
        //console.warn("XMLHttpRequest.send()");
        this.readyState = 4;
        this.status = 200;
        this.statusText = "TODO";
        this.responseText = CPP_DKDomXMLHttpRequest_send(this.method, this.url, this.async);
        this.onreadystatechange();
    }

<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequest.js
    XMLHttpRequest.prototype.onreadystatechange = function onreadystatechange() {
=======
    XMLHttpRequest.prototype.onreadystatechange = function onreadystatechange(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequest.js
        console.log("TODO: XMLHttpRequest.prototype.onreadystatechange()");
    }

    return XMLHttpRequestEventTarget.call(this, pointer);
}
XMLHttpRequest.prototype = XMLHttpRequestEventTarget.prototype;
