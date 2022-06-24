#include "DK/stdafx.h"

#include "DKOSGRocketSystem.h"
#include <iostream>


//////////////////////////////////////
DKOSGRocketSystem::DKOSGRocketSystem()
: _timer(osg::Timer::instance()->tick())
{

}

/////////////////////////////////////////
float DKOSGRocketSystem::GetElapsedTime()
{
	return (float)osg::Timer::instance()->time_s();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
int DKOSGRocketSystem::TranslateString(Rocket::Core::String& translated, const Rocket::Core::String& input)
{
	translated = input;
	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKOSGRocketSystem::LogMessage(Rocket::Core::Log::Type type, const Rocket::Core::String& message)
{
	switch(type)
	{
	case Rocket::Core::Log::LT_ALWAYS:
		DKLog(DKString(message.CString())+"\n", DKINFO);
		break;
	case Rocket::Core::Log::LT_ERROR:
		DKLog(DKString(message.CString())+"\n", DKERROR);
		break;
	case Rocket::Core::Log::LT_ASSERT:
		DKLog(DKString(message.CString())+"\n", DKERROR);
		break;
	case Rocket::Core::Log::LT_WARNING:
		DKLog(DKString(message.CString())+"\n", DKWARN);
		break;
	case Rocket::Core::Log::LT_INFO:
		DKLog(DKString(message.CString())+"\n", DKINFO);
		break;
	case Rocket::Core::Log::LT_DEBUG:
		DKLog(DKString(message.CString())+"\n", DKDEBUG);
		break;
    case Rocket::Core::Log::LT_MAX:
		DKLog(DKString(message.CString())+"\n", DKINFO);
        break;
	};

	return true;
};
