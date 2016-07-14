#include "include/cef_app.h"

int main(int argc, char* argv[])
{
	CefMainArgs main_args(argc, argv);

	// Execute the secondary process.
	return CefExecuteProcess(main_args, NULL, NULL);
}
