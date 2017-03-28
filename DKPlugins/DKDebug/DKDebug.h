#pragma once
#ifndef DKDebug_H
#define DKDebug_H
#include "DK.h"
#include "DKCurl.h"

/////////////////////////////////////////
class DKDebug : public DKObjectT<DKDebug>
{
public:
	void Init();
	void End();
	static bool ShowStackTrace();
	static bool SendBugReport(const DKString& filename);
};


REGISTER_OBJECT(DKDebug, true);

#endif //DKDebug_H