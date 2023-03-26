#include <iostream>
#include <functional>
#include <string>
#include <vector>



class DKEvent
{
public:
	DKEvent(std::string _type, void* _pointer) {
		type = _type;
		pointer = _pointer;
	}
	
	std::string type;
	void* pointer;
};


struct Event {
	std::string type;
	std::function<void(DKEvent)> listener;
	void* pointer;
};

class DKEventTarget
{
public:
	static void addEventListener(std::string type, std::function<void(DKEvent)> listener, void* pointer){
		Event event;
		event.type = type;
		event.listener = listener;
		event.pointer = pointer;
		events.push_back(event);
	}
	static void dispatchEvent(DKEvent event){
		for (unsigned int n = 0; n < events.size(); ++n) {
			if (event.type == events[n].type && event.pointer == events[n].pointer) {
				events[n].listener(event);
			}
		}
	}
	
	static std::vector<Event> events;
};
std::vector<Event> DKEventTarget::events;


class DKKeyboardEvent : public DKEvent
{
public:
	DKKeyboardEvent(std::string _type, void* _pointer) : DKEvent(_type, _pointer) {
		key = "random key";
	}
	
	std::string key;
};



class App
{
public:
	static void onGenericEvent(DKEvent event) {
		printf("event.type = %s \n", event.type.c_str());
	}
	
	static void onKeyDown(DKKeyboardEvent event) {
		printf("event.type = %s \n", event.type.c_str());
		printf("event.key = %s \n", event.key.c_str());
	}
};



int main() {
	App* app = new App();
	DKEventTarget::addEventListener("generic", &App::onGenericEvent, app);
	DKEvent event("generic", app);
	DKEventTarget::dispatchEvent(event);
	
	/*
	DKEventTarget::addEventListener("keydown", &App::onKeyDown, app);
	DKKeyboardEvent keyEvent("keydown", app);							
	DKEventTarget::dispatchEvent(keyEvent);
	*/
}