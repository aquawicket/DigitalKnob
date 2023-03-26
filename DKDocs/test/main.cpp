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

template <typename EventType>
struct EventObject {
    std::string type;
    std::function<void(EventType)> listener;
    void* pointer;
};

class EventTarget {
public:
    template <typename EventType>
    static void addEventListener(std::string type, std::function<void(EventType)> listener, void* pointer){
        EventObject<EventType> eventObj;
        eventObj.type = type;
        eventObj.listener = listener;
        eventObj.pointer = pointer;
        events<EventType>.push_back(eventObj);
    }
    
    template <typename EventType>
    static void dispatchEvent(EventType event){
        for (auto& eventObj : events<EventType>) {
            eventObj.listener(event);
        }
    }
    
    template <typename EventType>
    static std::vector<EventObject<EventType>> events;
};

template <typename EventType>
std::vector<EventObject<EventType>> EventTarget::events;


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
    
    EventTarget::addEventListener<Event>("generic", &App::onGenericEvent, app);
    Event event("generic", app);
    EventTarget::dispatchEvent(event); // simulate generic event
    
    EventTarget::addEventListener<KeyboardEvent>("keydown", &App::onKeyDown, app);  //ERROR: cannot convert 'void (*)(KeyboardEvent)' to std::function<void(Event)>'
    KeyboardEvent keyEvent("keydown", app);                         
    EventTarget::dispatchEvent(keyEvent);  // simulate keydown event
}