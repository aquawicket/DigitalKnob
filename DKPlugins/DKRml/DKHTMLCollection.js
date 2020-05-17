//https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection

///////////////////////////////////////
var HTMLCollection = function(pointers)
{
	//DKDEBUGFUNC();
	//console.warn("HTMLCollection()");	
	
	Object.defineProperty(this, "length", { 
		get: function(){ 
			var length = "TODO";
			return length;
		} 
	});
	
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
	for(var i=0; i<arry.length; i++){
		console.log(arry[i]);
		this.push(new HTMLElement(arry[i])) //TypeError: setter undefined
	}
}
HTMLCollection.prototype = [];