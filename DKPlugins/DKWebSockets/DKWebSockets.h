#pragma once
#ifndef DKWebSockets_H
#define DKWebSockets_H

//#include libwebsockets.h
#include "DK/DK.h"

///////////////////////////////////////////////////
class DKWebSockets : public DKObjectT<DKWebSockets>
{
public:
	bool Init();
	bool End();
};


REGISTER_OBJECT(DKWebSockets, true);

#endif //DKWebSockets_H

