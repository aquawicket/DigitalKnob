
if(typeof WScript === "object"){
	var XMLHttpRequest = function(){ return new ActiveXObject("MSXML2.XMLHTTP.6.0"); }
}