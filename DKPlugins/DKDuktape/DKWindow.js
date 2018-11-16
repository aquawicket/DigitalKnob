function DKWindow_Init(){}

//////////////////////////////
var Window = function(pointer)
{
	return EventTarget.call(this, pointer);
}
Window.prototype = EventTarget.prototype;

//Create the global window object
var window = new Window("window");