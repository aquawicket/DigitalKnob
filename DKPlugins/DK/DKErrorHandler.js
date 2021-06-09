"use strict";
//https://stackoverflow.com/a/36317375/688352

dk.errorhandler = new DKErrorHandler();

function DKErrorHandler() {
    return DKPlugin.call(this, arguments)
}

DKErrorHandler.prototype.create = function dk_errorhandler_create() {
    // Capture error data for debugging in web console
    let captures = [];

    // Wait until `window.onload`, so any external scripts
    // you might load have a chance to set their own error handlers,
    // which we don't want to override.

    //window.addEventListener('load', onload);

    // Custom global function to standardize 
    // window.onerror so it works like you'd think.
    // @see http://www.quirksmode.org/dom/events/error.html

    window.onanyerror = window.onanyerror || onanyerrorx;

    //Hook up all error handlers after window loads.
    function LoadErrorHandlers() {
        handleGlobal();
        handleRejection();
        handleXMLHttp();
        handleImage();
        handleScript();

        //FIXME: This breaks removeEventListener for global objects and plugins
        //handleEvents();
    }

    //Handle global window events.
    function handleGlobal() {
        const onerrorx = window.onerror;
        window.addEventListener('error', onerror);
        function onerror(msg, url, line, col, err) {
            window.onanyerror.apply(this, arguments);
            if (err)
                dk.console.error(err);
            else if (msg.error)
                dk.console.error(msg.error);
            else
                dk.console.error(msg.message);
            if (onerrorx)
                return onerrorx.apply(null, arguments);
        }
    }

    //Handle Promise rejections  
    function handleRejection() {
        const onunhandledrejectionx = window.onunhandledrejection;
        window.addEventListener('unhandledrejection', onunhandledrejection);
        function onunhandledrejection(event) {
            window.onanyerror.apply(this, arguments);
            if (event.reason) {
                dk.console.error(event.reason);
            }
            if (onunhandledrejectionx)
                return onunhandledrejectionx.apply(null, arguments);
        }
    }
    //Handle ajax request errors.
    function handleXMLHttp() {
        const sendx = XMLHttpRequest.prototype.send;
        window.XMLHttpRequest.prototype.send = function window_XMLHttpRequest_prototype_send() {
            handleAsync(this);
            return sendx.apply(this, arguments);
        }
    }

    //Handle image errors.
    function handleImage() {
        const ImageOriginal = window.Image;
        window.Image = ImageOverride;

        // New `Image` constructor. Might cause some problems,
        // but not sure yet. This is at least a start, and works on chrome.
        function ImageOverride() {
            let img = new ImageOriginal;
            onnext(function onnext() {
                handleAsync(img);
            });
            return img;
        }
    }

    // Handle script errors.
    function handleScript() {
        const HTMLScriptElementOriginal = window.HTMLScriptElement;
        window.HTMLScriptElement = HTMLScriptElementOverride;

        // New `HTMLScriptElement` constructor.
        // Allows us to globally override onload.
        // Not ideal to override stuff, but it helps with debugging.
        function HTMLScriptElementOverride() {
            let script = new HTMLScriptElement;
            onnext(function onnext() {
                handleAsync(script);
            });
            return script;
        }
    }

    // Handle errors in events.
    // http://stackoverflow.com/questions/951791/javascript-global-error-handling/31750604#31750604
    function handleEvents() {
        const addEventListenerx = window.EventTarget.prototype.addEventListener;
        window.EventTarget.prototype.addEventListener = addEventListener;
        const removeEventListenerx = window.EventTarget.prototype.removeEventListener;
        window.EventTarget.prototype.removeEventListener = removeEventListener;

        function addEventListener(event, handler, bubble) {
            const handlerx = wrap(handler);
            return addEventListenerx.call(this, event, handlerx, bubble);
        }

        function removeEventListener(event, handler, bubble) {
            handler = handler._witherror || handler;
            removeEventListenerx.call(this, event, handler, bubble);
        }

        function wrap(fn) {
            fn._witherror = witherror;

            function witherror() {
                try {
                    fn.apply(this, arguments);
                } catch (e) {
                    window.onanyerror.apply(this, e);
                    throw e;
                }
            }
            return fn;
        }
    }

    //Handle image/ajax request errors generically
    function handleAsync(obj) {
        const onerrorx = obj.onerror;
        obj.onerror = onerror;
        const onabortx = obj.onabort;
        obj.onabort = onabort;
        const onloadx = obj.onload;
        obj.onload = onload;

        // Handle `onerror`.
        function onerror(error) {
            window.onanyerror.call(this, error);
            if (onerrorx)
                return onerrorx.apply(this, arguments);
        }

        // Handle `onabort`
        function onabort(error) {
            window.onanyerror.call(this, error);
            if (onabortx)
                return onabortx.apply(this, arguments);
        }

        // Handle `onload`.
        // For images, you can get a 403 response error,
        // but this isn't triggered as a global on error.
        // This sort of standardizes it.
        //
        // "there is no way to get the HTTP status from a 
        // request made by an img tag in JavaScript."
        // @see http://stackoverflow.com/questions/8108636/how-to-get-http-status-code-of-img-tags/8108646#8108646
        function onload(request) {
            if (request.status && request.status >= 400) {
                window.onanyerror.call(this, request);
            }
            if (onloadx)
                return onloadx.apply(this, arguments);
        }
    }

    // Generic error handler.
    // This shows the basic implementation, 
    // which you could override in your app.
    function onanyerrorx(entity) {
        const display = entity;

        // ajax request
        if (entity instanceof XMLHttpRequest) {
            // 400: http://example.com/image.png
            display = entity.status + ' ' + entity.responseURL;
        } else if (entity instanceof Event) {
            // global window events, or image events
            const target = entity.currentTarget;
            display = target;
        } else {// not sure if there are others
        }

        capture(entity);
        console.log('[onanyerror]', display, entity);
    }

    // Capture stuff for debugging purposes
    // Keep them in memory so you can reference them
    // in the chrome debugger as `onanyerror0` up to `onanyerror99`.
    function capture(entity) {
        captures.push(entity);
        if (captures.length > 100)
            captures.unshift();

        // keep the last ones around
        const i = captures.length;
        while (--i) {
            const x = captures[i];
            window['onanyerror' + i] = x;
        }
    }

    // Wait til next code execution cycle as fast as possible.
    function onnext(fn) {
        setTimeout(fn, 0);
    }

    window.onanyerror = function window_onanyerror(entity) {//console.debug(entity);
    }

    LoadErrorHandlers();
}
