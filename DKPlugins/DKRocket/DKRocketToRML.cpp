#include "DKRocketToRML.h"
#include "DK/DKLog.h"
#include "DKDuktape/DKDuktape.h"
#include "DKXml/DKXml.h"


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

	
	/*
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
	*/

	//DKLog("\n##################### RML ####################\n", DKDEBUG);
	//DKLog(rml+"\n", DKDEBUG);
	//DKLog("\n##############################################\n\n", DKDEBUG);
	return true;
}

/////////////////////////////////////////////
bool DKRocketToRML::Hyperlink(DKEvent* event)
{
	DKString id = event->GetId();
	DKRocket* dkRocket = DKRocket::Get("");
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	Rocket::Core::Element* aElement = doc->GetElementById(id.c_str());

	DKString value = aElement->GetAttribute("href")->Get<Rocket::Core::String>().CString();
	DKLog("DKWidget::Hyperlink: "+value+"\n", DKINFO);
	DKUtil::Run(value, "");
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKRocketToRML::IndexToRml(const DKString& html, DKString& rml)
{
	rml = html;
	rml = "<rml>\n"+rml+"</rml>";
	replace(rml, "<!DOCTYPE html>", ""); //Rocket doesn't like <!DOCTYPE html> tags

	//Rocket does not recognize favicons, TODO
	replace(rml, "<link rel=\"shortcut icon\" id=\"favicon.ico\" href=\"favicon.ico\"></link>", "");

	DKXml xml;
	if(!xml.LoadDocumentFromString(rml)){ return false; }

	if(!xml.FindNode("//head")){
		xml.PrependNode("//rml", "head");
	}
	if (!xml.FindNode("//body")) {
		DKLog("No body tag\n", DKERROR);
		xml.PrependNode("//html", "body");
		//todo, we need to move the rest of the content into the body node.
	}

	//Add the base DKRocket.css stylesheet
	xml.PrependNode("//head","link");
	xml.SetAttributes("//head/link[1]","rel","stylesheet");
	xml.SetAttributes("//head/link[1]","type","text/css");
	xml.SetAttributes("//head/link[1]","href","DKRocket/DKRocket.css");

	//Rocket cannot read nodes outside of the body, so add an html node we can work with.
	xml.PrependNode("//body", "html"); 

	xml.SetAttributes("//body","id","body");
	xml.SetAttributes("//html","id","html");

	xml.SaveDocumentToString(rml);

	HtmlToRml(rml, rml);
	return true;
}

///////////////////////////////////////////////////////////////
bool DKRocketToRML::PostProcess(Rocket::Core::Element* element)
{
	DKLog("DKRocketToRML::PostProcess()\n", DKDEBUG);
	if(!element){
		DKLog("DKRocketToRML::PostProcess(): element invalid", DKWARN);
		return false;
	}

	// Create cef contexts for iFrames
	Rocket::Core::ElementList iframes;
	Rocket::Core::ElementUtilities::GetElementsByTagName(iframes, element, "iframe");
	for(unsigned int i=0; i<iframes.size(); ++i){
		if(iframes[i]->HasChildNodes()){ continue; }
		DKString id = iframes[i]->GetId().CString();
		DKString iTop = toString(iframes[i]->GetAbsoluteTop());
		DKString iLeft = toString(iframes[i]->GetAbsoluteLeft());
		DKString iWidth = toString(iframes[i]->GetClientWidth());
		DKString iHeight = toString(iframes[i]->GetClientHeight());

		DKString url;
		if(!iframes[i]->GetAttribute("src")){
			 DKLog("DKRocketToRML::PostProcess(): iframe has no source tag\n", DKWARN);
			 return false;
		}
		else{
			url = iframes[i]->GetAttribute("src")->Get<Rocket::Core::String>().CString();
		}
		//DKLog("DKCef Calculated: top:"+iTop+" left:"+iLeft+" width:"+iWidth+" height:"+iHeight+" \n", DKINFO);
		
		//TODO
		//DKCreate("DKRocketIframe,"+id+","+iTop+","+iLeft+","+iWidth+","+iHeight);
		
		DKClass::DKCreate("DKCef");

		DKEvent::AddEvent(id, "resize", &DKRocketToRML::ResizeIframe, this);
		DKEvent::AddEvent(id, "mouseover", &DKRocketToRML::ResizeIframe, this);

		Rocket::Core::Element* cef_texture = element->GetOwnerDocument()->CreateElement("img");
		DKString cef_id = "iframe_"+id;
		cef_texture->SetAttribute("id", cef_id.c_str());

		//This is what RocketSDL2Renderer::LoadTexture and RocketSDL2Renderer::RenderGeometry
		//use to detect if the texture is a cef image. If will contain a iframe_ in the src.
		cef_texture->SetAttribute("src", cef_id.c_str());
		
		//cef_texture->SetProperty("top", "0px");
		//cef_texture->SetProperty("bottom", "0px");
		//cef_texture->SetProperty("left", "0px");
		//cef_texture->SetProperty("right", "0px");
		cef_texture->SetProperty("width", "100%");
		cef_texture->SetProperty("height", "100%");
		
		iframes[i]->AppendChild(cef_texture);
		DKString str = id+","+iTop+","+iLeft+","+iWidth+","+iHeight+","+url;
		DKClass::CallFunc("DKCef::NewBrowser", &str, NULL);
	}

	// <a> tags with href attribute
	Rocket::Core::ElementList aElements;
	Rocket::Core::ElementUtilities::GetElementsByTagName(aElements, element, "a");
	for(unsigned int i=0; i<aElements.size(); ++i){
		if(aElements[i]->HasAttribute("href")){
			aElements[i]->SetProperty("color", "rgb(0,0,255)");
			aElements[i]->SetProperty("text-decoration", "underline");
			DKString id = aElements[i]->GetId().CString();
			DKEvent::AddEvent(id, "click", &DKRocketToRML::Hyperlink, this);
		}
	}

	// <audio> tags
	Rocket::Core::ElementList audios;
	Rocket::Core::ElementUtilities::GetElementsByTagName(audios, element, "audio");
	for(unsigned int i=0; i<audios.size(); ++i){
		DKClass::DKCreate("DKRocketAudio/DKRocketAudio.js");
		Rocket::Core::ElementList sources;
		Rocket::Core::ElementUtilities::GetElementsByTagName(sources, audios[i], "source");
		for(unsigned int s=0; s<sources.size(); ++s){
			DKString file = sources[s]->GetAttribute("src")->Get<Rocket::Core::String>().CString();
			DKString rval;
			DKDuktape::RunDuktape("DKRocketAudio_Open(\""+file+"\");", rval);
		}
	}

	return true;
}

////////////////////////////////////////////////
bool DKRocketToRML::ResizeIframe(DKEvent* event)
{
	//DKLog("DKWidget::ResizeIframe", DKDEBUG);
	DKString id = event->GetId();
	DKRocket* dkRocket = DKRocket::Get("");
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	Rocket::Core::Element* iframe = doc->GetElementById(id.c_str());

	DKString iTop = toString(iframe->GetAbsoluteTop());
	DKString iLeft = toString(iframe->GetAbsoluteLeft());
	DKString iWidth = toString(iframe->GetClientWidth());
	DKString iHeight = toString(iframe->GetClientHeight());
	DKString data = iTop+","+iLeft+","+iWidth+","+iHeight;
	DKClass::CallFunc("DKSDLCef::OnResize", &data, NULL); //call OnResize in DKCef window handler
	return true;
}