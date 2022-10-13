#include "DK/stdafx.h"
#include "DKOSGRml/DKOSGRmlSystem.h"
#include <iostream>


DKOSGRmlSystem::DKOSGRmlSystem() : _timer(osg::Timer::instance()->tick()){

}

float DKOSGRmlSystem::GetElapsedTime(){
	return (float)osg::Timer::instance()->time_s();
}

int DKOSGRmlSystem::TranslateString(Rml::Core::String& translated, const Rml::Core::String& input){
	translated = input;
	return 0;
}

bool DKOSGRmlSystem::LogMessage(Rml::Core::Log::Type type, const Rml::Core::String& message){
	switch(type)
	{
	case Rml::Core::Log::LT_ALWAYS:
		DKINFO(DKString(message.CString())+"\n");
		break;
	case Rml::Core::Log::LT_ERROR:
		DKERROR(DKString(message.CString())+"\n");
		break;
	case Rml::Core::Log::LT_ASSERT:
		DKERROR(DKString(message.CString())+"\n");
		break;
	case Rml::Core::Log::LT_WARNING:
		DKWARN(DKString(message.CString())+"\n");
		break;
	case Rml::Core::Log::LT_INFO:
		DKINFO(DKString(message.CString())+"\n");
		break;
	case Rml::Core::Log::LT_DEBUG:
		DKDEBUG(DKString(message.CString())+"\n");
		break;
    case Rml::Core::Log::LT_MAX:
		DKINFO(DKString(message.CString())+"\n");
        break;
	};
	return true;
};
