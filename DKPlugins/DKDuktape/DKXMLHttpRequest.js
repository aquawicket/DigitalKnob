function DKXMLHttpRequest_Init(){}

////////////////////////////////
var XMLHttpRequest = function(){
	
	XMLHttpRequest.prototype.open = function(method, url, async, user, password){
		DKWARN("XMLHttpRequest.open("+method+","+url+","+async+")");
		this.method = method;
		this.url = url;
		this.async = async;
	}
	XMLHttpRequest.prototype.send = function(){
		DKWARN("XMLHttpRequest.send()");
		this.readyState = 4;
		this.status = 200;
		this.statusText = "TODO";
		this.responseText = DKXMLHttpRequest_send(this.method, this.url, this.async);
		this.onreadystatechange();
	}
}