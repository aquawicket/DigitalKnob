#include "DK/stdafx.h"
#include "DKEvent.h"
#include "DKClass.h"

std::vector<DKEvent*> DKEvent::events;
std::vector<boost::function<bool (const DKString&, const DKString&)> > DKEvent::reg_funcs;
std::vector<boost::function<bool (const DKString&, const DKString&)> > DKEvent::unreg_funcs;
std::vector<boost::function<bool (const DKString&, const DKString&, const DKString&)> > DKEvent::send_funcs;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKEvent::AddEvent(const DKString& id, const DKString& type, boost::function<bool (DKEvent*)> func, DKObject* object)
{
	DKLog("DKEvent::AddEvent("+id+","+type+")\n", DKDEBUG);
	return DKEvent::AddEvent(id, type, "", func, object);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKEvent::AddEvent(const DKString& id, const DKString& type, const DKString& jsreturn, boost::function<bool (DKEvent*)> func, DKObject* object)
{
	DKLog("DKEvent::AddEvent("+id+","+type+","+jsreturn+")\n", DKDEBUG);
	DKString _jsreturn = jsreturn;
	replace(_jsreturn, "() {\"ecmascript\"}", ""); //remove  () {\"ecmascript\"}

	//DKLog("DKEvent::AddEvent("+id+","+type+","+jsreturn+")\n");
	if(id.empty()){
		DKLog("DKEvent::AddEvent("+id+","+type+","+_jsreturn+"): No Id Specified \n",DKERROR);
		return false;
	}
	if(type.empty()){
		DKLog("DKEvent::AddEvent("+id+","+type+","+_jsreturn+"): No Type Specified \n",DKERROR);
		return false;
	}
	
	DKEvent* event = new DKEvent;
	event->id = id;
	event->type = type;
	event->jsreturn = _jsreturn;
	event->object = object;
	event->event_func = func;

	for(unsigned int i = 0; i < events.size(); ++i){
		if(event == events[i]){
			DKLog("DKEvent::AddEvent(): Event Exists, Reregistering. ("+id+" : "+type+" : "+_jsreturn+") \n.", DKWARN);
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

////////////////////////////////////////////////////////////////////////////////////////
bool DKEvent::SendEvent(const DKString& id, const DKString& type, const DKString& value)
{
	//DKLog("DKEvent::SendEvent()\n", DKDEBUG);
	
	if(!same(id,"DKLog") && !same(type,"second") && !same(type,"mousemove")){ //prevent looping messages
		DKLog("DKEvent::SendEvent("+id+","+type+","+value+")\n", DKDEBUG);
	}

	if(type.empty()){
		DKLog("DKEvent::SendEvent("+id+","+type+","+value+"): No Type Specified \n",DKERROR);
		return false;
	}
	if(id.empty()){
		DKLog("DKEvent::SendEvent("+id+","+type+","+value+"): No Id Specified \n",DKERROR);
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
			if(!same(id,"GLOBAL")){ return true; }
		}
	}

	//External Send Functions
	for(unsigned int i=0; i<send_funcs.size(); ++i){
		send_funcs[i](id, type, value); //returns bool
	}

	return false;
}

/////////////////////////////////////////////////////////////////////////////////////////////
bool DKEvent::RemoveEvent(const DKString& id, const DKString& type, const DKString& jsreturn)
{
	DKLog("DKEvent::RemoveEvent("+id+","+type+","+jsreturn+")\n", DKDEBUG);
	DKString _jsreturn = jsreturn;
	replace(_jsreturn, "() {\"ecmascript\"}", ""); //remove  () {\"ecmascript\"}

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

////////////////////////////////////////////////////////////////////
bool DKEvent::RemoveEvents(const DKString& id, const DKString& type)
{
	DKLog("DKEvent::RemoveEvents("+id+","+type+")\n", DKDEBUG);
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id,id) && same(events[i]->type,type)){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

////////////////////////////////////////////////////
bool DKEvent::RemoveEvents(const DKString& variable)
{
	DKLog("DKEvent::RemoveEvents("+variable+")\n", DKDEBUG);

	//variable can be id or jsreturn
	DKString _variable = variable;
	replace(_variable, "() {\"ecmascript\"}", ""); //remove  () {\"ecmascript\"}
	for(unsigned int i=0; i < events.size(); ++i){
		if(same(events[i]->id, _variable) || same(events[i]->jsreturn, _variable)){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

/////////////////////////////////////////
bool DKEvent::RemoveEvents(DKObject* obj)
{
	DKLog("DKEvent::RemoveEvents(DKObject)\n", DKDEBUG);
	for(unsigned int i = 0; i < events.size(); ++i){
		if(events[i]->object == obj){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

///////////////////////////
DKString DKEvent::GetType()
{
	//DKLog("DKEvent::GetType()\n", DKDEBUG);
	return type;
}

///////////////////////////////
DKString DKEvent::GetJSReturn()
{
	//DKLog("DKEvent::GetJSReturn()\n", DKDEBUG);
	return jsreturn;
}


/////////////////////////
DKString DKEvent::GetId()
{
	//DKLog("DKEvent::GetId()\n", DKDEBUG);
	return id;
}

////////////////////////////
DKString DKEvent::GetValue()
{
	DKLog("DKEvent::GetValue()\n", DKDEBUG);
	DKString value = toString(data, ",");
	return value;
}

/////////////////////////////////
DKString DKEvent::GetValue(int n)
{
	DKLog("DKEvent::GetValue("+toString(n)+")\n", DKDEBUG);
	return data[n];
}

////////////////////////
int DKEvent::GetKeyNum()
{
	DKLog("DKEvent::GetKeyNum()\n", DKDEBUG);
	if(data.size() < 1){ return 0; }
	return toInt(data[0]);
}

/////////////////////////////////////////////////////////////////////////
bool DKEvent::RenameEventId(const DKString& oldID, const DKString& newID)
{
	DKLog("DKEvent::RenameEventId("+oldID+","+newID+")\n", DKDEBUG);
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id, oldID)){
			events[i]->id = newID;
		}
	}
	return true;
}