#include "DKRockettoRML.h"

//////////////////////////////////////////////////////////////
void DKRocketToRML::toRml(const DKString& html, DKString& rml)
{
	rml = html;

	//Rocket doesn't like <!DOCTYPE html> tags
	replace(rml, "<!DOCTYPE html>", "");

	//Rocket doesn't like <meta> tags
	replace(rml, "<meta name=\"referrer\" content=\"no-referrer\"></meta>", "");

	//Add DKRocket.css
	replace(rml, "<link rel=\"stylesheet\" type=\"text/css\" href=\"DKRocket/DK.css\"></link>",
					"<link rel=\"stylesheet\" type=\"text/css\" href=\"DKRocket/DK.css\"></link>\n"
					"<link rel=\"stylesheet\" type=\"text/css\" href=\"DKRocket/DKRocket.css\"></link>");

	//Convert style sheets to rcss
	replace(rml, "type=\"text/css\"", "type=\"text/rcss\""); 
}
