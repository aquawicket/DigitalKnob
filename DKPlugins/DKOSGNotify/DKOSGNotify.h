#pragma once
#ifndef DKOSGNotify_H
#define DKOSGNotify_H
#include "DK.h"

#ifdef ANDROID
#include <android/log.h>
#endif

#include <osg/Notify>

class DKOSGNotify : public DKObjectT<DKOSGNotify>, public osg::NotifyHandler
{
public:
	bool Init();
	bool End();
	
	bool AttachNotify(osg::NotifyHandler* panel);
	bool RemoveNotify(osg::NotifyHandler* panel);

private: 
    void notify(osg::NotifySeverity severity, const char *message);
	void output(osg::NotifySeverity severity, const char *message);
	std::vector<osg::NotifyHandler*> notifys;
};


REGISTER_OBJECT(DKOSGNotify, true);
#endif //DKOSGNotify_H
