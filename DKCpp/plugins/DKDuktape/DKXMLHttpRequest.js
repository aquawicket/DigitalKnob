//https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest

<<<<<<< HEAD:DKPlugins/DKDuktape/DKXMLHttpRequest.js
var XMLHttpRequest = function XMLHttpRequest() {

    XMLHttpRequest.prototype.open = function open(method, url, async, user, password) {
=======
var XMLHttpRequest = function XMLHttpRequest(){

    XMLHttpRequest.prototype.open = function open(method, url, async, user, password){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKXMLHttpRequest.js
        console.warn("XMLHttpRequest.open(" + method + "," + url + "," + async + ")");
        this.method = method;
        this.url = url;
        this.async = async;
    }
<<<<<<< HEAD:DKPlugins/DKDuktape/DKXMLHttpRequest.js
    XMLHttpRequest.prototype.send = function send() {
=======
    XMLHttpRequest.prototype.send = function send(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKXMLHttpRequest.js
        console.warn("XMLHttpRequest.send()");
        this.readyState = 4;
        this.status = 200;
        this.statusText = "TODO";
        this.responseText = CPP_DKXMLHttpRequest_send(this.method, this.url, this.async);
        this.onreadystatechange();
    }
}
