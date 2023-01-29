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

WARNING_DISABLE
#include <RmlUi/Core.h>
WARNING_ENABLE

#include "DKSDLRml/DKSDLRmlSystem.h"


Rml::Input::KeyIdentifier RmlSDL2SystemInterface::TranslateKey(SDL_Keycode sdlkey){
	DKDEBUGFUNC(sdlkey);
    using namespace Rml::Input;
    switch(sdlkey) {
        case SDLK_UNKNOWN:
            return KI_UNKNOWN;
        case SDLK_SPACE:
            return KI_SPACE;
        case SDLK_0:
            return KI_0;
        case SDLK_1:
            return KI_1;
        case SDLK_2:
            return KI_2;
        case SDLK_3:
            return KI_3;
        case SDLK_4:
            return KI_4;
        case SDLK_5:
            return KI_5;
        case SDLK_6:
            return KI_6;
        case SDLK_7:
            return KI_7;
        case SDLK_8:
            return KI_8;
        case SDLK_9:
            return KI_9;
        case SDLK_a:
            return KI_A;
        case SDLK_b:
            return KI_B;
        case SDLK_c:
            return KI_C;
        case SDLK_d:
            return KI_D;
        case SDLK_e:
            return KI_E;
        case SDLK_f:
            return KI_F;
        case SDLK_g:
            return KI_G;
        case SDLK_h:
            return KI_H;
        case SDLK_i:
            return KI_I;
        case SDLK_j:
            return KI_J;
        case SDLK_k:
            return KI_K;
        case SDLK_l:
            return KI_L;
        case SDLK_m:
            return KI_M;
        case SDLK_n:
            return KI_N;
        case SDLK_o:
            return KI_O;
        case SDLK_p:
            return KI_P;
        case SDLK_q:
            return KI_Q;
        case SDLK_r:
            return KI_R;
        case SDLK_s:
            return KI_S;
        case SDLK_t:
            return KI_T;
        case SDLK_u:
            return KI_U;
        case SDLK_v:
            return KI_V;
        case SDLK_w:
            return KI_W;
        case SDLK_x:
            return KI_X;
        case SDLK_y:
            return KI_Y;
        case SDLK_z:
            return KI_Z;
        case SDLK_SEMICOLON:
            return KI_OEM_1;
        case SDLK_QUOTE:
            return KI_OEM_7;
        case SDLK_EQUALS:
            return KI_OEM_PLUS;
        case SDLK_PLUS:
            return KI_OEM_PLUS;
        case SDLK_COMMA:
            return KI_OEM_COMMA;
        case SDLK_MINUS:
            return KI_OEM_MINUS;
        case SDLK_PERIOD:
            return KI_OEM_PERIOD;
        case SDLK_SLASH:
            return KI_OEM_2;
        case SDLK_BACKQUOTE:
            return KI_OEM_3;
        case SDLK_LEFTBRACKET:
            return KI_OEM_4;
        case SDLK_BACKSLASH:
            return KI_OEM_5;
        case SDLK_RIGHTBRACKET:
            return KI_OEM_6;
        case SDLK_QUOTEDBL:
            return KI_OEM_7;
        case SDLK_ESCAPE:
            return KI_ESCAPE;
        case SDLK_KP_0:
            return KI_NUMPAD0;
        case SDLK_KP_1:
            return KI_NUMPAD1;
        case SDLK_KP_2:
            return KI_NUMPAD2;
        case SDLK_KP_3:
            return KI_NUMPAD3;
        case SDLK_KP_4:
            return KI_NUMPAD4;
        case SDLK_KP_5:
            return KI_NUMPAD5;
        case SDLK_KP_6:
            return KI_NUMPAD6;
        case SDLK_KP_7:
            return KI_NUMPAD7;
        case SDLK_KP_8:
            return KI_NUMPAD8;
        case SDLK_KP_9:
            return KI_NUMPAD9;
        case SDLK_KP_ENTER:
            return KI_NUMPADENTER;
        case SDLK_KP_MULTIPLY:
            return KI_MULTIPLY;
        case SDLK_KP_PLUS:
            return KI_ADD;
        case SDLK_KP_MINUS:
            return KI_SUBTRACT;
        case SDLK_KP_PERIOD:
            return KI_DECIMAL;
        case SDLK_KP_DIVIDE:
            return KI_DIVIDE;
        case SDLK_KP_EQUALS:
            return KI_OEM_NEC_EQUAL;
        case SDLK_BACKSPACE:
            return KI_BACK;
        case SDLK_TAB:
            return KI_TAB;
        case SDLK_CLEAR:
            return KI_CLEAR;
        case SDLK_RETURN:
            return KI_RETURN;
        case SDLK_PAUSE:
            return KI_PAUSE;
        case SDLK_CAPSLOCK:
            return KI_CAPITAL;
        case SDLK_PAGEUP:
            return KI_PRIOR;
        case SDLK_PAGEDOWN:
            return KI_NEXT;
        case SDLK_END:
            return KI_END;
        case SDLK_HOME:
            return KI_HOME;
        case SDLK_LEFT:
            return KI_LEFT;
        case SDLK_UP:
            return KI_UP;
        case SDLK_RIGHT:
            return KI_RIGHT;
        case SDLK_DOWN:
            return KI_DOWN;
        case SDLK_INSERT:
            return KI_INSERT;
        case SDLK_DELETE:
            return KI_DELETE;
        case SDLK_HELP:
            return KI_HELP;
        case SDLK_F1:
            return KI_F1;
        case SDLK_F2:
            return KI_F2;
        case SDLK_F3:
            return KI_F3;
        case SDLK_F4:
            return KI_F4;
        case SDLK_F5:
            return KI_F5;
        case SDLK_F6:
            return KI_F6;
        case SDLK_F7:
            return KI_F7;
        case SDLK_F8:
            return KI_F8;
        case SDLK_F9:
            return KI_F9;
        case SDLK_F10:
            return KI_F10;
        case SDLK_F11:
            return KI_F11;
        case SDLK_F12:
            return KI_F12;
        case SDLK_F13:
            return KI_F13;
        case SDLK_F14:
            return KI_F14;
        case SDLK_F15:
            return KI_F15;
        case SDLK_NUMLOCKCLEAR:
            return KI_NUMLOCK;
        case SDLK_PRINTSCREEN:
            return KI_SNAPSHOT;
        case SDLK_SCROLLLOCK:
            return KI_SCROLL;
        case SDLK_LSHIFT:
            return KI_LSHIFT;
        case SDLK_RSHIFT:
            return KI_RSHIFT;
        case SDLK_LCTRL:
            return KI_LCONTROL;
        case SDLK_RCTRL:
            return KI_RCONTROL;
        case SDLK_LALT:
            return KI_LMENU;
        case SDLK_RALT:
            return KI_RMENU;
        case SDLK_LGUI:
            return KI_LMETA;
        case SDLK_RGUI:
            return KI_RMETA;
		/*case SDLK_LSUPER:
            return KI_LWIN;
        case SDLK_RSUPER:
            return KI_RWIN;
		*/
        default:
            return KI_UNKNOWN;
    }
}

int RmlSDL2SystemInterface::TranslateMouseButton(Uint8 button){
	DKDEBUGFUNC(button);
    switch(button){
        case SDL_BUTTON_LEFT:
            return 0;
        case SDL_BUTTON_RIGHT:
            return 1;
        case SDL_BUTTON_MIDDLE:
            return 2;
        case SDL_BUTTON(3):
            return 3;
        case SDL_BUTTON(4):
            return 4;
        case SDL_BUTTON(5):
            return 5;
        case SDL_BUTTON(6):
            return 6;
        default:
            return 99; //FIXME
    }
}

int RmlSDL2SystemInterface::GetKeyModifiers(){
	DKDEBUGFUNC();
    SDL_Keymod sdlMods = SDL_GetModState();
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

double RmlSDL2SystemInterface::GetElapsedTime(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	return (float)SDL_GetTicks() / 1000;
}

bool RmlSDL2SystemInterface::LogMessage(Rml::Log::Type type, const Rml::String& message){
	//DKDEBUGFUNC(type, message);  //EXCESSIVE LOGGING
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
			DKASSERT("[Rml] "+DKString(message)+"\n");
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
			DKVERBOSE("[Rml] "+DKString(message)+"\n");
			break;
	};
	return true;
};
