//https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest

///////////////////////////////
var XMLHttpRequest = function()
{
	XMLHttpRequest.prototype.open = function(method, url, async, user, password){
		//console.warn("XMLHttpRequest.open("+method+","+url+","+async+")");
		this.method = method;
		this.url = url;
		this.async = async;
	}
	XMLHttpRequest.prototype.send = function(){
		//console.warn("XMLHttpRequest.send()");
		this.readyState = 4;
		this.status = 200;
		this.statusText = "TODO";
		this.responseText = DKCPP_DKDomXMLHttpRequest_send(this.method, this.url, this.async);
		this.onreadystatechange();
	}
}