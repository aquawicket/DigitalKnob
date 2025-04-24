//https://developer.mozilla.org/en-US/docs/Web/API/Window

<<<<<<< HEAD:DKPlugins/DKDuktape/DKWindow.js
var Window = function Window(pointer) {
=======
var Window = function Window(pointer){
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKWindow.js
    return EventTarget.call(this, pointer);
}
Window.prototype = EventTarget.prototype;

//Create the global window object
<<<<<<< HEAD:DKPlugins/DKDuktape/DKWindow.js
var window = new Window("window");

//Create the globalThis object
if (typeof globalThis === 'undefined') {
    (function () {
        var globalThis = new Function('return this;')();
        Object.defineProperty(globalThis, 'globalThis', {
            value: globalThis,
            writable: true,
            enumerable: false,
            configurable: true
        });
    })();
}

globalThis.window = window;
=======
//var window = new Window("window");
//globalThis.window = window;
//globalThis = window;
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKWindow.js
