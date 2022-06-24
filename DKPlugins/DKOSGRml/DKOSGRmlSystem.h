#pragma once
#ifndef DKOSGRocketSystem_H
#define DKOSGRocketSystem_H

#include <Rocket/Core/Core.h>
#include <osg/Notify>
#include <osg/Timer>

class DKOSGRocketSystem : public Rocket::Core::SystemInterface
{
public:
	DKOSGRocketSystem();
    virtual float GetElapsedTime();

	/// Translate the input string into the translated string.
	/// @param[out] translated Translated string ready for display.
	/// @param[in] input String as received from XML.
	/// @return Number of translations that occured.
	virtual int TranslateString(Rocket::Core::String& translated, const Rocket::Core::String& input);

	/// Log the specified message.
	/// @param[in] type Type of log message, ERROR, WARNING, etc.
	/// @param[in] message Message to log.
	/// @return True to continue execution, false to break into the debugger.
	virtual bool LogMessage(Rocket::Core::Log::Type type, const Rocket::Core::String& message);


	/// Called when this system interface is no longer required.
	virtual void Release(){}

private:
      osg::Timer_t _timer;
};
#endif //DKOSGRocketSystem_H
