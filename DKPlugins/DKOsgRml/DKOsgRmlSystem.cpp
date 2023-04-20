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
#include "DK/stdafx.h"
#include "DKOsgRml/DKOsgRmlSystem.h"

WARNING_DISABLE
#include <iostream>
WARNING_ENABLE


DKOsgRmlSystem::DKOsgRmlSystem() : _timer(osg::Timer::instance()->tick()){
	DKDEBUGFUNC();
}

double DKOsgRmlSystem::GetElapsedTime(){
	//DKDEBUGFUNC(); //EXCESSIVE LOGGING
	return (float)osg::Timer::instance()->time_s();
}

int DKOsgRmlSystem::TranslateString(Rml::String& translated, const Rml::String& input){
	DKDEBUGFUNC(translated, input);
	translated = input;
	return 0;
}

bool DKOsgRmlSystem::LogMessage(Rml::Log::Type type, const Rml::String& message){
	//DKDEBUGFUNC(type, message);  //EXCESSIVE LOGGING
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
