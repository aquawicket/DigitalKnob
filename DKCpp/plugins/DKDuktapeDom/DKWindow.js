//https://developer.mozilla.org/en-US/docs/Web/API/Window

var Window = function Window(pointer){
    return EventTarget.call(this, pointer);
}
Window.prototype = EventTarget.prototype;

//Create the global window object
//var window = new Window("window");
//globalThis.window = window;
//globalThis = window;