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
	static bool RemoveEvents(const DKString& id);
	static bool RemoveEvents(DKObject* obj);
	static bool SendEvent(const DKString& id, const DKString& type, const DKString& value);
	//static void ProcessGlobalEvents(const DKString& type);
	static void RenameEventId(const DKString& oldID, const DKString& newID);
	DKString GetId();
	DKString GetType();
	DKString GetJSReturn();
	DKString GetValue();
	DKString GetValue(int n);
	int GetKeyNum();
	//int GetMouseButton();
	//int GetMouseX();
	//int GetMouseY();

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
	//////////////////////////////////////////////////////////////////////////////////////////
	static void RegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this)
	{
		reg_func.push_back(boost::bind(func, _this, _1, _2));
	}
	static std::vector<boost::function<bool (const DKString&, const DKString&)> > reg_func;

	template<class T>
	//////////////////////////////////////////////////////////////////////////////////////////
	static void UnegisterEventFunc(bool (T::*func)(const DKString&, const DKString&), T* _this)
	{
		unreg_func.push_back(boost::bind(func, _this, _1, _2));
	}
	static std::vector<boost::function<bool (const DKString&, const DKString&)> > unreg_func;

	template<class T>
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	static void RegisterSendFunc(void (T::*func)(const DKString&, const DKString&, const DKString&), T* _this)
	{
		send_func.push_back(boost::bind(func, _this, _1, _2, _3));
	}
	static std::vector<boost::function<void (const DKString&, const DKString&, const DKString&)> > send_func;
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