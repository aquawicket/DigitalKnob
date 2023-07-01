#include "DKRmlLocation/DKRmlLocation.h"
#include "DKRmlDocument/DKRmlDocument.h"

// [LegacyUnforgeable] stringifier attribute USVString href;
void DKRmlLocation::href(const USVString& href) { 	// setter
	DKLocation::href(href);
	_dkRmlInterface->LoadUrl(href);
		
	DKINFO("load_event!\n");
	DKEvent load_event("load", "");
	DKRmlDocument* dkRmlDocument = DKRmlDocument::instance(_dkRmlInterface, _dkRmlEventListener);
	dkRmlDocument->dispatchEvent(&load_event);
} 