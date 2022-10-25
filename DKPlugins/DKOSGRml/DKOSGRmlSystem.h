#pragma once
#ifndef DKOSGRmlSystem_H
#define DKOSGRmlSystem_H

#include <RmlUi/Core.h>
#include <osg/Notify>
#include <osg/Timer>

class DKOSGRmlSystem : public Rml::SystemInterface
{
public:
	DKOSGRmlSystem();
    virtual double GetElapsedTime();

	/// Translate the input string into the translated string.
	/// @param[out] translated Translated string ready for display.
	/// @param[in] input String as received from XML.
	/// @return Number of translations that occured.
	virtual int TranslateString(Rml::String& translated, const Rml::String& input);

	/// Log the specified message.
	/// @param[in] type Type of log message, ERROR, WARNING, etc.
	/// @param[in] message Message to log.
	/// @return True to continue execution, false to break into the debugger.
	virtual bool LogMessage(Rml::Log::Type type, const Rml::String& message);

	/// Called when this system interface is no longer required.
	virtual void Release(){}

private:
      osg::Timer_t _timer;
};
#endif //DKOSGRmlSystem_H
