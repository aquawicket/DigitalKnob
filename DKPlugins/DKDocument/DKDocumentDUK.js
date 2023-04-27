// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document


////// Constructor //////
// [Document()] https://developer.mozilla.org/en-US/docs/Web/API/Document/Document
var Document = function Document(address) {
	//console.log("Document("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKDocumentDUK();

	
	////// Instance properties //////
	// [Document.activeElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/activeElement
	Object.defineProperty(this, "activeElement", {
        get: function activeElement()					{ return CPP_DKDocumentDUK_activeElement(this.address) },
		//set: function activeElement(data)				{ return CPP_DKDocumentDUK_activeElement(this.address, data) },
    })
	// [Document.adoptedStyleSheets] https://developer.mozilla.org/en-US/docs/Web/API/Document/adoptedStyleSheets
	Object.defineProperty(this, "adoptedStyleSheets", {
        get: function adoptedStyleSheets()				{ return CPP_DKDocumentDUK_adoptedStyleSheets(this.address) },
		//set: function adoptedStyleSheets(data)		{ return CPP_DKDocumentDUK_adoptedStyleSheets(this.address, data) },
    })
	// [Document.body] https://developer.mozilla.org/en-US/docs/Web/API/Document/body
	Object.defineProperty(this, "body", {
        get: function body()							{ return CPP_DKDocumentDUK_body(this.address) },
		//set: function body(data)						{ return CPP_DKDocumentDUK_body(this.address, data) },
    })
	// [Document.characterSet](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
	Object.defineProperty(this, "characterSet", {
        get: function characterSet()					{ return CPP_DKDocumentDUK_characterSet(this.address) },
		//set: function characterSet(data)				{ return CPP_DKDocumentDUK_characterSet(this.address, data) },
    })
	// [Document.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/childElementCount
	Object.defineProperty(this, "childElementCount", {
        get: function childElementCount()				{ return CPP_DKDocumentDUK_childElementCount(this.address) },
		//set: function childElementCount(data)			{ return CPP_DKDocumentDUK_childElementCount(this.address, data) },
    })
	// [Document.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/children
	Object.defineProperty(this, "children", {
        get: function children()						{ return CPP_DKDocumentDUK_children(this.address) },
		//set: function children(data)					{ return CPP_DKDocumentDUK_children(this.address, data) },
    })
	// [Document.compatMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/compatMode
	Object.defineProperty(this, "compatMode", {
        get: function compatMode()						{ return CPP_DKDocumentDUK_compatMode(this.address) },
		//set: function compatMode(data)				{ return CPP_DKDocumentDUK_compatMode(this.address, data) },
    })
	// [Document.contentType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/contentType
	Object.defineProperty(this, "contentType", {
        get: function contentType()						{ return CPP_DKDocumentDUK_contentType(this.address) },
		//set: function contentType(data)				{ return CPP_DKDocumentDUK_contentType(this.address, data) },
    })
	// [Document.currentScript](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/currentScript
	Object.defineProperty(this, "currentScript", {
        get: function currentScript()					{ return CPP_DKDocumentDUK_currentScript(this.address) },
		//set: function currentScript(data)				{ return CPP_DKDocumentDUK_currentScript(this.address, data) },
    })
	// [Document.doctype](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/doctype
	Object.defineProperty(this, "doctype", {
        get: function doctype()							{ return CPP_DKDocumentDUK_doctype(this.address) },
		//set: function doctype(data)					{ return CPP_DKDocumentDUK_doctype(this.address, data) },
    })
	// [Document.documentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentElement
	Object.defineProperty(this, "documentElement", {
        get: function documentElement()					{ return CPP_DKDocumentDUK_documentElement(this.address) },
		//set: function documentElement(data)			{ return CPP_DKDocumentDUK_documentElement(this.address, data) },
    })
	// [Document.documentURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentURI
	Object.defineProperty(this, "documentURI", {
        get: function documentURI()						{ return CPP_DKDocumentDUK_documentURI(this.address) },
		//set: function documentURI(data)				{ return CPP_DKDocumentDUK_documentURI(this.address, data) },
    })
	// [Document.embeds](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/embeds
	Object.defineProperty(this, "embeds", {
        get: function embeds()							{ return CPP_DKDocumentDUK_embeds(this.address) },
		//set: function embeds(data)					{ return CPP_DKDocumentDUK_embeds(this.address, data) },
    })
	// [Document.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/firstElementChild
	Object.defineProperty(this, "firstElementChild", {
        get: function firstElementChild()				{ return CPP_DKDocumentDUK_firstElementChild(this.address) },
		//set: function firstElementChild(data)			{ return CPP_DKDocumentDUK_firstElementChild(this.address, data) },
    })
	// [Document.fonts] https://developer.mozilla.org/en-US/docs/Web/API/Document/fonts
	Object.defineProperty(this, "fonts", {
        get: function fonts()							{ return CPP_DKDocumentDUK_fonts(this.address) },
		//set: function fonts(data)						{ return CPP_DKDocumentDUK_fonts(this.address, data) },
    })
	// [Document.forms](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/forms
	Object.defineProperty(this, "forms", {
        get: function forms()							{ return CPP_DKDocumentDUK_forms(this.address) },
		//set: function forms(data)						{ return CPP_DKDocumentDUK_forms(this.address, data) },
    })
	// [Document.fragmentDirective](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Document/fragmentDirective
	Object.defineProperty(this, "fragmentDirective", {
        get: function fragmentDirective()				{ return CPP_DKDocumentDUK_fragmentDirective(this.address) },
		//set: function fragmentDirective(data)			{ return CPP_DKDocumentDUK_fragmentDirective(this.address, data) },
    })
	// [Document.fullscreenElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenElement
	Object.defineProperty(this, "fullscreenElement", {
        get: function fullscreenElement()				{ return CPP_DKDocumentDUK_fullscreenElement(this.address) },
		//set: function fullscreenElement(data)			{ return CPP_DKDocumentDUK_fullscreenElement(this.address, data) },
    })
	// [Document.head](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/head
	Object.defineProperty(this, "head", {
        get: function head()							{ return CPP_DKDocumentDUK_head(this.address) },
		//set: function head(data)						{ return CPP_DKDocumentDUK_head(this.address, data) },
    })
	// [Document.hidden](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/hidden
	Object.defineProperty(this, "hidden", {
        get: function hidden()							{ return CPP_DKDocumentDUK_hidden(this.address) },
		//set: function hidden(data)					{ return CPP_DKDocumentDUK_hidden(this.address, data) },
    })
	// [Document.images](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/images
	Object.defineProperty(this, "images", {
        get: function images()							{ return CPP_DKDocumentDUK_images(this.address) },
		//set: function images(data)					{ return CPP_DKDocumentDUK_images(this.address, data) },
    })
	// [Document.implementation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/implementation
	Object.defineProperty(this, "implementation", {
        get: function implementation()					{ return CPP_DKDocumentDUK_implementation(this.address) },
		//set: function implementation(data)			{ return CPP_DKDocumentDUK_implementation(this.address, data) },
    })
	// [Document.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastElementChild
	Object.defineProperty(this, "lastElementChild", {
        get: function lastElementChild()				{ return CPP_DKDocumentDUK_lastElementChild(this.address) },
		//set: function lastElementChild(data)			{ return CPP_DKDocumentDUK_lastElementChild(this.address, data) },
    })
	// [Document.links](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/links
	Object.defineProperty(this, "links", {
        get: function links()							{ return CPP_DKDocumentDUK_links(this.address) },
		//set: function links(data)						{ return CPP_DKDocumentDUK_links(this.address, data) },
    })
	// [Document.pictureInPictureElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureElement
	Object.defineProperty(this, "pictureInPictureElement", {
        get: function pictureInPictureElement()			{ return CPP_DKDocumentDUK_pictureInPictureElement(this.address) },
		//set: function pictureInPictureElement(data)	{ return CPP_DKDocumentDUK_pictureInPictureElement(this.address, data) },
    })
	// [Document.pictureInPictureEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureEnabled
	Object.defineProperty(this, "pictureInPictureEnabled", {
        get: function pictureInPictureEnabled()			{ return CPP_DKDocumentDUK_pictureInPictureEnabled(this.address) },
		//set: function pictureInPictureEnabled(data)	{ return CPP_DKDocumentDUK_pictureInPictureEnabled(this.address, data) },
    })
	// [Document.plugins](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/plugins
	Object.defineProperty(this, "plugins", {
        get: function plugins()							{ return CPP_DKDocumentDUK_plugins(this.address) },
		//set: function plugins(data)					{ return CPP_DKDocumentDUK_plugins(this.address, data) },
    })
	// [Document.pointerLockElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pointerLockElement
	Object.defineProperty(this, "pointerLockElement", {
        get: function pointerLockElement()				{ return CPP_DKDocumentDUK_pointerLockElement(this.address) },
		//set: function pointerLockElement(data)		{ return CPP_DKDocumentDUK_pointerLockElement(this.address, data) },
    })
	// [Document.featurePolicy Experimental](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/featurePolicy
	Object.defineProperty(this, "featurePolicy", {
        get: function featurePolicy()					{ return CPP_DKDocumentDUK_featurePolicy(this.address) },
		//set: function featurePolicy(data)				{ return CPP_DKDocumentDUK_featurePolicy(this.address, data) },
    })
	// [Document.scripts](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scripts
	Object.defineProperty(this, "scripts", {
        get: function scripts()							{ return CPP_DKDocumentDUK_scripts(this.address) },
		//set: function scripts(data)					{ return CPP_DKDocumentDUK_scripts(this.address, data) },
    })
	// [Document.scrollingElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scrollingElement
	Object.defineProperty(this, "scrollingElement", {
        get: function scrollingElement()				{ return CPP_DKDocumentDUK_scrollingElement(this.address) },
		//set: function scrollingElement(data)			{ return CPP_DKDocumentDUK_scrollingElement(this.address, data) },
    })
	// [Document.styleSheets](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/styleSheets
	Object.defineProperty(this, "styleSheets", {
        get: function styleSheets()						{ return CPP_DKDocumentDUK_styleSheets(this.address) },
		//set: function styleSheets(data)				{ return CPP_DKDocumentDUK_styleSheets(this.address, data) },
    })
	// [Document.timeline](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/timeline
	Object.defineProperty(this, "timeline", {
        get: function timeline()						{ return CPP_DKDocumentDUK_timeline(this.address) },
		//set: function timeline(data)					{ return CPP_DKDocumentDUK_timeline(this.address, data) },
    })
	// [Document.visibilityState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/visibilityState
	Object.defineProperty(this, "visibilityState", {
        get: function visibilityState()					{ return CPP_DKDocumentDUK_visibilityState(this.address) },
		//set: function visibilityState(data)			{ return CPP_DKDocumentDUK_visibilityState(this.address, data) },
    })
	
	
	////// Extensions for HTMLDocument //////
	// [Document.cookie] https://developer.mozilla.org/en-US/docs/Web/API/Document/cookie
	// [Document.defaultView](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/defaultView
	// [Document.designMode] https://developer.mozilla.org/en-US/docs/Web/API/Document/designMode
	// [Document.dir] https://developer.mozilla.org/en-US/docs/Web/API/Document/dir
	// [Document.domain](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/domain
	// [Document.fullscreenEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenEnabled
	// [Document.lastModified](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastModified
	// [Document.location](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/location
	// [Document.readyState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/readyState
	// [Document.referrer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/referrer
	// [Document.title] https://developer.mozilla.org/en-US/docs/Web/API/Document/title
	// [Document.URL](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/URL
		
	
	////// Deprecated properties //////
	// [Document.alinkColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/alinkColor
	// [Document.all](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/all
	// [Document.anchors](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/anchors
	// [Document.applets](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/applets
	// [Document.bgColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/bgColor
	// [Document.charset](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
	// [Document.fgColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/fgColor
	// [Document.fullscreen](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreen
	// [Document.height](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientHeight
	// [Document.inputEncoding](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
	// [Document.lastStyleSheetSet](Deprecated)(Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastStyleSheetSet
	// [Document.linkColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/linkColor
	// [Document.preferredStyleSheetSet](Deprecated)(Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/preferredStyleSheetSet
	// [Document.rootElement](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/rootElement
	// [Document.selectedStyleSheetSet](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/selectedStyleSheetSet
	// [Document.styleSheetSets](Deprecated)(Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/styleSheetSets
	// [Document.vlinkColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/vlinkColor
	// [Document.width](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientWidth
	// [Document.xmlEncoding](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/xmlEncoding
	// [Document.xmlStandalone](Deprecated)
	// [Document.xmlVersion](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/xmlVersion
		
	
	////// Instance methods //////
	// [Document.adoptNode()] https://developer.mozilla.org/en-US/docs/Web/API/Document/adoptNode
	// [Document.append()] https://developer.mozilla.org/en-US/docs/Web/API/Document/append
	// [Document.captureEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/caretPositionFromPoint
	// [Document.caretPositionFromPoint()] https://developer.mozilla.org/en-US/docs/Web/API/Document/caretPositionFromPoint
	// [Document.caretRangeFromPoint()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/caretRangeFromPoint
	// [Document.createAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createAttribute
	// [Document.createAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createAttributeNS
	// [Document.createCDATASection()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createCDATASection
	// [Document.createComment()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createComment
	// [Document.createDocumentFragment()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createDocumentFragment
	// [Document.createElement()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createElement
	// [Document.createElementNS()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createElementNS
	// [Document.createEntityReference()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document
	// [Document.createEvent()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createEvent
	// [Document.createNodeIterator()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createNodeIterator
	// [Document.createProcessingInstruction()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createProcessingInstruction
	// [Document.createRange()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createRange
	// [Document.createTextNode()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createTextNode
	// [Document.createTouch()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/createTouch
	// [Document.createTouchList()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/createTouchList
	// [Document.createTreeWalker()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createTreeWalker
	// [Document.elementFromPoint()] https://developer.mozilla.org/en-US/docs/Web/API/Document/elementFromPoint
	// [Document.elementsFromPoint()] https://developer.mozilla.org/en-US/docs/Web/API/Document/elementsFromPoint
	// [Document.enableStyleSheetsForSet()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/enableStyleSheetsForSet
	// [Document.exitFullscreen()] https://developer.mozilla.org/en-US/docs/Web/API/Document/exitFullscreen
	// [Document.exitPictureInPicture()] https://developer.mozilla.org/en-US/docs/Web/API/Document/exitPictureInPicture
	// [Document.exitPointerLock()] https://developer.mozilla.org/en-US/docs/Web/API/Document/exitPointerLock
	// [Document.getAnimations()] https://developer.mozilla.org/en-US/docs/Web/API/Document/getAnimations
	// [Document.getBoxQuads()](Experimental)
	// [Document.getElementById()] https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementById
	// [Document.getElementsByClassName()] https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByClassName
	// [Document.getElementsByTagName()] https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByTagName
	// [Document.getElementsByTagNameNS()] https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByTagNameNS
	// [Document.getSelection()] https://developer.mozilla.org/en-US/docs/Web/API/Document/getSelection
	// [Document.hasStorageAccess()] https://developer.mozilla.org/en-US/docs/Web/API/Document/hasStorageAccess
	// [Document.importNode()] https://developer.mozilla.org/en-US/docs/Web/API/Document/importNode
	// [Document.prepend()] https://developer.mozilla.org/en-US/docs/Web/API/Document/prepend
	// [Document.querySelector()] https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector
	// [Document.querySelectorAll()] https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll
	// [Document.releaseCapture()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/releaseCapture
	// [Document.releaseEvents()](Deprecated)
	// [Document.replaceChildren()] https://developer.mozilla.org/en-US/docs/Web/API/Document/replaceChildren
	// [Document.requestStorageAccess()] https://developer.mozilla.org/en-US/docs/Web/API/Document/requestStorageAccess
	// [Document.startViewTransition()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Document/startViewTransition
	// [Document.mozSetImageElement()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/mozSetImageElement
	// [Document.createExpression()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createExpression
	// [Document.createNSResolver()] https://developer.mozilla.org/en-US/docs/Web/API/Document/createNSResolver
	// [Document.evaluate()] https://developer.mozilla.org/en-US/docs/Web/API/Document/evaluate
		
	
	////// Extension for HTML documents //////
	// [Document.clear()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/clear
	// [Document.close()] https://developer.mozilla.org/en-US/docs/Web/API/Document/close
	// [Document.execCommand()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/execCommand
	// [Document.getElementsByName()] https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByName
	// [Document.hasFocus()] https://developer.mozilla.org/en-US/docs/Web/API/Document/hasFocus
	// [Document.open()] https://developer.mozilla.org/en-US/docs/Web/API/Document/open
	// [Document.queryCommandEnabled()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/queryCommandEnabled
	// [Document.queryCommandIndeterm()](Deprecated)
	// [Document.queryCommandState()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/queryCommandState
	// [Document.queryCommandSupported()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/queryCommandSupported
	// [Document.queryCommandValue()](Deprecated)
	// [Document.write()] https://developer.mozilla.org/en-US/docs/Web/API/Document/write
	// [Document.writeln()] https://developer.mozilla.org/en-US/docs/Web/API/Document/writeln
		
	
	////// Events //////
	// [afterscriptexecute](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/afterscriptexecute_event
	// [beforescriptexecute](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/beforescriptexecute_event
	// [securitypolicyviolation]
	// [scroll] https://developer.mozilla.org/en-US/docs/Web/API/Document/scroll_event
	// [visibilitychange] https://developer.mozilla.org/en-US/docs/Web/API/Document/visibilitychange_event
	// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
		
	////// Animation events //////
	// [animationcancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationcancel_event
	// [animationend] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationend_event
	// [animationiteration] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationiteration_event
	// [animationstart] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationstart_event
		
	////// Clipboard events //////
	// [copy] https://developer.mozilla.org/en-US/docs/Web/API/Document/copy_event
	// [cut] https://developer.mozilla.org/en-US/docs/Web/API/Document/cut_event
	// [paste] https://developer.mozilla.org/en-US/docs/Web/API/Document/paste_event
		
	////// Drag & drop events //////
	// [drag] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drag_event
	// [dragend] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragend_event
	// [dragenter] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragenter_event
	// [dragleave] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragleave_event
	// [dragover] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragover_event
	// [dragstart] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragstart_event
	// [drop] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drop_event
		
	////// Fullscreen events //////
	// [fullscreenchange] https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenchange_event
	// [fullscreenerror] https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenerror_event
		
	////// Keyboard events //////
	// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
	// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event
	// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
		
	////// Load & unload events //////
	// [DOMContentLoaded] https://developer.mozilla.org/en-US/docs/Web/API/Document/DOMContentLoaded_event
	// [readystatechange] https://developer.mozilla.org/en-US/docs/Web/API/Document/readystatechange_event
		
	////// Pointer events //////
	// [gotpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/Element/gotpointercapture_event
	// [lostpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/Document/lostpointercapture_event
	// [pointercancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointercancel_event
	// [pointerdown] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerdown_event
	// [pointerenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerenter_event
	// [pointerleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerleave_event
	// [pointerlockchange] https://developer.mozilla.org/en-US/docs/Web/API/Document/pointerlockchange_event
	// [pointerlockerror] https://developer.mozilla.org/en-US/docs/Web/API/Document/pointerlockerror_event
	// [pointermove] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointermove_event
	// [pointerout] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerout_event
	// [pointerover] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerover_event
	// [pointerup] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerup_event
		
	////// Selection events //////
	// [selectionchange] https://developer.mozilla.org/en-US/docs/Web/API/Document/selectionchange_event
		
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
		this.toString = function(){	return "[object Document]" }
	
	
	return Node.call(this, this.address)
}
Document.prototype = Node.prototype
