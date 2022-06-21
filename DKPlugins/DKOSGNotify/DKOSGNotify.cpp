#include "DK/stdafx.h"
#include "DKOSGNotify.h"
#include <iostream>
#include "DKAssets.h"
#include "DKFile.h"

////////////////////////
bool DKOSGNotify::Init()
{
	osg::setNotifyHandler(this);
#ifdef DEBUG
    osg::setNotifyLevel(osg::INFO);
#else
	osg::setNotifyLevel(osg::NOTICE);
#endif
	return true;
}

///////////////////////
bool DKOSGNotify::End()
{
	return true;
}

//////////////////////////////////////////////////////
bool DKOSGNotify::AttachNotify(osg::NotifyHandler* panel)
{
	if(!panel){return false;}
	notifys.push_back(panel);
	return true;
}

//////////////////////////////////////////////////////
bool DKOSGNotify::RemoveNotify(osg::NotifyHandler* panel)
{
	if(!panel){return false;}
	for(unsigned int i = 0; i < notifys.size(); i++){
		if(panel == notifys[i]){
			notifys[i] = NULL;
			notifys.erase(notifys.begin()+i);
			return true;
		}
	}

	return false;
}

////////////////////////////////////////////////////////////////////////
void DKOSGNotify::notify(osg::NotifySeverity severity, const char *message)
{
	//FIXME - We get empty messages sometimes..  why?
	if(message && message[0] == '\0'){ 
		return;
	}
	output(severity,message); //App output

	for(unsigned int i=0; i<notifys.size(); i++){
		notifys[i]->notify(severity,message); //Attached outputs
	}
}

////////////////////////////////////////////////////////////////////////
void DKOSGNotify::output(osg::NotifySeverity severity, const char *message)
{
	switch(severity){
		case osg::DEBUG_FP:
			DKLog(message, DKDEBUG);
			break;
		case osg::DEBUG_INFO:
			DKLog(message, DKDEBUG);
			break;
		case osg::NOTICE:
		case osg::INFO:
			DKLog(message, DKINFO);
			break;
		case osg::WARN:
			DKLog(message, DKWARN);
			break;
		case osg::FATAL:
			DKLog(message, DKERROR);
			break;
		case osg::ALWAYS:
			DKLog(message, DKINFO);
			break;
		default:
			DKLog(message, DKINFO);
			break;
    }
}

