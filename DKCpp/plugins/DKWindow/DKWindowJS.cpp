/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
* Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
=======
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
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
#ifdef HAVE_DKDuktape 
#include "DKWindow/DKWindow.h"
#include "DKWindow/DKWindowJS.h"


bool DKWindowJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKWindow_TestInt", DKWindowJS::TestInt);
	DKDuktape::AttachFunction("CPP_DKWindow_TestString", DKWindowJS::TestString);
	DKDuktape::AttachFunction("CPP_DKWindow_TestReturnInt", DKWindowJS::TestReturnInt);
	DKDuktape::AttachFunction("CPP_DKWindow_TestReturnString", DKWindowJS::TestReturnString);

	DKDuktape::AttachFunction("CPP_DKWindow_Create", DKWindowJS::Create);
	DKDuktape::AttachFunction("CPP_DKWindow_Fullscreen", DKWindowJS::Fullscreen);
	DKDuktape::AttachFunction("CPP_DKWindow_GetHeight", DKWindowJS::GetHeight);
	DKDuktape::AttachFunction("CPP_DKWindow_GetMouseX", DKWindowJS::GetMouseX);
	DKDuktape::AttachFunction("CPP_DKWindow_GetMouseY", DKWindowJS::GetMouseY);
	DKDuktape::AttachFunction("CPP_DKWindow_GetPixelRatio", DKWindowJS::GetPixelRatio);
	DKDuktape::AttachFunction("CPP_DKWindow_GetWidth", DKWindowJS::GetWidth);
	DKDuktape::AttachFunction("CPP_DKWindow_GetX", DKWindowJS::GetX);
	DKDuktape::AttachFunction("CPP_DKWindow_GetY", DKWindowJS::GetY);
	DKDuktape::AttachFunction("CPP_DKWindow_Hide", DKWindowJS::Hide);
	DKDuktape::AttachFunction("CPP_DKWindow_IsFullscreen", DKWindowJS::IsFullscreen);
	DKDuktape::AttachFunction("CPP_DKWindow_IsVisible", DKWindowJS::IsVisible);
	DKDuktape::AttachFunction("CPP_DKWindow_Maximize", DKWindowJS::Maximize);
	DKDuktape::AttachFunction("CPP_DKWindow_MessageBox", DKWindowJS::MessageBox);
	DKDuktape::AttachFunction("CPP_DKWindow_Minimize", DKWindowJS::Minimize);
	DKDuktape::AttachFunction("CPP_DKWindow_moveTo", DKWindowJS::moveTo);
	DKDuktape::AttachFunction("CPP_DKWindow_resizeTo", DKWindowJS::resizeTo);
	DKDuktape::AttachFunction("CPP_DKWindow_Restore", DKWindowJS::Restore);
	DKDuktape::AttachFunction("CPP_DKWindow_SetHeight", DKWindowJS::SetHeight);
	DKDuktape::AttachFunction("CPP_DKWindow_SetIcon", DKWindowJS::SetIcon);
	DKDuktape::AttachFunction("CPP_DKWindow_SetTitle", DKWindowJS::SetTitle);
	DKDuktape::AttachFunction("CPP_DKWindow_SetWidth", DKWindowJS::SetWidth);
	DKDuktape::AttachFunction("CPP_DKWindow_SetX", DKWindowJS::SetX);
	DKDuktape::AttachFunction("CPP_DKWindow_SetY", DKWindowJS::SetY);
	DKDuktape::AttachFunction("CPP_DKWindow_Show", DKWindowJS::Show);
	DKDuktape::AttachFunction("CPP_DKWindow_Windowed", DKWindowJS::Windowed);
	return true;
}

int DKWindowJS::TestInt(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int input = duk_require_int(ctx, 0);
	int output;
	if(!DKWindow::TestInt(input, output)){ return 0; }
	duk_push_int(ctx, output);
	return 1;
}

int DKWindowJS::TestString(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString input = duk_require_string(ctx, 0);
	DKString output;
	if(!DKWindow::TestString(input, output)){ return 0; }
	duk_push_string(ctx, output.c_str());
	return 1;
}

int DKWindowJS::TestReturnInt(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int rval;
	if(!DKWindow::TestReturnInt(rval)){ return 0; }
	duk_push_int(ctx, rval);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::TestReturnString(duk_context* ctx) {
=======
int DKWindowJS::TestReturnString(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	DKString rval;
	if(!DKWindow::TestReturnString(rval)){ return 0; }
	duk_push_string(ctx, rval.c_str());
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::Create(duk_context* ctx) {
=======
int DKWindowJS::Create(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	if(!DKWindow::Create()){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::Fullscreen(duk_context* ctx) {
=======
int DKWindowJS::Fullscreen(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	if(!DKWindow::Fullscreen()){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::GetHeight(duk_context* ctx) {
=======
int DKWindowJS::GetHeight(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int height;
	if(!DKWindow::GetHeight(height)){ return 0; }
	duk_push_int(ctx, height);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::GetMouseX(duk_context* ctx) {
=======
int DKWindowJS::GetMouseX(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int mouseX;
	if(!DKWindow::GetMouseX(mouseX)){ return 0; }
	duk_push_int(ctx, mouseX);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::GetMouseY(duk_context* ctx) {
=======
int DKWindowJS::GetMouseY(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int mouseY;
	if(!DKWindow::GetMouseY(mouseY)){ return 0; }
	duk_push_int(ctx, mouseY);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::GetPixelRatio(duk_context* ctx) {
=======
int DKWindowJS::GetPixelRatio(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	float ratio;
	if(!DKWindow::GetPixelRatio(ratio)){ return 0; }
	duk_push_number(ctx, ratio);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::GetWidth(duk_context* ctx) {
=======
int DKWindowJS::GetWidth(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int width;
	if(!DKWindow::GetWidth(width)){ return 0; }
	duk_push_int(ctx, width);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::GetX(duk_context* ctx) {
=======
int DKWindowJS::GetX(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int x;
	if(!DKWindow::GetX(x)){ return 0; }
	duk_push_int(ctx, x);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::GetY(duk_context* ctx) {
=======
int DKWindowJS::GetY(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int y;
	if(!DKWindow::GetY(y)){ return 0; }
	duk_push_int(ctx, y);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::Hide(duk_context* ctx) {
=======
int DKWindowJS::Hide(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	if(!DKWindow::Hide()){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::IsFullscreen(duk_context* ctx) {
=======
int DKWindowJS::IsFullscreen(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	bool fullscreen;
	if(!DKWindow::IsFullscreen(fullscreen)){ return 0; }
	duk_push_int(ctx, fullscreen);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::IsVisible(duk_context* ctx) {
=======
int DKWindowJS::IsVisible(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	bool visible;
	if(!DKWindow::IsVisible(visible)){ return 0; } 
	duk_push_int(ctx, visible);
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::Maximize(duk_context* ctx) {
=======
int DKWindowJS::Maximize(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	if(!DKWindow::Maximize()){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::MessageBox(duk_context* ctx) {
=======
int DKWindowJS::MessageBox(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	DKString msg = duk_require_string(ctx, 0);
	if(!DKWindow::MessageBox(msg)){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::Minimize(duk_context* ctx) {
=======
int DKWindowJS::Minimize(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	if(!DKWindow::Minimize()){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::moveTo(duk_context* ctx) {
=======
int DKWindowJS::moveTo(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int x = duk_require_int(ctx, 0);
	int y = duk_require_int(ctx, 1);
	if(!DKWindow::SetX(x)){ return 0; }
	if(!DKWindow::SetY(y)){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::resizeTo(duk_context* ctx) {
=======
int DKWindowJS::resizeTo(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int width = duk_require_int(ctx, 0);
	int height = duk_require_int(ctx, 1);
	if (!DKWindow::SetWidth(width)){ return 0; }
	if (!DKWindow::SetHeight(height)){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::Restore(duk_context* ctx) {
=======
int DKWindowJS::Restore(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	if(!DKWindow::Restore()){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::SetHeight(duk_context* ctx) {
=======
int DKWindowJS::SetHeight(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int height = duk_require_int(ctx, 0);
	if(!DKWindow::SetHeight(height)){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::SetIcon(duk_context* ctx) {
=======
int DKWindowJS::SetIcon(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if (!DKWindow::SetIcon(file)){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::SetTitle(duk_context* ctx) {
=======
int DKWindowJS::SetTitle(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	DKString string = duk_require_string(ctx, 0);
	if(!DKWindow::SetTitle(string)){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::SetWidth(duk_context* ctx) {
=======
int DKWindowJS::SetWidth(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int width = duk_require_int(ctx, 0);
	if(!DKWindow::SetWidth(width)){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::SetX(duk_context* ctx) {
=======
int DKWindowJS::SetX(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int x = duk_require_int(ctx, 0);
	if(!DKWindow::SetX(x)){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::SetY(duk_context* ctx) {
=======
int DKWindowJS::SetY(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	int y = duk_require_int(ctx, 0);
	if(!DKWindow::SetY(y)){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::Show(duk_context* ctx) {
=======
int DKWindowJS::Show(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	if(!DKWindow::Show()){ return 0; }
	return 1;
}

<<<<<<< HEAD:DKPlugins/DKWindow/DKWindowJS.cpp
int DKWindowJS::Windowed(duk_context* ctx) {
=======
int DKWindowJS::Windowed(duk_context* ctx){
>>>>>>> Development:DKCpp/plugins/DKWindow/DKWindowJS.cpp
	DKDEBUGFUNC(ctx);
	if(!DKWindow::Windowed()){ return 0; }
	return 1;
}

#endif //HAVE_DKDuktape
