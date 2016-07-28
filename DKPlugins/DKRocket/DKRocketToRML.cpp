#include "DKRockettoRML.h"
#include "DKXml.h"
#include "DKLog.h"

///////////////////////////////////////////////////////////////////
bool DKRocketToRML::IndexToRml(const DKString& html, DKString& rml)
{
	rml = html;
	replace(rml, "<!DOCTYPE html>", ""); //Rocket doesn't like <!DOCTYPE html> tags
	if(!has(rml,"html")){ rml = "<html>\n"+rml+"</html>"; }
	replace(rml, "type=\"text/css\"", "type=\"text/rcss\""); //Convert style sheets to rcss

	DKXml xml;
	if(!xml.LoadDocumentFromString(rml)){ return false; }

	//xml.RemoveNodes("//meta");  //Rocket doesn't like <meta> tags
	if(!xml.FindNode("//head")){ DKLog("No head tag\n", DKERROR); }
	if(!xml.FindNode("//body")){ DKLog("No body tag\n", DKERROR); }

	xml.PrependNode("//head","link");
	xml.SetAttributes("//head/link[1]","rel","stylesheet");
	xml.SetAttributes("//head/link[1]","type","text/rcss");
	xml.SetAttributes("//head/link[1]","href","DKRocket/DKRocket.css");

	xml.SaveDocumentToString(rml);

	HtmlToRml(rml, rml);
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKRocketToRML::HtmlToRml(const DKString& html, DKString& rml)
{
	rml = html;

	// :rgba(r,g,b,a)  <- convert a to 0-255
	size_t end = 0;
	while(has(rml,":rgba(")){
		size_t temp = rml.find(":rgba(",end);
        if(temp == std::string::npos){return true;}
		size_t start = rml.find(",",temp);
		start = rml.find(",",start+1);
		start = rml.find(",",start+1);
		end = rml.find(")",start);
		if(end == std::string::npos){end = rml.size();}

		DKString out = rml.substr(start+1, end-start-1);
		float var = toFloat(out);

		if(var){
			int final = (int)(var * 255);
			rml.replace(start+1,end-start-1,toString(final));   
			//return true;
			continue;
		}
		DKLog("Error: in HtmlToRml()\n", DKERROR);
		return false;
	}

	DKLog("\n##################### RML ####################\n",DKINFO);
	DKLog(rml+"\n",DKINFO);
	DKLog("\n##############################################\n\n",DKINFO);
	return true;
}
