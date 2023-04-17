#pragma once
#ifndef DKDocument_H
#define DKDocument_H

#include "DKNode/DKNode.h"


// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
class DKDocument : public DKNode
{
public:
	////// Constructor //////
	// [Document()] https://developer.mozilla.org/en-US/docs/Web/API/Document/Document
	DKDocument() : DKNode() {
		DKDEBUGFUNC();
		eventTargetClass = "Document";
		eventTargetAddress = pointerToAddress(this);
		
		
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
	}
	
	
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
};


#endif //DKDocument_H