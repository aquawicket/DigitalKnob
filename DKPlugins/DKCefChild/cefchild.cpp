#define DKCefChild
#include "DK.h"
#include "DKCefApp.h"
#include "include/cef_app.h"

#ifndef LINUX
#include "include/cef_sandbox_win.h"
#endif

int main(int argc, char* argv[])
{
#ifdef WIN32
	CefMainArgs main_args;
#else
	CefMainArgs main_args(argc, argv);
#endif

	void* sandbox_info = NULL;
#ifndef LINUX
	CefScopedSandboxInfo scoped_sandbox;
	sandbox_info = scoped_sandbox.sandbox_info();
#endif

	CefRefPtr<DKCefApp> app(new DKCefApp);
	return CefExecuteProcess(main_args, app.get(), sandbox_info);
}