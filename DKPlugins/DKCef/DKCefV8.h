/*
#pragma once
#ifndef DKCefV8_H
#define DKCefV8_H

#include "DKCef.h"

/////////////////////////////////////////
class DKCefV8 : public DKObjectT<DKCefV8>
{
public:
	void Init();
	void End();

	static CefRefPtr<CefV8Handler> handler; 
};

///////////////////////////////////////
class DKV8Handler : public CefV8Handler 
{
public:
	DKV8Handler(){}
	virtual bool Execute(const CefString& name,
                       CefRefPtr<CefV8Value> object,
                       const CefV8ValueList& arguments,
                       CefRefPtr<CefV8Value>& retval,
                       CefString& exception) OVERRIDE {
		if (name == "myfunc") {
			// Return my string value.
			retval = CefV8Value::CreateString("My Value!");
			return true;
		}

		// Function does not exist.
		return false;
	}

  // Provide the reference counting implementation for this class.
  IMPLEMENT_REFCOUNTING(DKV8Handler);
};

REGISTER_OBJECT(DKCefV8, false);

#endif //DKCefV8_H
*/