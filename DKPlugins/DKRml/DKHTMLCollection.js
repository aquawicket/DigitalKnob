//https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection

///////////////////////////////
var HTMLCollection = function()
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
}
HTMLCollection.prototype = [];