#pragma once
#ifndef DKServerWebsockets_H
#define DKServerWebsockets_H

#include <libwebsockets.h>

///////////////////////////////////////////
class DKServerWebsockets : public DKObjectT<DKServerWebsockets>
{
public:
	void Init();
	void End();
};


REGISTER_OBJECT(DKServerWebsockets, true);

#endif //DKServerWebsockets_H