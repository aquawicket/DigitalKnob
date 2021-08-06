#ifdef USE_DK
#pragma once
#ifndef App_H
#define App_H

#include "DK/DKApp.h"
#include "Android.h"

/////////////////////////////////
class App : public DKObjectT<App>
{
public:
	bool Init();
};

REGISTER_OBJECT(App, true);

#endif //App_H
#endif //USE_DK