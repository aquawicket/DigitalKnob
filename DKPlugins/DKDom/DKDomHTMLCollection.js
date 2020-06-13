//https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection

///////////////////////////////////////
var HTMLCollection = function(pointers)
{
	//DKDEBUGFUNC();
	if(!pointers){ return; }
	
	HTMLCollection.prototype.item = function(index){
		return this[index];
	}
	HTMLCollection.prototype.namedItem = function(name){
		for(var i=0; i<this.length; i++){
			if(this.id && this.id == name){
				return this[i];
			}
			if(this.name && this.name == name){
				return this[i];
			}
		}
		return null;
	}
	
	var arry = pointers.split(",");
	this.length = arry.length;
	for(var i=0; i<arry.length; i++){
		this[i] = HTMLElement(arry[i]);
	}
}
HTMLCollection.prototype = [];