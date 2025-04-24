/*
 * outerHTML.js
 *   Cross-browser full HTMLElement.outerHTML implementation.
 *
 * 2011-11-14
 *
 * By Eli Grey, http://eligrey.com
 * Public Domain.
 * NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.
 */

<<<<<<< HEAD:DKPlugins/DKDom/outerHTML.js
if (typeof document !== "undefined" && !("outerHTML" in document.createElementNS("http://www.w3.org/1999/xhtml", "_"))) {

(function(view) {
=======
if (typeof document !== "undefined" && !("outerHTML" in document.createElementNS("http://www.w3.org/1999/xhtml", "_"))){

(function(view){
>>>>>>> Development:DKCpp/plugins/DKDom/outerHTML.js
"use strict";

var
	  container = document.createElementNS("http://www.w3.org/1999/xhtml", "_")
	, elem_proto = (view.HTMLElement || view.Element).prototype
	, xml_serializer = new XMLSerializer
<<<<<<< HEAD:DKPlugins/DKDom/outerHTML.js
	, outerHTML_getter = function outerHTML_getter() {
=======
	, outerHTML_getter = function outerHTML_getter(){
>>>>>>> Development:DKCpp/plugins/DKDom/outerHTML.js
		var
			  node = this
			, html
		;
<<<<<<< HEAD:DKPlugins/DKDom/outerHTML.js
		if (document.xmlVersion) {
=======
		if (document.xmlVersion){
>>>>>>> Development:DKCpp/plugins/DKDom/outerHTML.js
			return xml_serializer.serializeToString(node);
		} else {
			container.appendChild(node.cloneNode(false));
			html = container.innerHTML.replace("><", ">" + node.innerHTML + "<");
			container.innerHTML = "";
			return html;
		}
	}
<<<<<<< HEAD:DKPlugins/DKDom/outerHTML.js
	, outerHTML_setter = function outerHTML_setter(html) {
=======
	, outerHTML_setter = function outerHTML_setter(html){
>>>>>>> Development:DKCpp/plugins/DKDom/outerHTML.js
		var
			  node = this
			, parent = node.parentNode
			, child
		;
<<<<<<< HEAD:DKPlugins/DKDom/outerHTML.js
		if (parent === null) {
=======
		if (parent === null){
>>>>>>> Development:DKCpp/plugins/DKDom/outerHTML.js
			DOMException.code = DOMException.NOT_FOUND_ERR;
			throw DOMException;
		}
		container.innerHTML = html;
<<<<<<< HEAD:DKPlugins/DKDom/outerHTML.js
		while ((child = container.firstChild)) {
=======
		while ((child = container.firstChild)){
>>>>>>> Development:DKCpp/plugins/DKDom/outerHTML.js
			parent.insertBefore(child, node);
		}
		parent.removeChild(node);
	}
;

<<<<<<< HEAD:DKPlugins/DKDom/outerHTML.js
if (Object.defineProperty) {
=======
if (Object.defineProperty){
>>>>>>> Development:DKCpp/plugins/DKDom/outerHTML.js
	var outerHTML_prop_desc = {
		  get: outerHTML_getter
		, set: outerHTML_setter
		, enumerable: true
		, configurable: true
	};
	try {
		Object.defineProperty(elem_proto, "outerHTML", outerHTML_prop_desc);
<<<<<<< HEAD:DKPlugins/DKDom/outerHTML.js
	} catch (ex) { // IE 8 doesn't support enumerable:true
		if (ex.number === -0x7FF5EC54) {
=======
	} catch (ex){ // IE 8 doesn't support enumerable:true
		if (ex.number === -0x7FF5EC54){
>>>>>>> Development:DKCpp/plugins/DKDom/outerHTML.js
			outerHTML_prop_desc.enumerable = false;
			Object.defineProperty(elem_proto, "outerHTML", outerHTML_prop_desc);
		}
	}
<<<<<<< HEAD:DKPlugins/DKDom/outerHTML.js
} else if (Object.prototype.__defineGetter__ && Object.prototype.__defineSetter__) {
=======
} else if (Object.prototype.__defineGetter__ && Object.prototype.__defineSetter__){
>>>>>>> Development:DKCpp/plugins/DKDom/outerHTML.js
	elem_proto.__defineGetter__("outerHTML", outerHTML_getter);
	elem_proto.__defineSetter__("outerHTML", outerHTML_setter);
}

}(self));

}