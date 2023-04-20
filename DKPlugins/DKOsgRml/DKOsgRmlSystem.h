/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#pragma once
#ifndef DKOsgRmlSystem_H
#define DKOsgRmlSystem_H

WARNING_DISABLE
#include <RmlUi/Core.h>
#include <osg/Notify>
#include <osg/Timer>
WARNING_ENABLE


class DKOsgRmlSystem : public Rml::SystemInterface
{
public:
	DKOsgRmlSystem();
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
#endif //DKOsgRmlSystem_H
