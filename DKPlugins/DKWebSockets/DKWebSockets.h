#pragma once
#ifndef DKWebSockets_H
#define DKWebSockets_H

//#include "libwebsockets.h"
#include "src/uWS.h"
#include "DK/DK.h"

///////////////////////////////////////////////////
class DKWebSockets : public DKObjectT<DKWebSockets>
{
public:
	bool Init();
	bool End();
	void Loop();

	uWS::Hub h;
};


REGISTER_OBJECT(DKWebSockets, true);

#endif //DKWebSockets_H

