#pragma once
#ifndef DKEvent_H
#define DKEvent_H

#include "DKObject.h"
class DKObject;

#include <boost/function.hpp>
#include <boost/bind.hpp>


/////////////
class DKEvent
{
public:
	static bool AddEvent(const DKString& id, const DKString& type, boost::function<void (DKEvent*)> func, DKObject* object);
	static bool AddEvent(const DKString& id, const DKString& type, const DKString& jsreturn, boost::function<void (DKEvent*)> func, DKObject* object);
	static bool RemoveEvent(const DKString& id, const DKString& type, const DKString& jsreturn);
	static bool RemoveEvents(const DKString& id, const DKString& type);
	static bool RemoveEvents(const DKString& variable); //variable can be id or jsreturn
	static bool RemoveEvents(DKObject* obj);
	static bool SendEvent(const DKString& id, const DKString& type, const DKString& value);
	static void RenameEventId(const DKString& oldID, const DKString& newID);
	DKString GetId();
	DKString GetType();
	DKString GetJSReturn();
	DKString GetValue();
	DKString GetValue(int n);
	int GetKeyNum();
	static std::vector<DKEvent*> events;

private:
	DKEvent(){};
	DKString id;
	DKString type;
	DKString jsreturn;
	DKObject* object;

public:
	DKStringArray data;
	boost::function<void (DKEvent*)> event_func;


	template<class T>
	/////////////////////////////////////////////////////////////////////////////////////////////
	static void AddRegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this)
	{
		reg_funcs.push_back(boost::bind(func, _this, _1, _2));
	}

	template<class T>
	////////////////////////////////////////////////////////////////////////////////////////////////
	static void RemoveRegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this)
	{
		for(unsigned int i=0; i<reg_funcs.size(); ++i){
			if(reg_funcs[i] == boost::bind(func, _this, _1, _2)){
				reg_funcs.erase(reg_funcs.begin() + i);
			}
		}
	}
	
	template<class T>
	//////////////////////////////////////////////////////////////////////////////////////////////
	static void AddUnegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this)
	{
		unreg_funcs.push_back(boost::bind(func, _this, _1, _2));
	}

	template<class T>
	/////////////////////////////////////////////////////////////////////////////////////////////////
	static void RemoveUnegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this)
	{
		for(unsigned int i=0; i<unreg_funcs.size(); ++i){
			if(unreg_funcs[i] == boost::bind(func, _this, _1, _2)){
				unreg_funcs.erase(unreg_funcs.begin() + i);
			}
		}
	}
	
	template<class T>
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	static void AddSendEventFunc(void (T::*func)(const DKString&, const DKString&, const DKString&), T* _this)
	{
		send_funcs.push_back(boost::bind(func, _this, _1, _2, _3));
	}

	template<class T>
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static void RemoveSendEventFunc(void (T::*func)(const DKString&, const DKString&, const DKString&), T* _this)
	{
		for(unsigned int i=0; i<send_funcs.size(); ++i){
			if(send_funcs[i] == boost::bind(func, _this, _1, _2, _3)){
				send_funcs.erase(send_funcs.begin() + i);
			}
		}
	}

	static std::vector<boost::function<bool (const DKString&, const DKString&)> > reg_funcs;
	static std::vector<boost::function<bool (const DKString&, const DKString&)> > unreg_funcs;
	static std::vector<boost::function<void (const DKString&, const DKString&, const DKString&)> > send_funcs;
};


//Global quick functions
//////////////////////////////////////////////////////////////////////////////////////
static void SendEvent(const DKString& id, const DKString& type, const DKString& value)
{
	DKEvent::SendEvent(id, type, value);
}

template<class T>
////////////////////////////////////////////////////////////////////////////////////////////////////
static void AddEvent(const DKString& id, const DKString& type, void (T::*func) (DKEvent*), T* _this)
{
	DKEvent::AddEvent(id, type, boost::bind(func, _this, _1), _this);
};

template<class T>
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void AddEvent(const DKString& id, const DKString& type, const DKString& jsreturn, void (T::*func) (DKEvent*), T* _this)
{
	DKEvent::AddEvent(id, type, jsreturn, boost::bind(func, _this, _1), _this);
};

///////////////////////////////////////////////////////////////////////////////////////////
static void RemoveEvent(const DKString& id, const DKString& type, const DKString& jsreturn)
{
	DKEvent::RemoveEvent(id, type, jsreturn);
};

//////////////////////////////////////////////////////////////////
static void RemoveEvents(const DKString& id, const DKString& type)
{
	DKEvent::RemoveEvents(id, type);
};

////////////////////////////////////////////
static void RemoveEvents(const DKString& id)
{
	DKEvent::RemoveEvents(id);
};


#endif //DKEvent_H