#pragma once
#ifndef DKDebug_H
#define DKDebug_H
#include "DK/DK.h"

//#ifdef USE_DKCurl
//	#include "DKCurl/DKCurl.h"
//#endif

class DKDebug : public DKObjectT<DKDebug>
{
public:
	bool Init();
	bool End();
	static bool SendBugReport(const DKString& filename);
	bool ShowStackTrace(const void* input, void* output);
};


REGISTER_OBJECT(DKDebug, true);

#endif //DKDebug_H
