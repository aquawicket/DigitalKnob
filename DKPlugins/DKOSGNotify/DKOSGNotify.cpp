#include "DK/stdafx.h"
#include "DKOSGNotify/DKOSGNotify.h"
#include <iostream>
#include "DKAssets/DKAssets.h"
#include "DK/DKFile.h"


bool DKOSGNotify::Init(){
	osg::setNotifyHandler(this);
#ifdef DEBUG
    osg::setNotifyLevel(osg::INFO);
#else
	osg::setNotifyLevel(osg::NOTICE);
#endif
	return true;
}

bool DKOSGNotify::End(){
	return true;
}

bool DKOSGNotify::AttachNotify(osg::NotifyHandler* panel){
	if(!panel){return false;}
	notifys.push_back(panel);
	return true;
}

bool DKOSGNotify::RemoveNotify(osg::NotifyHandler* panel){
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

void DKOSGNotify::notify(osg::NotifySeverity severity, const char *message){
	//FIXME - We get empty messages sometimes..  why?
	if(message && message[0] == '\0')
		return;
	output(severity,message); //App output
	for(unsigned int i=0; i<notifys.size(); i++){
		notifys[i]->notify(severity,message); //Attached outputs
	}
}

void DKOSGNotify::output(osg::NotifySeverity severity, const char *message){
	switch(severity){
		case osg::DEBUG_FP:
			DKDEBUG(message);
			break;
		case osg::DEBUG_INFO:
			DKDEBUG(message);
			break;
		case osg::NOTICE:
		case osg::INFO:
			DKINFO(message);
			break;
		case osg::WARN:
			DKWARN(message);
			break;
		case osg::FATAL:
			DKERROR(message);
			break;
		case osg::ALWAYS:
			DKINFO(message);
			break;
		default:
			DKINFO(message);
			break;
    }
}
