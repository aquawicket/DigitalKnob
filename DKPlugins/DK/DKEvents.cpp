#include "DK/stdafx.h"
#include "DKEvents.h"
#include "DKClass.h"

std::vector<DKEvents*> DKEvents::events;
std::vector<boost::function<bool (const DKString&, const DKString&)> > DKEvents::reg_funcs;
std::vector<boost::function<bool (const DKString&, const DKString&)> > DKEvents::unreg_funcs;
std::vector<boost::function<bool (const DKString&, const DKString&, const DKString&)> > DKEvents::send_funcs;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKEvents::AddEvent(const DKString& id, const DKString& type, boost::function<bool (DKEvents*)> func, DKObject* object)
{
	DKDEBUGFUNC(id, type, func, object);
	return DKEvents::AddEvent(id, type, "", func, object);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKEvents::AddEvent(const DKString& id, const DKString& type, const DKString& jsreturn, boost::function<bool (DKEvents*)> func, DKObject* object)
{
	DKDEBUGFUNC(id, type, jsreturn, func, object);
	DKString _jsreturn = jsreturn;
	replace(_jsreturn, "() { [ecmascript code] }", ""); //remove  () { [ecmascript code] }

	if(id.empty()){
		DKERROR("DKEvents::AddEvent("+id+","+type+","+_jsreturn+"): No Id Specified\n");
		return false;
	}
	if(type.empty()){
		DKERROR("DKEvents::AddEvent("+id+","+type+","+_jsreturn+"): No Type Specified\n");
		return false;
	}
	
	DKEvents* event = new DKEvents;
	event->id = id;
	event->type = type;
	event->jsreturn = _jsreturn;
	event->object = object;
	event->event_func = func;

	for(unsigned int i = 0; i < events.size(); ++i){
		if(event == events[i]){
			DKWARN("DKEvents::AddEvent(): Event Exists, Reregistering. ("+id+" : "+type+" : "+_jsreturn+")\n.");
			events[i] = event;
			//External Reg Functions
			for(unsigned int i=0; i<reg_funcs.size(); ++i){
				reg_funcs[i](id, type);
			}
			return true;
		}
	}

	events.push_back(event);

	//External Reg Functions
	for(unsigned int i=0; i<reg_funcs.size(); ++i){
		reg_funcs[i](id, type);
	}

	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////
bool DKEvents::SendEvent(const DKString& id, const DKString& type, const DKString& value)
{
	if(!same(id,"DKLog") && !same(type,"second") && !same(type,"mousemove")){ //prevent looping messages
		DKDEBUGFUNC(id, type, value);
	}

	if(type.empty()){
		DKERROR("DKEvents::SendEvent("+id+","+type+","+value+"): No Type Specified \n");
		return false;
	}
	if(id.empty()){
		DKERROR("DKEvents::SendEvent("+id+","+type+","+value+"): No Id Specified \n");
		return false;
	}

	//call the function directly
	for(unsigned int i = 0; i < events.size(); ++i){
		if((same(events[i]->id, id)) && same(events[i]->type, type)){
			events[i]->data.clear();
			events[i]->data.push_back(value);
			events[i]->event_func(events[i]); //call the function linked to the event
			if(i < events.size()){ 
				events[i]->data.clear(); //clear data after send
			}
			if(!same(id,"window")){ return true; }
		}
	}

	//External Send Functions
	for(unsigned int i=0; i<send_funcs.size(); ++i){
		send_funcs[i](id, type, value); //returns bool
	}

	return false;
}

//////////////////////////////////////////////////////////////////////////////////////////////
bool DKEvents::RemoveEvent(const DKString& id, const DKString& type, const DKString& jsreturn)
{
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

	//External Reg Functions
	for(unsigned int i=0; i<unreg_funcs.size(); ++i){
		unreg_funcs[i](id, type); //returns bool
	}
	return true;
}

/////////////////////////////////////////////////////////////////////
bool DKEvents::RemoveEvents(const DKString& id, const DKString& type)
{
	DKDEBUGFUNC(id, type);
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id,id) && same(events[i]->type,type)){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

/////////////////////////////////////////////////////
bool DKEvents::RemoveEvents(const DKString& variable)
{
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

//////////////////////////////////////////
bool DKEvents::RemoveEvents(DKObject* obj)
{
	DKDEBUGFUNC(obj);
	for(unsigned int i = 0; i < events.size(); ++i){
		if(events[i]->object == obj){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

////////////////////////////
DKString DKEvents::GetType()
{
	DKDEBUGFUNC();
	return type;
}

////////////////////////////////
DKString DKEvents::GetJSReturn()
{
	DKDEBUGFUNC();
	return jsreturn;
}


//////////////////////////
DKString DKEvents::GetId()
{
	DKDEBUGFUNC();
	return id;
}

/////////////////////////////
DKString DKEvents::GetValue()
{
	DKDEBUGFUNC();
	DKString value = toString(data, ",");
	return value;
}

//////////////////////////////////
DKString DKEvents::GetValue(int n)
{
	DKDEBUGFUNC(n);
	return data[n];
}

/////////////////////////
int DKEvents::GetKeyNum()
{
	DKDEBUGFUNC();
	if(data.size() < 1){ return 0; }
	return toInt(data[0]);
}

//////////////////////////////////////////////////////////////////////////
bool DKEvents::RenameEventId(const DKString& oldID, const DKString& newID)
{
	DKDEBUGFUNC(oldID, newID);
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id, oldID)){
			events[i]->id = newID;
		}
	}
	return true;
}