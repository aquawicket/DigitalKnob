#include "DKRockettoRML.h"
#include "DKRocket.h"
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
	if(!xml.FindNode("//head")){
		xml.PrependNode("//html", "head");
	}
	if (!xml.FindNode("//body")) {
		DKLog("No body tag\n", DKERROR);
		xml.PrependNode("//html", "body");
		//todo, we need to move the rest of the content into the body node.
	}

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

	

	////////////////////////////////////////////////////////
	DKXml xml;
	if(!xml.LoadDocumentFromString(rml)){ return false; }
	
	DKXmlNodes nodes;
	xml.GetNodes("//a", nodes);
	for(unsigned int i = 0; i<nodes.size(); ++i){
		DKLog(DKString(nodes[i].node().name())+"\n", DKINFO);
		DKString value;
		xml.GetAttribute(nodes[i].node(),"href",value);
		if(!value.empty()){
			DKLog("value="+value+"\n", DKINFO);
			DKString string = "color:rgb(0,0,255);text-decoration:underline;";
			xml.SetAttribute(nodes[i].node(),"style",string);
			
			//TODO - this needs to exist in the DOM, so post process it after it's added.
			//AddEvent(id, "click", &DKWidget::Hyperlink, this);
		}
	}
	xml.SaveDocumentToString(rml);
	//////////////////////////////////////////////////////

	DKLog("\n##################### RML ####################\n",DKINFO);
	DKLog(rml+"\n",DKINFO);
	DKLog("\n##############################################\n\n",DKINFO);
	return true;
}

/////////////////////////////////////////////
void DKRocketToRML::Hyperlink(DKEvent* event)
{
	DKString id = event->GetId();
	DKRocket* dkRocket = DKRocket::Get("");
	Rocket::Core::ElementDocument* doc = dkRocket->GetDocument();
	Rocket::Core::Element* aElement = doc->GetElementById(id.c_str());

	DKString value = aElement->GetAttribute("href")->Get<Rocket::Core::String>().CString();
	DKLog("DKWidget::Hyperlink: " + value + "\n", DKINFO);
	DKUtil::Run(value);
}
