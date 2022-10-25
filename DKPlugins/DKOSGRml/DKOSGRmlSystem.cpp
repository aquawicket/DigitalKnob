#include "DK/stdafx.h"
#include "DKOSGRml/DKOSGRmlSystem.h"
#include <iostream>


DKOSGRmlSystem::DKOSGRmlSystem() : _timer(osg::Timer::instance()->tick()){
	DKDEBUGFUNC();
}

double DKOSGRmlSystem::GetElapsedTime(){
	//DKDEBUGFUNC();
	return (float)osg::Timer::instance()->time_s();
}

int DKOSGRmlSystem::TranslateString(Rml::String& translated, const Rml::String& input){
	//DKDEBUGFUNC(translated, input);
	translated = input;
	return 0;
}

bool DKOSGRmlSystem::LogMessage(Rml::Log::Type type, const Rml::String& message){
	//DKDEBUGFUNC(type, message);
	if (has(message, "Loaded font face"))
		type = Rml::Log::LT_DEBUG;
	switch (type) {
	case Rml::Log::LT_ALWAYS:
		DKINFO("[Rml] " + DKString(message) + "\n");
		break;
	case Rml::Log::LT_ERROR:
		DKERROR("[Rml] " + DKString(message) + "\n");
		break;
	case Rml::Log::LT_ASSERT:
		DKASSERT("[Rml] " + DKString(message) + "\n");
		break;
	case Rml::Log::LT_WARNING:
		DKWARN("[Rml] " + DKString(message) + "\n");
		break;
	case Rml::Log::LT_INFO:
		DKINFO("[Rml] " + DKString(message) + "\n");
		break;
	case Rml::Log::LT_DEBUG:
		DKDEBUG("[Rml] " + DKString(message) + "\n");
		break;
	case Rml::Log::LT_MAX:
		DKVERBOSE("[Rml] " + DKString(message) + "\n");
		break;
	};
	return true;
};
