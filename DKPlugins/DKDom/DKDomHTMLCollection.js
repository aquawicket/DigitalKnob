//https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection

///////////////////////////////////////
var HTMLCollection = function(pointers)
{
	var arry = pointers.split(",");
	for(var i=0; i<arry.length; i++){
		this.push(new HTMLElement(arry[i]));
	}
	
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

	return this;
}
HTMLCollection.prototype = [];