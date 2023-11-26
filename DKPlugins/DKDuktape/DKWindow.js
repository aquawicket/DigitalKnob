//https://developer.mozilla.org/en-US/docs/Web/API/Window

var Window = function Window(pointer) {
    return EventTarget.call(this, pointer);
}
Window.prototype = EventTarget.prototype;

//Create the global window object
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
