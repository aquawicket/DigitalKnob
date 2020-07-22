//https://developer.mozilla.org/en-US/docs/Web/API/Window

#pragma once
#ifndef DKDomWindow_H
#define DKDomWindow_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////
class DKDomWindow : public DKObjectT<DKDomWindow>
{
public:
	bool Init();

	//events
	static int addEventListener(duk_context* ctx);
	static int removeEventListener(duk_context* ctx);
	
	//window
	static int devicePixelRatio(duk_context* ctx);
	static int innerHeight(duk_context* ctx);
	static int innerWidth(duk_context* ctx);
	static int name(duk_context* ctx);
};

REGISTER_OBJECT(DKDomWindow, true)

#endif //DKDomWindow_H