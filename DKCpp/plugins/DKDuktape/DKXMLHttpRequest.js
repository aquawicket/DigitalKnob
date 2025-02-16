//https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest

var XMLHttpRequest = function XMLHttpRequest() {

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
}
