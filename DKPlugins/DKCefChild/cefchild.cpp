#define DKCefChild
#include "DK.h"
#include "DKCefApp.h"
#include "include/cef_app.h"
#include "include/cef_sandbox_win.h"

int main(int argc, char* argv[])
{
#ifdef WIN32
	CefMainArgs main_args;
#else
	CefMainArgs main_args(argc, argv);
#endif

	void* sandbox_info = NULL;
	CefScopedSandboxInfo scoped_sandbox;
	sandbox_info = scoped_sandbox.sandbox_info();

	CefRefPtr<DKCefApp> app(new DKCefApp);
	return CefExecuteProcess(main_args, app.get(), sandbox_info);
}