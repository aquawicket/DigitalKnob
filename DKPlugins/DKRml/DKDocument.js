var document;

////////////////////////////////
var Document = function(pointer)
{
	Document.prototype.getElementById = function(id){
		var pointer = DKDocument_getElementById(id);
		if(!pointer){ return; }
		var element = new HTMLElement(pointer);
		return element;
	}
}

document = new Document("document");