#ifdef USE_DKDuktape 
#include "DKOSGModel/DKOSGModel.h"
#include "DKOSGModel/DKOSGModelJS.h"
#include "DKOSGWindow/DKOSGWindow.h"

bool DKOSGModelJS::Init(){
	//DKDuktape::AttachFunction("DKOSGModel_NewModel", DKOSGModelJS::NewModel, 1);
	return true;
}

/*
int DKOSGModelJS::NewModel(duk_context* ctx){
	DKString file = duk_require_string(ctx, 0);
	DKCreate("DKOSGModel,,DKOSGWindow,"+file);
	return 1;
}
*/

#endif //USE_DKDuktape
