// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement


////// Constructor //////
// [HTMLElement()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/HTMLElement
var HTMLElement = function HTMLElement(address) {
	//console.log("HTMLElement("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKHTMLElementDUK();

	
	////// Instance properties //////
	// [HTMLElement.activeElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/activeElement
	// [HTMLElement.adoptedStyleSheets] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/adoptedStyleSheets
	// [HTMLElement.body] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/body
	// [HTMLElement.characterSet](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/characterSet
	// [HTMLElement.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/childElementCount
	// [HTMLElement.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/children
	// [HTMLElement.compatMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/compatMode
	// [HTMLElement.contentType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/contentType
	// [HTMLElement.currentScript](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/currentScript
	// [HTMLElement.doctype](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/doctype
	// [HTMLElement.documentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/documentElement
	// [HTMLElement.documentURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/documentURI
	// [HTMLElement.embeds](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/embeds
	// [HTMLElement.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/firstElementChild
	// [HTMLElement.fonts] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/fonts
	// [HTMLElement.forms](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/forms
	// [HTMLElement.fragmentDirective](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/fragmentDirective
	// [HTMLElement.fullscreenElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/fullscreenElement
	// [HTMLElement.head](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/head
	// [HTMLElement.hidden](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/hidden
	// [HTMLElement.images](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/images
	// [HTMLElement.implementation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/implementation
	// [HTMLElement.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/lastElementChild
	// [HTMLElement.links](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/links
	// [HTMLElement.pictureInPictureElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/pictureInPictureElement
	// [HTMLElement.pictureInPictureEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/pictureInPictureEnabled
	// [HTMLElement.plugins](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/plugins
	// [HTMLElement.pointerLockElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/pointerLockElement
	// [HTMLElement.featurePolicy Experimental](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/featurePolicy
	// [HTMLElement.scripts](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/scripts
	// [HTMLElement.scrollingElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/scrollingElement
	// [HTMLElement.styleSheets](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/styleSheets
	// [HTMLElement.timeline](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/timeline
	// [HTMLElement.visibilityState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/visibilityState
	
	
	////// Extensions for HTMLHTMLElement //////
	// [HTMLElement.cookie] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/cookie
	// [HTMLElement.defaultView](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/defaultView
	// [HTMLElement.designMode] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/designMode
	// [HTMLElement.dir] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dir
	// [HTMLElement.domain](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/domain
	// [HTMLElement.fullscreenEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/fullscreenEnabled
	// [HTMLElement.lastModified](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/lastModified
	// [HTMLElement.location](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/location
	// [HTMLElement.readyState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/readyState
	// [HTMLElement.referrer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/referrer
	// [HTMLElement.title] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/title
	// [HTMLElement.URL](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/URL
		
	
	////// Deprecated properties //////
	// [HTMLElement.alinkColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/alinkColor
	// [HTMLElement.all](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/all
	// [HTMLElement.anchors](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/anchors
	// [HTMLElement.applets](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/applets
	// [HTMLElement.bgColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/bgColor
	// [HTMLElement.charset](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/characterSet
	// [HTMLElement.fgColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/fgColor
	// [HTMLElement.fullscreen](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/fullscreen
	// [HTMLElement.height](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientHeight
	// [HTMLElement.inputEncoding](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/characterSet
	// [HTMLElement.lastStyleSheetSet](Deprecated)(Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/lastStyleSheetSet
	// [HTMLElement.linkColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/linkColor
	// [HTMLElement.preferredStyleSheetSet](Deprecated)(Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/preferredStyleSheetSet
	// [HTMLElement.rootElement](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/rootElement
	// [HTMLElement.selectedStyleSheetSet](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/selectedStyleSheetSet
	// [HTMLElement.styleSheetSets](Deprecated)(Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/styleSheetSets
	// [HTMLElement.vlinkColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/vlinkColor
	// [HTMLElement.width](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientWidth
	// [HTMLElement.xmlEncoding](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/xmlEncoding
	// [HTMLElement.xmlStandalone](Deprecated)
	// [HTMLElement.xmlVersion](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/xmlVersion
		
	
	////// Instance methods //////
	// [HTMLElement.adoptNode()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/adoptNode
	// [HTMLElement.append()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/append
	// [HTMLElement.captureEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/caretPositionFromPoint
	// [HTMLElement.caretPositionFromPoint()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/caretPositionFromPoint
	// [HTMLElement.caretRangeFromPoint()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/caretRangeFromPoint
	// [HTMLElement.createAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createAttribute
	// [HTMLElement.createAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createAttributeNS
	// [HTMLElement.createCDATASection()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createCDATASection
	// [HTMLElement.createComment()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createComment
	// [HTMLElement.createHTMLElementFragment()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createHTMLElementFragment
	// [HTMLElement.createElement()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createElement
	// [HTMLElement.createElementNS()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createElementNS
	// [HTMLElement.createEntityReference()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
	// [HTMLElement.createEvent()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createEvent
	// [HTMLElement.createNodeIterator()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createNodeIterator
	// [HTMLElement.createProcessingInstruction()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createProcessingInstruction
	// [HTMLElement.createRange()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createRange
	// [HTMLElement.createTextNode()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createTextNode
	// [HTMLElement.createTouch()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createTouch
	// [HTMLElement.createTouchList()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createTouchList
	// [HTMLElement.createTreeWalker()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createTreeWalker
	// [HTMLElement.elementFromPoint()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/elementFromPoint
	// [HTMLElement.elementsFromPoint()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/elementsFromPoint
	// [HTMLElement.enableStyleSheetsForSet()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/enableStyleSheetsForSet
	// [HTMLElement.exitFullscreen()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/exitFullscreen
	// [HTMLElement.exitPictureInPicture()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/exitPictureInPicture
	// [HTMLElement.exitPointerLock()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/exitPointerLock
	// [HTMLElement.getAnimations()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/getAnimations
	// [HTMLElement.getBoxQuads()](Experimental)
	// [HTMLElement.getElementById()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/getElementById
	// [HTMLElement.getElementsByClassName()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/getElementsByClassName
	// [HTMLElement.getElementsByTagName()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/getElementsByTagName
	// [HTMLElement.getElementsByTagNameNS()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/getElementsByTagNameNS
	// [HTMLElement.getSelection()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/getSelection
	// [HTMLElement.hasStorageAccess()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/hasStorageAccess
	// [HTMLElement.importNode()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/importNode
	// [HTMLElement.prepend()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/prepend
	// [HTMLElement.querySelector()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/querySelector
	// [HTMLElement.querySelectorAll()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/querySelectorAll
	// [HTMLElement.releaseCapture()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/releaseCapture
	// [HTMLElement.releaseEvents()](Deprecated)
	// [HTMLElement.replaceChildren()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/replaceChildren
	// [HTMLElement.requestStorageAccess()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/requestStorageAccess
	// [HTMLElement.startViewTransition()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/startViewTransition
	// [HTMLElement.mozSetImageElement()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/mozSetImageElement
	// [HTMLElement.createExpression()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createExpression
	// [HTMLElement.createNSResolver()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/createNSResolver
	// [HTMLElement.evaluate()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/evaluate
		
	
	////// Extension for HTML documents //////
	// [HTMLElement.clear()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/clear
	// [HTMLElement.close()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/close
	// [HTMLElement.execCommand()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/execCommand
	// [HTMLElement.getElementsByName()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/getElementsByName
	// [HTMLElement.hasFocus()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/hasFocus
	// [HTMLElement.open()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/open
	// [HTMLElement.queryCommandEnabled()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/queryCommandEnabled
	// [HTMLElement.queryCommandIndeterm()](Deprecated)
	// [HTMLElement.queryCommandState()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/queryCommandState
	// [HTMLElement.queryCommandSupported()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/queryCommandSupported
	// [HTMLElement.queryCommandValue()](Deprecated)
	// [HTMLElement.write()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/write
	// [HTMLElement.writeln()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/writeln
		
	
	////// Events //////
	// [afterscriptexecute](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/afterscriptexecute_event
	// [beforescriptexecute](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/beforescriptexecute_event
	// [securitypolicyviolation]
	// [scroll] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/scroll_event
	// [visibilitychange] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/visibilitychange_event
	// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
		
	////// Animation events //////
	// [animationcancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationcancel_event
	// [animationend] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationend_event
	// [animationiteration] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationiteration_event
	// [animationstart] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationstart_event
		
	////// Clipboard events //////
	// [copy] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/copy_event
	// [cut] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/cut_event
	// [paste] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/paste_event
		
	////// Drag & drop events //////
	// [drag] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drag_event
	// [dragend] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragend_event
	// [dragenter] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragenter_event
	// [dragleave] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragleave_event
	// [dragover] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragover_event
	// [dragstart] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragstart_event
	// [drop] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drop_event
		
	////// Fullscreen events //////
	// [fullscreenchange] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/fullscreenchange_event
	// [fullscreenerror] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/fullscreenerror_event
		
	////// Keyboard events //////
	// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
	// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event
	// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
		
	////// Load & unload events //////
	// [DOMContentLoaded] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/DOMContentLoaded_event
	// [readystatechange] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/readystatechange_event
		
	////// Pointer events //////
	// [gotpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/Element/gotpointercapture_event
	// [lostpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/lostpointercapture_event
	// [pointercancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointercancel_event
	// [pointerdown] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerdown_event
	// [pointerenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerenter_event
	// [pointerleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerleave_event
	// [pointerlockchange] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/pointerlockchange_event
	// [pointerlockerror] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/pointerlockerror_event
	// [pointermove] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointermove_event
	// [pointerout] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerout_event
	// [pointerover] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerover_event
	// [pointerup] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerup_event
		
	////// Selection events //////
	// [selectionchange] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/selectionchange_event
		
	////// Touch events //////
	// [touchcancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/touchcancel_event
	// [touchend] https://developer.mozilla.org/en-US/docs/Web/API/Element/touchend_event
	// [touchmove] https://developer.mozilla.org/en-US/docs/Web/API/Element/touchmove_event
	// [touchstart] https://developer.mozilla.org/en-US/docs/Web/API/Element/touchstart_event
		
	////// Transition events //////
	// [transitioncancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitioncancel_event
	// [transitionend] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitionend_event
	// [transitionrun] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitionrun_event
	// [transitionstart] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitionstart_event
		
		
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLElement]" }
	
	
	return Node.call(this)
}
HTMLElement.prototype = Node.prototype
