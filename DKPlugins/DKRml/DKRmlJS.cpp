#ifdef USE_DKDuktape
#include "DKRml/DKRml.h"
#include "DKRml/DKRmlJS.h"

bool DKRmlJS::Init() {
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKRml_DebuggerOff", DKRmlJS::DebuggerOff);
	DKDuktape::AttachFunction("CPP_DKRml_DebuggerOn", DKRmlJS::DebuggerOn);
	DKDuktape::AttachFunction("CPP_DKRml_DebuggerToggle", DKRmlJS::DebuggerToggle);
	DKDuktape::AttachFunction("CPP_DKRml_LoadUrl", DKRmlJS::LoadUrl);
	DKDuktape::AttachFunction("CPP_DKRml_PostProcess", DKRmlJS::PostProcess);
	return true;
}

int DKRmlJS::DebuggerOff(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKRml::Get()->DebuggerOff();
	return false;
}

int DKRmlJS::DebuggerOn(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKRml::Get()->DebuggerOn();
	return false;
}

int DKRmlJS::DebuggerToggle(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKRml::Get()->DebuggerToggle();
	return true;
}

int DKRmlJS::LoadUrl(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if (!DKRml::Get()->LoadUrl(file)) { return 0; }
	return true;
}

int DKRmlJS::PostProcess(duk_context* ctx) {
	Rml::ElementList elements;
	DKRml::Get()->document->GetElementsByTagName(elements, "body");
	if(!elements[0])
		return DKERROR("body element invalid\n");
	DKRml::Get()->dkHtmlToRml.PostProcess(elements[0]);
	return true;
}

#endif //USE_DKDuktape