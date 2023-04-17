// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document


// [Document()]
var Document = function Document(address) {
	//console.log("Document("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKDocumentDUK();

	
	////// Instance properties //////
	// [Document.activeElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/activeElement
	// [Document.adoptedStyleSheets] https://developer.mozilla.org/en-US/docs/Web/API/Document/adoptedStyleSheets
	// [Document.body] https://developer.mozilla.org/en-US/docs/Web/API/Document/body
	// [Document.characterSet](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
	// [Document.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/childElementCount
	// [Document.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/children
	// [Document.compatMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/compatMode
	// [Document.contentType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/contentType
	// [Document.currentScript](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/currentScript
	// [Document.doctype](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/doctype
	// [Document.documentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentElement
	// [Document.documentURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentURI
	// [Document.embeds](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/embeds
	// [Document.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/firstElementChild
	// [Document.fonts] https://developer.mozilla.org/en-US/docs/Web/API/Document/fonts
	// [Document.forms](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/forms
	// [Document.fragmentDirective](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Document/fragmentDirective
	// [Document.fullscreenElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenElement
	// [Document.head](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/head
	// [Document.hidden](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/hidden
	// [Document.images](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/images
	// [Document.implementation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/implementation
	// [Document.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastElementChild
	// [Document.links](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/links
	// [Document.pictureInPictureElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureElement
	// [Document.pictureInPictureEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureEnabled
	// [Document.plugins](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/plugins
	// [Document.pointerLockElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pointerLockElement
	// [Document.featurePolicy Experimental](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/featurePolicy
	// [Document.scripts](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scripts
	// [Document.scrollingElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scrollingElement
	// [Document.styleSheets](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/styleSheets
	// [Document.timeline](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/timeline
	// [Document.visibilityState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/visibilityState
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Document]" }
	
	
	return Node.call(this)
}
Document.prototype = Node.prototype
