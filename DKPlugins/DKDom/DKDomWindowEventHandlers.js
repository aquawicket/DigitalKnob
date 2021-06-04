//https://developer.mozilla.org/en-US/docs/Web/API/WindowEventHandlers
//https://javascript.info/mixins


var WindowEventHandlers = function(pointer) {
    this.pointer = pointer;

    this.afterprint_func = null;
    Object.defineProperty(this, "onafterprint", {
        get: function() {
            return this.afterprint_func;
        },
        set: function(func) {
            this.addEventListener("afterprint", func);
            this.afterprint_func = func
        }
    });
	this.beforeprint_func = null;
	Object.defineProperty(this, "onbeforeprint", {
	this.beforeunload_func = null;
	Object.defineProperty(this, "onbeforeunload", {
	this.hashchange_func = null;
	Object.defineProperty(this, "onhashchange", {
	this.languagechange_func = null;
	Object.defineProperty(this, "onlanguagechange", {
	this.message_func = null;
	Object.defineProperty(this, "onmessage", {
	this.messageerror_func = null;
	Object.defineProperty(this, "onmessageerror", {
	this.offline_func = null;
	Object.defineProperty(this, "onoffline", {
	this.online_func = null;
	Object.defineProperty(this, "ononline", {
	this.pagehide_func = null;
	Object.defineProperty(this, "onpagehide", {
	this.pageshow_func = null;
	Object.defineProperty(this, "onpageshow", {
	this.popstate_func = null;
	Object.defineProperty(this, "onpopstate", {
	this.rejectionhandled_func = null;
	Object.defineProperty(this, "onrejectionhandled", {
	this.storage_func = null;
	Object.defineProperty(this, "onstorage", {
	this.unhandledrejection_func = null;
	Object.defineProperty(this, "onunhandledrejection", {
	this.unload_func = null;
	Object.defineProperty(this, "onunload", {


    return this;
}
WindowEventHandlers.prototype = EventTarget.prototype;