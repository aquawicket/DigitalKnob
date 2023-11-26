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
//WARNING_DISABLE
#include <RmlUi/Core.h>
//WARNING_ENABLE

#include "DKSFMLRml/DKSFMLRmlSystem.h"


Rml::Input::KeyIdentifier RmlSFMLSystemInterface::TranslateKey(sf::Keyboard::Key Key){
	DKDEBUGFUNC(Key);
	switch(Key){
	case sf::Keyboard::A:
		return Rml::Input::KI_A;
		break;
	case sf::Keyboard::B:
		return Rml::Input::KI_B;
		break;
	case sf::Keyboard::C:
		return Rml::Input::KI_C;
		break;
	case sf::Keyboard::D:
		return Rml::Input::KI_D;
		break;
	case sf::Keyboard::E:
		return Rml::Input::KI_E;
		break;
	case sf::Keyboard::F:
		return Rml::Input::KI_F;
		break;
	case sf::Keyboard::G:
		return Rml::Input::KI_G;
		break;
	case sf::Keyboard::H:
		return Rml::Input::KI_H;
		break;
	case sf::Keyboard::I:
		return Rml::Input::KI_I;
		break;
	case sf::Keyboard::J:
		return Rml::Input::KI_J;
		break;
	case sf::Keyboard::K:
		return Rml::Input::KI_K;
		break;
	case sf::Keyboard::L:
		return Rml::Input::KI_L;
		break;
	case sf::Keyboard::M:
		return Rml::Input::KI_M;
		break;
	case sf::Keyboard::N:
		return Rml::Input::KI_N;
		break;
	case sf::Keyboard::O:
		return Rml::Input::KI_O;
		break;
	case sf::Keyboard::P:
		return Rml::Input::KI_P;
		break;
	case sf::Keyboard::Q:
		return Rml::Input::KI_Q;
		break;
	case sf::Keyboard::R:
		return Rml::Input::KI_R;
		break;
	case sf::Keyboard::S:
		return Rml::Input::KI_S;
		break;
	case sf::Keyboard::T:
		return Rml::Input::KI_T;
		break;
	case sf::Keyboard::U:
		return Rml::Input::KI_U;
		break;
	case sf::Keyboard::V:
		return Rml::Input::KI_V;
		break;
	case sf::Keyboard::W:
		return Rml::Input::KI_W;
		break;
	case sf::Keyboard::X:
		return Rml::Input::KI_X;
		break;
	case sf::Keyboard::Y:
		return Rml::Input::KI_Y;
		break;
	case sf::Keyboard::Z:
		return Rml::Input::KI_Z;
		break;
	case sf::Keyboard::Num0:
		return Rml::Input::KI_0;
		break;
	case sf::Keyboard::Num1:
		return Rml::Input::KI_1;
		break;
	case sf::Keyboard::Num2:
		return Rml::Input::KI_2;
		break;
	case sf::Keyboard::Num3:
		return Rml::Input::KI_3;
		break;
	case sf::Keyboard::Num4:
		return Rml::Input::KI_4;
		break;
	case sf::Keyboard::Num5:
		return Rml::Input::KI_5;
		break;
	case sf::Keyboard::Num6:
		return Rml::Input::KI_6;
		break;
	case sf::Keyboard::Num7:
		return Rml::Input::KI_7;
		break;
	case sf::Keyboard::Num8:
		return Rml::Input::KI_8;
		break;
	case sf::Keyboard::Num9:
		return Rml::Input::KI_9;
		break;
	case sf::Keyboard::Numpad0:
		return Rml::Input::KI_NUMPAD0;
		break;
	case sf::Keyboard::Numpad1:
		return Rml::Input::KI_NUMPAD1;
		break;
	case sf::Keyboard::Numpad2:
		return Rml::Input::KI_NUMPAD2;
		break;
	case sf::Keyboard::Numpad3:
		return Rml::Input::KI_NUMPAD3;
		break;
	case sf::Keyboard::Numpad4:
		return Rml::Input::KI_NUMPAD4;
		break;
	case sf::Keyboard::Numpad5:
		return Rml::Input::KI_NUMPAD5;
		break;
	case sf::Keyboard::Numpad6:
		return Rml::Input::KI_NUMPAD6;
		break;
	case sf::Keyboard::Numpad7:
		return Rml::Input::KI_NUMPAD7;
		break;
	case sf::Keyboard::Numpad8:
		return Rml::Input::KI_NUMPAD8;
		break;
	case sf::Keyboard::Numpad9:
		return Rml::Input::KI_NUMPAD9;
		break;
	case sf::Keyboard::Left:
		return Rml::Input::KI_LEFT;
		break;
	case sf::Keyboard::Right:
		return Rml::Input::KI_RIGHT;
		break;
	case sf::Keyboard::Up:
		return Rml::Input::KI_UP;
		break;
	case sf::Keyboard::Down:
		return Rml::Input::KI_DOWN;
		break;
	case sf::Keyboard::Add:
		return Rml::Input::KI_ADD;
		break;
	case sf::Keyboard::Backspace:
		return Rml::Input::KI_BACK;
		break;
	case sf::Keyboard::Delete:
		return Rml::Input::KI_DELETE;
		break;
	case sf::Keyboard::Divide:
		return Rml::Input::KI_DIVIDE;
		break;
	case sf::Keyboard::End:
		return Rml::Input::KI_END;
		break;
	case sf::Keyboard::Escape:
		return Rml::Input::KI_ESCAPE;
		break;
	case sf::Keyboard::F1:
		return Rml::Input::KI_F1;
		break;
	case sf::Keyboard::F2:
		return Rml::Input::KI_F2;
		break;
	case sf::Keyboard::F3:
		return Rml::Input::KI_F3;
		break;
	case sf::Keyboard::F4:
		return Rml::Input::KI_F4;
		break;
	case sf::Keyboard::F5:
		return Rml::Input::KI_F5;
		break;
	case sf::Keyboard::F6:
		return Rml::Input::KI_F6;
		break;
	case sf::Keyboard::F7:
		return Rml::Input::KI_F7;
		break;
	case sf::Keyboard::F8:
		return Rml::Input::KI_F8;
		break;
	case sf::Keyboard::F9:
		return Rml::Input::KI_F9;
		break;
	case sf::Keyboard::F10:
		return Rml::Input::KI_F10;
		break;
	case sf::Keyboard::F11:
		return Rml::Input::KI_F11;
		break;
	case sf::Keyboard::F12:
		return Rml::Input::KI_F12;
		break;
	case sf::Keyboard::F13:
		return Rml::Input::KI_F13;
		break;
	case sf::Keyboard::F14:
		return Rml::Input::KI_F14;
		break;
	case sf::Keyboard::F15:
		return Rml::Input::KI_F15;
		break;
	case sf::Keyboard::Home:
		return Rml::Input::KI_HOME;
		break;
	case sf::Keyboard::Insert:
		return Rml::Input::KI_INSERT;
		break;
	case sf::Keyboard::LControl:
		return Rml::Input::KI_LCONTROL;
		break;
	case sf::Keyboard::LShift:
		return Rml::Input::KI_LSHIFT;
		break;
	case sf::Keyboard::Multiply:
		return Rml::Input::KI_MULTIPLY;
		break;
	case sf::Keyboard::Pause:
		return Rml::Input::KI_PAUSE;
		break;
	case sf::Keyboard::RControl:
		return Rml::Input::KI_RCONTROL;
		break;
	case sf::Keyboard::Enter:
		return Rml::Input::KI_RETURN;
		break;
	case sf::Keyboard::RShift:
		return Rml::Input::KI_RSHIFT;
		break;
	case sf::Keyboard::Space:
		return Rml::Input::KI_SPACE;
		break;
	case sf::Keyboard::Subtract:
		return Rml::Input::KI_SUBTRACT;
		break;
	case sf::Keyboard::Tab:
		return Rml::Input::KI_TAB;
		break;
	default:
		break;
	};
	return Rml::Input::KI_UNKNOWN;
}

int RmlSFMLSystemInterface::TranslateMouseButton(sf::Mouse::Button button){
	DKDEBUGFUNC(button);
    switch(button){
		case sf::Mouse::Left:
            return 0;
        case sf::Mouse::Right:
            return 1;
		case sf::Mouse::Middle:
            return 2;
		case sf::Mouse::XButton1:
            return 3;
        case sf::Mouse::XButton2:
            return 4;
        default:
            return 99; //FIXME
    }
}

int RmlSFMLSystemInterface::GetKeyModifiers(){
	DKDEBUGFUNC();
	int Modifiers = 0;
	if(sf::Keyboard::isKeyPressed(sf::Keyboard::LShift) || sf::Keyboard::isKeyPressed(sf::Keyboard::RShift))
		Modifiers |= Rml::Input::KM_SHIFT;
	if(sf::Keyboard::isKeyPressed(sf::Keyboard::LControl) || sf::Keyboard::isKeyPressed(sf::Keyboard::RControl))
		Modifiers |= Rml::Input::KM_CTRL;
	if(sf::Keyboard::isKeyPressed(sf::Keyboard::LAlt) || sf::Keyboard::isKeyPressed(sf::Keyboard::RAlt))
		Modifiers |= Rml::Input::KM_ALT;
	return Modifiers;
}

double RmlSFMLSystemInterface::GetElapsedTime(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	return timer.getElapsedTime().asSeconds();
}

bool RmlSFMLSystemInterface::LogMessage(Rml::Log::Type type, const Rml::String& message){
	//DKDEBUGFUNC(type, message);  //EXCESSIVE LOGGING
	Rml::String Type;
	switch(type){
		case Rml::Log::LT_ALWAYS:
			DKINFO("[Rml] "+DKString(message)+"\n");
			break;
		case Rml::Log::LT_ERROR:
			DKERROR("[Rml] "+DKString(message)+"\n");
			break;
		case Rml::Log::LT_ASSERT:
			DKERROR("[Rml] "+DKString(message)+"\n");
			break;
		case Rml::Log::LT_WARNING:
			DKWARN("[Rml] "+DKString(message)+"\n");
			break;
		case Rml::Log::LT_INFO:
			DKINFO("[Rml] "+DKString(message)+"\n");
			break;
		case Rml::Log::LT_DEBUG:
			DKDEBUG("[Rml] "+DKString(message)+"\n");
			break;
		case Rml::Log::LT_MAX:
			DKDEBUG("[Rml] "+DKString(message)+"\n");
			break;
		default:
			break;
	};
	return true;
}
