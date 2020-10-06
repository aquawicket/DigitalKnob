#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDuktapeJS_H
#define DKDuktapeJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////
class DKDuktapeJS : public DKObjectT<DKDuktapeJS>
{
public:
	bool Init();
	
	//FIXME: remove the DK prefix from these functions
	static int _DKDEBUGFUNC(duk_context* ctx);
	static int _DKDEBUGVARS(duk_context* ctx);
	static int _AddEvent(duk_context* ctx);
	static int _Available(duk_context* ctx);
	static int _Close(duk_context* ctx);
	static int _Create(duk_context* ctx);
	static int _LoadPlugin(duk_context* ctx);
	static int _RemoveEvent(duk_context* ctx);
	static int _RemoveEvents(duk_context* ctx);
	static int _SendEvent(duk_context* ctx);
	static int _Valid(duk_context* ctx);
	static int _SetLog(duk_context* ctx);
	
	static int Beep(duk_context* ctx);
	static int CallFunc(duk_context* ctx);
	static int CallLoops(duk_context* ctx);
	static int ClearEvents(duk_context* ctx);
	static int ClickImage(duk_context* ctx);
	static int CpuUsed(duk_context* ctx);
	static int CpuUsedByApp(duk_context* ctx);
	static int Crash(duk_context* ctx);
	static int DoFrame(duk_context* ctx);
	static int DoubleClick(duk_context* ctx);
	static int DumpError(duk_context* ctx);
	static int Execute(duk_context* ctx);
	static int Exit(duk_context* ctx);
	static int GetArgs(duk_context* ctx);
	static int GetBrowser(duk_context* ctx);
	static int GetClipboard(duk_context* ctx);
	static int GetData(duk_context* ctx);
	static int GetDate(duk_context* ctx);
	static int GetEvents(duk_context* ctx);
	static int GetFps(duk_context* ctx);
	static int GetFramerate(duk_context* ctx);
	static int GetFrames(duk_context* ctx);
	static int GetFunctions(duk_context* ctx);
	static int GetId(duk_context* ctx);
	static int GetJSEngine(duk_context* ctx);
	static int GetKey(duk_context* ctx);
	static int GetLocalIP(duk_context* ctx);
	static int GetMouseX(duk_context* ctx);
	static int GetMouseY(duk_context* ctx);
	static int GetOS(duk_context* ctx);
	static int GetObjects(duk_context* ctx);
	static int GetPixelUnderMouse(duk_context* ctx);
	static int GetProcessList(duk_context* ctx);
	static int GetScreenHeight(duk_context* ctx);
	static int GetScreenWidth(duk_context* ctx);
	static int GetTicks(duk_context* ctx);
	static int GetTime(duk_context* ctx);
	static int GetType(duk_context* ctx);
	static int GetUsername(duk_context* ctx);
	static int GetValue(duk_context* ctx);
	static int GetVolume(duk_context* ctx);
	static int HideConsole(duk_context* ctx);
	static int IE(duk_context* ctx);
	static int Include(duk_context* ctx);
	static int KeyIsDown(duk_context* ctx);
	static int LeftClick(duk_context* ctx);
	static int LogGuiConsole(duk_context* ctx);
	static int LowPowerMonitor(duk_context* ctx);
	static int MessageBox(duk_context* ctx);
	static int MouseToImage(duk_context* ctx);
	static int PhysicalMemory(duk_context* ctx);
	static int PhysicalMemoryUsed(duk_context* ctx);
	static int PhysicalMemoryUsedByApp(duk_context* ctx);
	static int PressKey(duk_context* ctx);
	static int QueueDuktape(duk_context* ctx);
	static int ReleaseKey(duk_context* ctx);
	static int Reload(duk_context* ctx);
	static int RightClick(duk_context* ctx);
	static int Run(duk_context* ctx);
	static int RunDuktape(duk_context* ctx);
	static int SetBrightness(duk_context* ctx);
	static int SetClipboard(duk_context* ctx);
	static int SetClipboardFiles(duk_context* ctx);
	static int SetClipboardImage(duk_context* ctx);
	static int SetCursorPos(duk_context* ctx);
	static int SetFramerate(duk_context* ctx);
	static int SetVolume(duk_context* ctx);
	static int ShowConsole(duk_context* ctx);
	static int Sleep(duk_context* ctx);
	static int StopPropagation(duk_context* ctx);
	static int StrokeKey(duk_context* ctx);
	static int System(duk_context* ctx);
	static int TurnOffMonitor(duk_context* ctx);
	static int TurnOnMonitor(duk_context* ctx);
	static int Value(duk_context* ctx);
	static int VirtualMemory(duk_context* ctx);
	static int VirtualMemoryUsed(duk_context* ctx);
	static int VirtualMemoryUsedByApp(duk_context* ctx);
	static int WaitForImage(duk_context* ctx);

	//screen
	static int availTop(duk_context* ctx);
	static int availLeft(duk_context* ctx);
	static int availHeight(duk_context* ctx);
	static int availWidth(duk_context* ctx);
	static int colorDepth(duk_context* ctx);
	static int height(duk_context* ctx);
	static int left(duk_context* ctx);
	static int orientation(duk_context* ctx);
	static int pixelDepth(duk_context* ctx);
	static int top(duk_context* ctx);
	static int width(duk_context* ctx);
	static int mozEnabled(duk_context* ctx);
	static int mozBrightness(duk_context* ctx);
};


REGISTER_OBJECT(DKDuktapeJS, true)

#endif //DKDuktapeJS_H
#endif //USE_DKDuktape