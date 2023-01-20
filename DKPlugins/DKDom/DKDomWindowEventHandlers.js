// https://developer.mozilla.org/en-US/docs/Web/API/WindowEventHandlers
// https://html.spec.whatwg.org/multipage/webappapis.html#windoweventhandlers
// https://javascript.info/mixins

//https://html.spec.whatwg.org/multipage/webappapis.html#windoweventhandlers
var WindowEventHandlers = function WindowEventHandlers(pointer)
{
    this.pointer = pointer
    this.afterprint_func = null
    Object.defineProperty(this, "onafterprint", {
        get: function onafterprint() {
            return this.afterprint_func
        },
        set: function onafterprint(func) {
            this.addEventListener("afterprint", func)
            this.afterprint_func = func
        }
    })
    this.beforeprint_func = null
    Object.defineProperty(this, "onbeforeprint", {
        get: function onbeforeprint() {
            return this.beforeprint_func
        },
        set: function onbeforeprint(func) {
            this.addEventListener("beforeprint", func)
            this.beforeprint_func = func
        }
    })
    this.beforeunload_func = null
    Object.defineProperty(this, "onbeforeunload", {
        get: function onbeforeunload() {
            return this.beforeunload_func
        },
        set: function onbeforeunload(func) {
            this.addEventListener("beforeunload", func)
            this.beforeunload_func = func
        }
    })
    this.hashchange_func = null
    Object.defineProperty(this, "onhashchange", {
        get: function onhashchange() {
            return this.hashchange_func
        },
        set: function onhashchange(func) {
            this.addEventListener("hashchange", func)
            this.hashchange_func = func
        }
    })
    this.languagechange_func = null
    Object.defineProperty(this, "onlanguagechange", {
        get: function onlanguagechange() {
            return this.languagechange_func
        },
        set: function onlanguagechange(func) {
            this.addEventListener("languagechange", func)
            this.languagechange_func = func
        }
    })
    this.message_func = null
    Object.defineProperty(this, "onmessage", {
        get: function onmessage() {
            return this.message_func
        },
        set: function onmessage(func) {
            this.addEventListener("message", func)
            this.message_func = func
        }
    })
    this.messageerror_func = null
    Object.defineProperty(this, "onmessageerror", {
        get: function onmessageerror() {
            return this.messageerror_func
        },
        set: function onmessageerror(func) {
            this.addEventListener("messageerror", func)
            this.messageerror_func = func
        }
    })
    this.offline_func = null
    Object.defineProperty(this, "onoffline", {
        get: function onoffline() {
            return this.offline_func
        },
        set: function onoffline(func) {
            this.addEventListener("offline", func)
            this.offline_func = func
        }
    })
    this.online_func = null
    Object.defineProperty(this, "ononline", {
        get: function ononline() {
            return this.online_func
        },
        set: function ononline(func) {
            this.addEventListener("online", func)
            this.online_func = func
        }
    })
    this.pagehide_func = null
    Object.defineProperty(this, "onpagehide", {
        get: function onpagehide() {
            return this.pagehide_func
        },
        set: function onpagehide(func) {
            this.addEventListener("pagehide", func)
            this.pagehide_func = func
        }
    })
    this.pageshow_func = null
    Object.defineProperty(this, "onpageshow", {
        get: function onpageshow() {
            return this.pageshow_func
        },
        set: function onpageshow(func) {
            this.addEventListener("pageshow", func)
            this.pageshow_func = func
        }
    })
    this.popstate_func = null
    Object.defineProperty(this, "onpopstate", {
        get: function onpopstate() {
            return this.popstate_func
        },
        set: function onpopstate(func) {
            this.addEventListener("popstate", func)
            this.popstate_func = func
        }
    })
    this.rejectionhandled_func = null
    Object.defineProperty(this, "onrejectionhandled", {
        get: function onrejectionhandled() {
            return this.rejectionhandled_func
        },
        set: function onrejectionhandled(func) {
            this.addEventListener("rejectionhandled", func)
            this.rejectionhandled_func = func
        }
    })
    this.storage_func = null
    Object.defineProperty(this, "onstorage", {
        get: function onstorage() {
            return this.storage_func
        },
        set: function onstorage(func) {
            this.addEventListener("storage", func)
            this.storage_func = func
        }
    })
    this.unhandledrejection_func = null
    Object.defineProperty(this, "onunhandledrejection", {
        get: function onunhandledrejection() {
            return this.unhandledrejection_func
        },
        set: function onunhandledrejection(func) {
            this.addEventListener("unhandledrejection", func)
            this.unhandledrejection_func = func
        }
    })
    this.unload_func = null
    Object.defineProperty(this, "onunload", {
        get: function onunload() {
            return this.unload_func
        },
        set: function onunload(func) {
            this.addEventListener("unload", func)
            this.unload_func = func
        }
    })
    return this
}
WindowEventHandlers.prototype = EventTarget.prototype
