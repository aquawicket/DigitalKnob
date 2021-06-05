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
		    get: function() {
            return this.beforeprint_func;
        },
        set: function(func) {
            this.addEventListener("beforeprint", func);
            this.beforeprint_func = func;
        }
    });
	this.beforeunload_func = null;
	Object.defineProperty(this, "onbeforeunload", {
		    get: function() {
            return this.beforeunload_func;
        },
        set: function(func) {
            this.addEventListener("beforeunload", func);
            this.beforeunload_func = func;
        }
    });
	this.hashchange_func = null;
	Object.defineProperty(this, "onhashchange", {
		    get: function() {
            return this.hashchange_func;
        },
        set: function(func) {
            this.addEventListener("hashchange", func);
            this.hashchange_func = func;
        }
    });
	this.languagechange_func = null;
	Object.defineProperty(this, "onlanguagechange", {
		    get: function() {
            return this.languagechange_func;
        },
        set: function(func) {
            this.addEventListener("languagechange", func);
            this.languagechange_func = func;
        }
    });
	this.message_func = null;
	Object.defineProperty(this, "onmessage", {
		    get: function() {
            return this.message_func;
        },
        set: function(func) {
            this.addEventListener("message", func);
            this.message_func = func;
        }
    });
	this.messageerror_func = null;
	Object.defineProperty(this, "onmessageerror", {
		    get: function() {
            return this.messageerror_func;
        },
        set: function(func) {
            this.addEventListener("messageerror", func);
            this.messageerror_func = func;
        }
    });
	this.offline_func = null;
	Object.defineProperty(this, "onoffline", {
		    get: function() {
            return this.offline_func;
        },
        set: function(func) {
            this.addEventListener("offline", func);
            this.offline_func = func;
        }
    });
	this.online_func = null;
	Object.defineProperty(this, "ononline", {
		    get: function() {
            return this.online_func;
        },
        set: function(func) {
            this.addEventListener("online", func);
            this.online_func = func;
        }
    });
	this.pagehide_func = null;
	Object.defineProperty(this, "onpagehide", {
		    get: function() {
            return this.pagehide_func;
        },
        set: function(func) {
            this.addEventListener("pagehide", func);
            this.pagehide_func = func;
        }
    });
	this.pageshow_func = null;
	Object.defineProperty(this, "onpageshow", {
		    get: function() {
            return this.pageshow_func;
        },
        set: function(func) {
            this.addEventListener("pageshow", func);
            this.pageshow_func = func;
        }
    });
	this.popstate_func = null;
	Object.defineProperty(this, "onpopstate", {
		    get: function() {
            return this.popstate_func;
        },
        set: function(func) {
            this.addEventListener("popstate", func);
            this.popstate_func = func;
        }
    });
	this.rejectionhandled_func = null;
	Object.defineProperty(this, "onrejectionhandled", {
		    get: function() {
            return this.rejectionhandled_func;
        },
        set: function(func) {
            this.addEventListener("rejectionhandled", func);
            this.rejectionhandled_func = func;
        }
    });
	this.storage_func = null;
	Object.defineProperty(this, "onstorage", {
		    get: function() {
            return this.storage_func;
        },
        set: function(func) {
            this.addEventListener("storage", func);
            this.storage_func = func;
        }
    });
	this.unhandledrejection_func = null;
	Object.defineProperty(this, "onunhandledrejection", {
		    get: function() {
            return this.unhandledrejection_func;
        },
        set: function(func) {
            this.addEventListener("unhandledrejection", func);
            this.unhandledrejection_func = func;
        }
    });
	this.unload_func = null;
	Object.defineProperty(this, "onunload", {
		    get: function() {
            return this.unload_func;
        },
        set: function(func) {
            this.addEventListener("unload", func);
            this.unload_func = func;
        }
    });

    return this;
}
WindowEventHandlers.prototype = EventTarget.prototype;