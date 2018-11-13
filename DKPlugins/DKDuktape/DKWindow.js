var window;

//////////////////////////////
var Window = function(pointer)
{
	return EventTarget.call(this, pointer);
}
Window.prototype = EventTarget.prototype;

//Create the global window object
window = new Window("window");