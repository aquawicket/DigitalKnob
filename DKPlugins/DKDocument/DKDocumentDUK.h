#if HAVE_DKDuktape

#pragma once
#ifndef DKDocumentDUK_H
#define DKDocumentDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
class DKDocumentDUK : public DKObjectT<DKDocumentDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKDocumentDUK", DKDocumentDUK::constructor);		// [Document()] https://developer.mozilla.org/en-US/docs/Web/API/Document/Document
		
		
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_activeElement", 			DKDocumentDUK::activeElement);			// [Document.activeElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/activeElement
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_adoptedStyleSheets", 		DKDocumentDUK::adoptedStyleSheets);		// [Document.adoptedStyleSheets] https://developer.mozilla.org/en-US/docs/Web/API/Document/adoptedStyleSheets
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_body", 					DKDocumentDUK::body);					// [Document.body] https://developer.mozilla.org/en-US/docs/Web/API/Document/body
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_characterSet", 			DKDocumentDUK::characterSet);			// [Document.characterSet](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_childElementCount", 		DKDocumentDUK::childElementCount);		// [Document.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/childElementCount
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_children", 				DKDocumentDUK::children);				// [Document.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/children
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_compatMode", 				DKDocumentDUK::compatMode);				// [Document.compatMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/compatMode
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_contentType", 				DKDocumentDUK::contentType);			// [Document.contentType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/contentType
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_currentScript", 			DKDocumentDUK::currentScript);			// [Document.currentScript](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/currentScript
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_doctype", 					DKDocumentDUK::doctype);				// [Document.doctype](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/doctype
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_documentElement", 			DKDocumentDUK::documentElement);		// [Document.documentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentElement
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_documentURI", 				DKDocumentDUK::documentURI);			// [Document.documentURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentURI
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_embeds", 					DKDocumentDUK::embeds);					// [Document.embeds](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/embeds
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_firstElementChild", 		DKDocumentDUK::firstElementChild);		// [Document.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/firstElementChild
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_fonts", 					DKDocumentDUK::fonts);					// [Document.fonts] https://developer.mozilla.org/en-US/docs/Web/API/Document/fonts
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_forms", 					DKDocumentDUK::forms);					// [Document.forms](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/forms
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_fragmentDirective", 		DKDocumentDUK::fragmentDirective);		// [Document.fragmentDirective](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Document/fragmentDirective
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_fullscreenElement", 		DKDocumentDUK::fullscreenElement);		// [Document.fullscreenElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenElement
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_head", 					DKDocumentDUK::head);					// [Document.head](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/head
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_hidden", 					DKDocumentDUK::hidden);					// [Document.hidden](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/hidden
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_images", 					DKDocumentDUK::images);					// [Document.images](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/images
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_implementation", 			DKDocumentDUK::implementation);			// [Document.implementation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/implementation
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_lastElementChild", 		DKDocumentDUK::lastElementChild);		// [Document.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastElementChild
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_links", 					DKDocumentDUK::links);					// [Document.links](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/links
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_pictureInPictureElement", 	DKDocumentDUK::pictureInPictureElement);// [Document.pictureInPictureElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureElement
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_pictureInPictureEnabled", 	DKDocumentDUK::pictureInPictureEnabled);// [Document.pictureInPictureEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureEnabled
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_plugins", 					DKDocumentDUK::plugins);				// [Document.plugins](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/plugins
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_pointerLockElement", 		DKDocumentDUK::pointerLockElement);		// [Document.pointerLockElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pointerLockElement
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_featurePolicy", 			DKDocumentDUK::featurePolicy);			// [Document.featurePolicy](Experimental](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/featurePolicy
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_scripts", 					DKDocumentDUK::scripts);				// [Document.scripts](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scripts
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_scrollingElement", 		DKDocumentDUK::scrollingElement);		// [Document.scrollingElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scrollingElement
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_styleSheets", 				DKDocumentDUK::styleSheets);			// [Document.styleSheets](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/styleSheets
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_timeline", 				DKDocumentDUK::timeline);				// [Document.timeline](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/timeline
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_visibilityState", 			DKDocumentDUK::visibilityState);		// [Document.visibilityState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/visibilityState
	
		
		////// Extensions for HTMLDocument //////
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_cookie", 					DKDocumentDUK::cookie);					// [Document.cookie] https://developer.mozilla.org/en-US/docs/Web/API/Document/cookie
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_defaultView", 				DKDocumentDUK::defaultView);			// [Document.defaultView](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/defaultView
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_designMode", 				DKDocumentDUK::designMode);				// [Document.designMode] https://developer.mozilla.org/en-US/docs/Web/API/Document/designMode
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_dir", 						DKDocumentDUK::dir);					// [Document.dir] https://developer.mozilla.org/en-US/docs/Web/API/Document/dir
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_domain", 					DKDocumentDUK::domain);					// [Document.domain](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/domain
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_fullscreenEnabled", 		DKDocumentDUK::fullscreenEnabled);		// [Document.fullscreenEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenEnabled
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_lastModified", 			DKDocumentDUK::lastModified);			// [Document.lastModified](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastModified
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_location", 				DKDocumentDUK::location);				// [Document.location](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/location
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_readyState", 				DKDocumentDUK::readyState);				// [Document.readyState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/readyState
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_referrer", 				DKDocumentDUK::referrer);				// [Document.referrer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/referrer
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_title", 					DKDocumentDUK::title);					// [Document.title] https://developer.mozilla.org/en-US/docs/Web/API/Document/title
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_URL", 						DKDocumentDUK::URL);					// [Document.URL](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/URL
		
		
		////// Deprecated properties //////
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_alinkColor", 				DKDocumentDUK::alinkColor);				// [Document.alinkColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/alinkColor
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_all", 						DKDocumentDUK::all);					// [Document.all](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/all
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_anchors", 					DKDocumentDUK::anchors);				// [Document.anchors](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/anchors
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_applets", 					DKDocumentDUK::applets);				// [Document.applets](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/applets
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_bgColor", 					DKDocumentDUK::bgColor);				// [Document.bgColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/bgColor
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_charset", 					DKDocumentDUK::charset);				// [Document.charset](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_fgColor", 					DKDocumentDUK::fgColor);				// [Document.fgColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/fgColor
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_fullscreen", 				DKDocumentDUK::fullscreen);				// [Document.fullscreen](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreen
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_height", 					DKDocumentDUK::height);					// [Document.height](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientHeight
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_inputEncoding", 			DKDocumentDUK::inputEncoding);			// [Document.inputEncoding](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_lastStyleSheetSet", 		DKDocumentDUK::lastStyleSheetSet);		// [Document.lastStyleSheetSet](Deprecated)(Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastStyleSheetSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_linkColor", 				DKDocumentDUK::linkColor);				// [Document.linkColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/linkColor
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_preferredStyleSheetSet", 	DKDocumentDUK::preferredStyleSheetSet);	// [Document.preferredStyleSheetSet](Deprecated)(Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/preferredStyleSheetSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_rootElement", 				DKDocumentDUK::rootElement);			// [Document.rootElement](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/rootElement
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_selectedStyleSheetSet", 	DKDocumentDUK::selectedStyleSheetSet);	// [Document.selectedStyleSheetSet](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/selectedStyleSheetSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_styleSheetSets", 			DKDocumentDUK::styleSheetSets);			// [Document.styleSheetSets](Deprecated)(Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Document/styleSheetSets
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_vlinkColor", 				DKDocumentDUK::vlinkColor);				// [Document.vlinkColor](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/vlinkColor
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_width", 					DKDocumentDUK::width);					// [Document.width](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientWidth
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_xmlEncoding", 				DKDocumentDUK::xmlEncoding);			// [Document.xmlEncoding](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/xmlEncoding
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_xmlStandalone", 			DKDocumentDUK::xmlStandalone);			// [Document.xmlStandalone](Deprecated)
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_xmlVersion", 				DKDocumentDUK::xmlVersion);				// [Document.xmlVersion](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Document/xmlVersion
		
		
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
		
		
		////// Load .js files
		DKClass::DKCreate("DKDocument/DKDocumentDUK.js");
		
		return true;
	}
	
	static DKDocument* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKDocument*)addressToPointer(eventTargetAddress);
	}
	static bool GetBool(duk_context* ctx){
		if (duk_is_boolean(ctx, 1))
			return duk_to_boolean(ctx, 1);
		return false;
	}
	static double GetDouble(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_number(ctx, 1);
		return 0.0;
	}
	static int GetInt(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_int(ctx, 1);
		return 0;
	}
	static DKString GetString(duk_context* ctx){
		if (duk_is_string(ctx, 1))
			return duk_to_string(ctx, 1);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_uint(ctx, 1);
		return 0;
	}
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKDocumentDUK()\n");
		DKDocument* _document = new DKDocument();
		DKString eventTargetAddress = pointerToAddress(_document);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	////// Instance properties //////
	// [Document.activeElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/activeElement
	static int activeElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _activeElement = GetString(ctx);
		if(!eventTarget(ctx)->activeElement(_activeElement, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _activeElement);
		return true;
	}
	// [Document.adoptedStyleSheets] https://developer.mozilla.org/en-US/docs/Web/API/Document/adoptedStyleSheets
	static int adoptedStyleSheets(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _adoptedStyleSheets = GetString(ctx);
		if(!eventTarget(ctx)->adoptedStyleSheets(_adoptedStyleSheets, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _adoptedStyleSheets);
		return true;
	}
	// [Document.body] https://developer.mozilla.org/en-US/docs/Web/API/Document/body
	static int body(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _body = GetString(ctx);
		if(!eventTarget(ctx)->body(_body, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _body);
		return true;
	}
	// [Document.characterSet](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
	static int characterSet(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _characterSet = GetString(ctx);
		if(!eventTarget(ctx)->characterSet(_characterSet, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _characterSet);
		return true;
	}
	// [Document.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/childElementCount
	static int childElementCount(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _childElementCount = GetUint(ctx);
		if(!eventTarget(ctx)->childElementCount(_childElementCount, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _childElementCount);
		return true;
	}
	// [Document.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/children
	static int characterSet(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _children = GetString(ctx);
		if(!eventTarget(ctx)->children(_children, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _children);
		return true;
	}
	// [Document.compatMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/compatMode
	static int compatMode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _compatMode = GetString(ctx);
		if(!eventTarget(ctx)->compatMode(_compatMode, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _compatMode);
		return true;
	}
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
		
};
REGISTER_OBJECT(DKDocumentDUK, true)


#endif //DKDocumentDUK_H
#endif //HAVE_DKDuktape