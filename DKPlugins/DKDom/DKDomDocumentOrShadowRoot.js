// https://developer.mozilla.org/en-US/docs/Web/API/DocumentOrShadowRoot
// https://javascript.info/mixins

var DocumentOrShadowRoot = {
	
	// Properties
	//activeElement =      { console.log("activeElement");      } //FIXME
	//fullscreenElement =  { console.log("fullscreenElement");  } //FIXME
	//pointerLockElement = { console.log("pointerLockElement"); } //FIXME
	//styleSheets =        { console.log("styleSheets");        } //FIXME
	
	// Methods
	caretPositionFromPoint(){
		//TODO
	},
	
	elementFromPoint(){
		console.log("DocumentOrShadowRoot.elementFromPoint()");
		var elementAddress = DKDomDocumentOrShadowRoot_elementFromPoint();
		if(!elementAddress ){ return; }
		return new HTMLElement(elementAddress);
	},
	
	elementsFromPoint(){ 
		//TODO
		DKDomDocumentOrShadowRoot_elementsFromPoint();
	},
	getSelection(){
		//TODO
		DKDomDocumentOrShadowRoot_getSelection();
	},
	nodeFromPoint(){
		//TODO
		DKDomDocumentOrShadowRoot_nodeFromPoint();
	},
	nodesFromPoint(){
		//TODO
		DKDomDocumentOrShadowRoot_nodesFromPoint();
	}
};