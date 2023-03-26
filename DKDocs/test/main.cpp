// std::function: cannot convert derived class parameter to base class parameter
//
// I'm attempting to mimic javascript style Event/EventTarget operations in c++
// I have a Event base class that works as needed, and a KeyboardEvent class that inherits from Event
// My EventTarget.addEventListener function stores EventObjects in a vector that can be called with dispatchEvent,
// I am able to use addEventListener to store callback functions using a 'Event' parameter:   i.e. onGenericEvent(Event event)
// However, I am unable to use addEventListener to add callback functions that take a 'KeyboardEvent' parameter:  i.e. onKeyDown(KeyboardEvent event)
// I was expecting std::function<void(Event)> to accept 'KeyboardEvent' since it inherits from Event but I recieve a compilation error:
// ERROR: cannot convert 'void (*)(KeyboardEvent)' to std::function<void(Event)>'
// How sould I proceed. Thanks


#include <iostream>
#include <functional>
#include <string>
#include <vector>


class Event {
public:
	Event(std::string _type, void* _pointer) {
		type = _type;
		pointer = _pointer;
	}
	std::string type;
	void* pointer;
};


struct EventObject {
	std::string type;
	std::function<void(Event)> listener;
	void* pointer;
};

class EventTarget {
public:
	static void addEventListener(std::string type, std::function<void(Event)> listener, void* pointer){
		EventObject eventObj;
		eventObj.type = type;
		eventObj.listener = listener;
		eventObj.pointer = pointer;
		events.push_back(eventObj);
	}
	static void dispatchEvent(Event event){
		for (unsigned int n = 0; n < events.size(); ++n) {
			if (event.type == events[n].type && event.pointer == events[n].pointer) {
				events[n].listener(event);
			}
		}
	}
	static std::vector<EventObject> events;
};
std::vector<EventObject> EventTarget::events;


class KeyboardEvent : public Event {
public:
	KeyboardEvent(std::string _type, void* _pointer) : Event(_type, _pointer) {
		key = "random key";
	}
	std::string key;
};


class App
{
public:
	static void onGenericEvent(Event event) {
		printf("event.type = %s \n", event.type.c_str());
	}
	
	static void onKeyDown(KeyboardEvent event) {
		printf("event.type = %s \n", event.type.c_str());  // print Event class property
		printf("event.key = %s \n", event.key.c_str());    // print KeyboardEvent class property
	}
};


int main() {
	App* app = new App();
	
	EventTarget::addEventListener("generic", &App::onGenericEvent, app);
	Event event("generic", app);
	EventTarget::dispatchEvent(event); // simulate generic event
	
	//EventTarget::addEventListener("keydown", &App::onKeyDown, app);  //ERROR: cannot convert 'void (*)(KeyboardEvent)' to std::function<void(Event)>'
	KeyboardEvent keyEvent("keydown", app);							
	EventTarget::dispatchEvent(keyEvent);  // simulate keydown event
}