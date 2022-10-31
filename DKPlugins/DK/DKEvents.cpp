#include "DK/stdafx.h"
#include "DKEvents.h"
#include "DKClass.h"

std::vector<DKEvents*> DKEvents::events;
std::vector<std::function<bool(const DKString&, const DKString&)> > DKEvents::reg_funcs;
std::vector<std::function<bool(const DKString&, const DKString&)> > DKEvents::unreg_funcs;
std::vector<std::function<bool(const DKString&, const DKString&, const DKString&)> > DKEvents::send_funcs;

bool DKEvents::AddEvent(const DKString& id, const DKString& type, std::function<bool(DKEvents*)> func, DKObject* object){
	//DKDEBUGFUNC(id, type, func, object);
	return DKEvents::AddEvent(id, type, "", func, object);
}

bool DKEvents::AddEvent(const DKString& id, const DKString& type, const DKString& jsreturn, std::function<bool(DKEvents*)> func, DKObject* object){
	//DKDEBUGFUNC(id, type, jsreturn, func, object);
	DKString _jsreturn = jsreturn;
	replace(_jsreturn, "() { [ecmascript code] }", ""); //remove  () { [ecmascript code] }
	if(id.empty())
		return DKERROR("("+id+","+type+","+_jsreturn+"): No Id Specified\n");
	if(type.empty())
		return DKERROR("("+id+","+type+","+_jsreturn+"): No Type Specified\n");
	DKEvents* event = new DKEvents;
	event->id = id;
	event->type = type;
	event->jsreturn = _jsreturn;
	event->object = object;
	event->event_func = func;
	for(unsigned int i = 0; i < events.size(); ++i){
		if(event == events[i]){
			DKWARN("Event already Exists, Re-registering. ("+id+" : "+type+" : "+_jsreturn+")\n.");
			events[i] = event;
			for(unsigned int nn=0; nn<reg_funcs.size(); ++nn)
				reg_funcs[nn](id, type); //External Reg Functions
			return true;
		}
	}
	events.push_back(event);
	for(unsigned int i=0; i<reg_funcs.size(); ++i)
		reg_funcs[i](id, type); //External Reg Functions
	return true;
}

bool DKEvents::SendEvent(const DKString& id, const DKString& type, const DKString& value){
	if(!same(id,"DKLog") && !same(type,"second") && !same(type,"mousemove")) //prevent looping messages
		//DKDEBUGFUNC(id, type, value);
	if(type.empty())
		return DKERROR("("+id+", ,"+value+"): No Type Specified \n");
	if(id.empty())
		return DKERROR("( ,"+type+","+value+"): No Id Specified \n");
	//call the function directly
	for(unsigned int i = 0; i < events.size(); ++i){
		if((same(events[i]->id, id)) && same(events[i]->type, type)){
			events[i]->data.clear();
			events[i]->data.push_back(value);
			events[i]->event_func(events[i]); //call the function linked to the event
			if(i < events.size())
				events[i]->data.clear(); //clear data after send
			if(!same(id,"window"))
				return true;
		}
	}
	for(unsigned int i=0; i<send_funcs.size(); ++i)
		send_funcs[i](id, type, value); //returns bool
	return true;
}

bool DKEvents::RemoveEvent(const DKString& id, const DKString& type, const DKString& jsreturn){
	DKDEBUGFUNC(id, type, jsreturn);
	DKString _jsreturn = jsreturn;
	replace(_jsreturn, "() { [ecmascript code] }", ""); //remove  () { [ecmascript code] }
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id, id) && same(events[i]->type, type) && same(events[i]->jsreturn, _jsreturn)){
			events.erase(events.begin()+i);
			//i--;
			return true; //This event should not exist twice.
		}
	}
	for(unsigned int i=0; i<unreg_funcs.size(); ++i)
		unreg_funcs[i](id, type); //returns bool
	return true;
}

bool DKEvents::RemoveEvents(const DKString& id, const DKString& type){
	DKDEBUGFUNC(id, type);
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id,id) && same(events[i]->type,type)){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

bool DKEvents::RemoveEvents(const DKString& variable){
	DKDEBUGFUNC(variable);
	//variable can be id or jsreturn
	DKString _variable = variable;
	replace(_variable, "() { [ecmascript code] }", ""); //remove  () { [ecmascript code] }
	for(unsigned int i=0; i < events.size(); ++i){
		if(same(events[i]->id, _variable) || same(events[i]->jsreturn, _variable)){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

bool DKEvents::RemoveEvents(DKObject* obj){
	DKDEBUGFUNC(obj);
	for(unsigned int i = 0; i < events.size(); ++i){
		if(events[i]->object == obj){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

DKString DKEvents::GetType(){
	//DKDEBUGRETURN(type);
	return type;
}

DKString DKEvents::GetJSReturn(){
	DKDEBUGRETURN(jsreturn);
	return jsreturn;
}

DKString DKEvents::GetId(){
	//DKDEBUGRETURN(id);
	return id;
}

DKString DKEvents::GetValue(){
	DKString value = toString(data, ",");
	DKDEBUGRETURN(value);
	return value;
}

DKString DKEvents::GetValue(int n){
	DKDEBUGRETURN(data[n]);
	return data[n];
}

int DKEvents::GetKeyNum(){
	if (data.size() < 1) {
		DKDEBUGRETURN(0);
		return 0;
	}
	DKDEBUGRETURN(toInt(data[0]));
	return toInt(data[0]);
}

bool DKEvents::RenameEventId(const DKString& oldID, const DKString& newID){
	DKDEBUGFUNC(oldID, newID);
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id, oldID))
			events[i]->id = newID;
	}
	return true;
}
