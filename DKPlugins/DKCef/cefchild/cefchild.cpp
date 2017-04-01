#include "DK.h"
#include "DKCefApp.h"
#include "include/cef_app.h"

int main(int argc, char* argv[])
{
#ifdef WIN32
	CefMainArgs main_args;
#else
	CefMainArgs main_args(argc, argv);
#endif

	//CefRefPtr<DKCefApp> app(new DKCefApp);
	
	// Execute the secondary process.
	return CefExecuteProcess(main_args, NULL, NULL);
}
