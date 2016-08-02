#include "stdafx.h"
#include "DKEvent.h"
#include "DKClass.h"

std::vector<DKEvent*> DKEvent::events;
std::vector<boost::function<bool (const DKString&, const DKString&)> > DKEvent::reg_func;
std::vector<boost::function<bool (const DKString&, const DKString&)> > DKEvent::unreg_func;
std::vector<boost::function<void (const DKString&, const DKString&, const DKString&)> > DKEvent::send_func;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKEvent::AddEvent(const DKString& id, const DKString& type, boost::function<void (DKEvent*)> func, DKObject* object)
{
	return DKEvent::AddEvent(id, type, "", func, object);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKEvent::AddEvent(const DKString& id, const DKString& type, const DKString& jsreturn, boost::function<void (DKEvent*)> func, DKObject* object)
{
	//DKLog("DKEvent::AddEvent("+id+","+type+","+jsreturn+") \n");
	if(id.empty()){
		DKLog("DKEvent::AddEvent("+id+","+type+","+jsreturn+"): No Id Specified \n",DKERROR);
		return false;
	}
	if(type.empty()){
		DKLog("DKEvent::AddEvent("+id+","+type+","+jsreturn+"): No Type Specified \n",DKERROR);
		return false;
	}
	
	DKEvent* event = new DKEvent;
	event->id = id;
	event->type = type;
	event->jsreturn = jsreturn;
	replace(event->jsreturn, "() {\"ecmascript\"}", ""); //remove  () {\"ecmascript\"}
	event->object = object;
	event->event_func = func;

	for(unsigned int i = 0; i < events.size(); ++i){
		if(event == events[i]){
			DKLog("DKEvent::AddEvent(): Event Exists, Reregistering. ("+id+" : "+type+" : "+jsreturn+") \n.", DKWARN);
			events[i] = event;
			//External Reg Functions
			for(unsigned int i=0; i<reg_func.size(); ++i){
				reg_func[i](id, type);
			}
			return true;
		}
	}

	events.push_back(event);

	//External Reg Functions
	for(unsigned int i=0; i<reg_func.size(); ++i){
		reg_func[i](id, type);
	}

	return true;
}

////////////////////////////////////////////////////////////////////////////////////////
bool DKEvent::SendEvent(const DKString& id, const DKString& type, const DKString& value)
{
	//DKLog("SendEvent("+id+","+type+","+value+") \n");
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
	for(unsigned int i=0; i<send_func.size(); ++i){
		send_func[i](id, type, value); //returns bool
	}

	return false;
}

/////////////////////////////////////////////////////////////////////////////////////////////
bool DKEvent::RemoveEvent(const DKString& id, const DKString& type, const DKString& jsreturn)
{
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id,id) && same(events[i]->type,type) && same(events[i]->jsreturn,jsreturn)){
			events.erase(events.begin()+i);
			//i--;
			return true; //This event should not exist twice.
		}
	}

	//External Reg Functions
	for(unsigned int i=0; i<unreg_func.size(); ++i){
		unreg_func[i](id, type); //returns bool
	}
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKEvent::RemoveEvents(const DKString& id, const DKString& type)
{
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id,id) && same(events[i]->type,type)){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

//////////////////////////////////////////////
bool DKEvent::RemoveEvents(const DKString& id)
{
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id,id)){
			events.erase(events.begin()+i);
			i--;
		}
	}
	return true;
}

/////////////////////////////////////////
bool DKEvent::RemoveEvents(DKObject* obj)
{
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
	return type;
}

///////////////////////////////
DKString DKEvent::GetJSReturn()
{
	return jsreturn;
}


/////////////////////////
DKString DKEvent::GetId()
{
	return id;
}

////////////////////////////
DKString DKEvent::GetValue()
{
	/*
	DKString value;
	if(rEvent){
		value = rEvent->GetParameter<DKCString>("msg0", "").CString(); //custom widget event?
		if(!value.empty()){ return value; }
	
		DKElement* element = rEvent->GetCurrentElement();

		if(DKWidget::GetAttribute(element, "value", value)){ return value; }

		if(element){	
			if(element->GetTagName() == "select"){ //select element value?
				DKElementFormControl* ele = static_cast<DKElementFormControl*>(element);
				if(!ele){ return value; }
				value = ele->GetValue().CString();
				if(!value.empty()){ return value; }
			}

			if(element->HasAttribute("value")){ //element value attribue ?
				DKCString temp;
				temp = element->GetAttribute("value")->Get<DKCString>();
				value = temp.CString();
				if(!value.empty()){ return value; }
			}
		}
	}

	if(data.size()){
		return data[0];
	}

	return "";
	*/
	DKString value = toString(data, ",");
	return value;
}



/////////////////////////////////
DKString DKEvent::GetValue(int n)
{
	//if(!rEvent){return "";}
	//DKString var = "msg"+toString(n);
	//DKString value = rEvent->GetParameter<DKCString>(var.c_str(), "").CString();
	//return value;
	return data[n];
}


////////////////////////
int DKEvent::GetKeyNum()
{
	if(data.size() < 1){ return 0; }
	return toInt(data[0]);
}

/////////////////////////////////////////////////////////////////////////
void DKEvent::RenameEventId(const DKString& oldID, const DKString& newID)
{
	for(unsigned int i = 0; i < events.size(); ++i){
		if(same(events[i]->id, oldID)){
			events[i]->id = newID;
		}
	}
}
