/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include <RmlUi/Core.h>
#include "DKSFMLRml/DKSFMLRmlSystem.h"

/*
Rml::Input::KeyIdentifier RmlSFML2SystemInterface::TranslateKey(SFML_Keycode sdlkey){
	DKDEBUGFUNC(sdlkey);
    using namespace Rml::Input;
    switch(sdlkey) {
        case SFMLK_UNKNOWN:
            return KI_UNKNOWN;
            break;
        case SFMLK_SPACE:
            return KI_SPACE;
            break;
        case SFMLK_0:
            return KI_0;
            break;
        case SFMLK_1:
            return KI_1;
            break;
        case SFMLK_2:
            return KI_2;
            break;
        case SFMLK_3:
            return KI_3;
            break;
        case SFMLK_4:
            return KI_4;
            break;
        case SFMLK_5:
            return KI_5;
            break;
        case SFMLK_6:
            return KI_6;
            break;
        case SFMLK_7:
            return KI_7;
            break;
        case SFMLK_8:
            return KI_8;
            break;
        case SFMLK_9:
            return KI_9;
            break;
        case SFMLK_a:
            return KI_A;
            break;
        case SFMLK_b:
            return KI_B;
            break;
        case SFMLK_c:
            return KI_C;
            break;
        case SFMLK_d:
            return KI_D;
            break;
        case SFMLK_e:
            return KI_E;
            break;
        case SFMLK_f:
            return KI_F;
            break;
        case SFMLK_g:
            return KI_G;
            break;
        case SFMLK_h:
            return KI_H;
            break;
        case SFMLK_i:
            return KI_I;
            break;
        case SFMLK_j:
            return KI_J;
            break;
        case SFMLK_k:
            return KI_K;
            break;
        case SFMLK_l:
            return KI_L;
            break;
        case SFMLK_m:
            return KI_M;
            break;
        case SFMLK_n:
            return KI_N;
            break;
        case SFMLK_o:
            return KI_O;
            break;
        case SFMLK_p:
            return KI_P;
            break;
        case SFMLK_q:
            return KI_Q;
            break;
        case SFMLK_r:
            return KI_R;
            break;
        case SFMLK_s:
            return KI_S;
            break;
        case SFMLK_t:
            return KI_T;
            break;
        case SFMLK_u:
            return KI_U;
            break;
        case SFMLK_v:
            return KI_V;
            break;
        case SFMLK_w:
            return KI_W;
            break;
        case SFMLK_x:
            return KI_X;
            break;
        case SFMLK_y:
            return KI_Y;
            break;
        case SFMLK_z:
            return KI_Z;
            break;
        case SFMLK_SEMICOLON:
            return KI_OEM_1;
            break;
        case SFMLK_QUOTE:
            return KI_OEM_7;
            break;
        case SFMLK_EQUALS:
            return KI_OEM_PLUS;
            break;
        case SFMLK_PLUS:
            return KI_OEM_PLUS;
            break;
        case SFMLK_COMMA:
            return KI_OEM_COMMA;
            break;
        case SFMLK_MINUS:
            return KI_OEM_MINUS;
            break;
        case SFMLK_PERIOD:
            return KI_OEM_PERIOD;
            break;
        case SFMLK_SLASH:
            return KI_OEM_2;
            break;
        case SFMLK_BACKQUOTE:
            return KI_OEM_3;
            break;
        case SFMLK_LEFTBRACKET:
            return KI_OEM_4;
            break;
        case SFMLK_BACKSLASH:
            return KI_OEM_5;
            break;
        case SFMLK_RIGHTBRACKET:
            return KI_OEM_6;
            break;
        case SFMLK_QUOTEDBL:
            return KI_OEM_7;
            break;
        case SFMLK_ESCAPE:
            return KI_ESCAPE;
            break;
        case SFMLK_KP_0:
            return KI_NUMPAD0;
            break;
        case SFMLK_KP_1:
            return KI_NUMPAD1;
            break;
        case SFMLK_KP_2:
            return KI_NUMPAD2;
            break;
        case SFMLK_KP_3:
            return KI_NUMPAD3;
            break;
        case SFMLK_KP_4:
            return KI_NUMPAD4;
            break;
        case SFMLK_KP_5:
            return KI_NUMPAD5;
            break;
        case SFMLK_KP_6:
            return KI_NUMPAD6;
            break;
        case SFMLK_KP_7:
            return KI_NUMPAD7;
            break;
        case SFMLK_KP_8:
            return KI_NUMPAD8;
            break;
        case SFMLK_KP_9:
            return KI_NUMPAD9;
            break;
        case SFMLK_KP_ENTER:
            return KI_NUMPADENTER;
            break;
        case SFMLK_KP_MULTIPLY:
            return KI_MULTIPLY;
            break;
        case SFMLK_KP_PLUS:
            return KI_ADD;
            break;
        case SFMLK_KP_MINUS:
            return KI_SUBTRACT;
            break;
        case SFMLK_KP_PERIOD:
            return KI_DECIMAL;
            break;
        case SFMLK_KP_DIVIDE:
            return KI_DIVIDE;
            break;
        case SFMLK_KP_EQUALS:
            return KI_OEM_NEC_EQUAL;
            break;
        case SFMLK_BACKSPACE:
            return KI_BACK;
            break;
        case SFMLK_TAB:
            return KI_TAB;
            break;
        case SFMLK_CLEAR:
            return KI_CLEAR;
            break;
        case SFMLK_RETURN:
            return KI_RETURN;
            break;
        case SFMLK_PAUSE:
            return KI_PAUSE;
            break;
        case SFMLK_CAPSLOCK:
            return KI_CAPITAL;
            break;
        case SFMLK_PAGEUP:
            return KI_PRIOR;
            break;
        case SFMLK_PAGEDOWN:
            return KI_NEXT;
            break;
        case SFMLK_END:
            return KI_END;
            break;
        case SFMLK_HOME:
            return KI_HOME;
            break;
        case SFMLK_LEFT:
            return KI_LEFT;
            break;
        case SFMLK_UP:
            return KI_UP;
            break;
        case SFMLK_RIGHT:
            return KI_RIGHT;
            break;
        case SFMLK_DOWN:
            return KI_DOWN;
            break;
        case SFMLK_INSERT:
            return KI_INSERT;
            break;
        case SFMLK_DELETE:
            return KI_DELETE;
            break;
        case SFMLK_HELP:
            return KI_HELP;
            break;
        case SFMLK_F1:
            return KI_F1;
            break;
        case SFMLK_F2:
            return KI_F2;
            break;
        case SFMLK_F3:
            return KI_F3;
            break;
        case SFMLK_F4:
            return KI_F4;
            break;
        case SFMLK_F5:
            return KI_F5;
            break;
        case SFMLK_F6:
            return KI_F6;
            break;
        case SFMLK_F7:
            return KI_F7;
            break;
        case SFMLK_F8:
            return KI_F8;
            break;
        case SFMLK_F9:
            return KI_F9;
            break;
        case SFMLK_F10:
            return KI_F10;
            break;
        case SFMLK_F11:
            return KI_F11;
            break;
        case SFMLK_F12:
            return KI_F12;
            break;
        case SFMLK_F13:
            return KI_F13;
            break;
        case SFMLK_F14:
            return KI_F14;
            break;
        case SFMLK_F15:
            return KI_F15;
            break;
        case SFMLK_NUMLOCKCLEAR:
            return KI_NUMLOCK;
            break;
        case SFMLK_PRINTSCREEN:
            return KI_SNAPSHOT;
            break;
        case SFMLK_SCROLLLOCK:
            return KI_SCROLL;
            break;
        case SFMLK_LSHIFT:
            return KI_LSHIFT;
            break;
        case SFMLK_RSHIFT:
            return KI_RSHIFT;
            break;
        case SFMLK_LCTRL:
            return KI_LCONTROL;
            break;
        case SFMLK_RCTRL:
            return KI_RCONTROL;
            break;
        case SFMLK_LALT:
            return KI_LMENU;
            break;
        case SFMLK_RALT:
            return KI_RMENU;
            break;
        case SFMLK_LGUI:
            return KI_LMETA;
            break;
        case SFMLK_RGUI:
            return KI_RMETA;
            break;
        //case SFMLK_LSUPER:
        //   return KI_LWIN;
        //    break;
        //case SFMLK_RSUPER:
        //    return KI_RWIN;
        //    break;
        default:
            return KI_UNKNOWN;
            break;
    }
}
*/

int RmlSFML2SystemInterface::TranslateMouseButton(sf::Uint8 button){
	DKDEBUGFUNC(button);
    switch(button){
        case SFML_BUTTON_LEFT:
            return 0;
        case SFML_BUTTON_RIGHT:
            return 1;
        case SFML_BUTTON_MIDDLE:
            return 2;
        case SFML_BUTTON(3):
            return 3;
        case SFML_BUTTON(4):
            return 4;
        case SFML_BUTTON(5):
            return 5;
        case SFML_BUTTON(6):
            return 6;
        default:
            return 99; //FIXME
    }
}

int RmlSFML2SystemInterface::GetKeyModifiers(){
	DKDEBUGFUNC();
    SFML_Keymod sdlMods = SFML_GetModState();
    int retval = 0;
    if(sdlMods & KMOD_CTRL)
        retval |= Rml::Input::KM_CTRL;
    if(sdlMods & KMOD_SHIFT)
        retval |= Rml::Input::KM_SHIFT;
    if(sdlMods & KMOD_ALT)
        retval |= Rml::Input::KM_ALT;
	if(sdlMods & KMOD_NUM)
        retval |= Rml::Input::KM_NUMLOCK;
    return retval;
}

double RmlSFML2SystemInterface::GetElapsedTime(){
	//DKDEBUGFUNC();
	return (float)SFML_GetTicks() / 1000;
}

bool RmlSFML2SystemInterface::LogMessage(Rml::Log::Type type, const Rml::String& message){
	//DKDEBUGFUNC(type, message);
	if(has(message,"Loaded font face"))
		type = Rml::Log::LT_DEBUG;
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
		DKINFO("[Rml] "+DKString(message)+"\n");
        break;
	};
	return true;
};
