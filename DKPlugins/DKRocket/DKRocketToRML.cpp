#include "DKRocketToRML.h"
#include "DK/DKLog.h"
#include "DKDuktape/DKDuktape.h"
#include "DKXml/DKXml.h"
#include "DKCurl/DKCurl.h"
#include "DKRocket/DKRocket.h"

//////////////////////////////////////////////////////////////////
bool DKRocketToRML::HtmlToRml(const DKString& html, DKString& rml)
{
	DKDEBUGFUNC(html, rml);
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
		DKERROR("Error: in HtmlToRml()\n");
		return false;
	}

	
	/*
	////////////////////////////////////////////////////////
	DKXml xml;
	if(!xml.LoadDocumentFromString(rml)){ return false; }
	
	DKXmlNodes nodes;
	xml.GetNodes("//a", nodes);
	for(unsigned int i = 0; i<nodes.size(); ++i){
		DKINFO(DKString(nodes[i].node().name())+"\n");
		DKString value;
		xml.GetAttribute(nodes[i].node(),"href",value);
		if(!value.empty()){
			DKINFO("value="+value+"\n");
			DKString string = "color:rgb(0,0,255);text-decoration:underline;";
			xml.SetAttribute(nodes[i].node(),"style",string);
			
			//TODO - this needs to exist in the DOM, so post process it after it's added.
			//AddEvent(id, "click", &DKWidget::Hyperlink, this);
		}
	}
	xml.SaveDocumentToString(rml);
	//////////////////////////////////////////////////////
	*/

	//DKINFO("\n##################### RML ####################\n");
	//DKINFO(rml+"\n");
	//DKINFO("\n##############################################\n\n");
	return true;
}

/////////////////////////////////////////////
bool DKRocketToRML::Hyperlink(DKEvent* event)
{
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	DKRocket* dkRocket = DKRocket::Get("");
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	Rocket::Core::Element* aElement = doc->GetElementById(id.c_str());

	DKString value = aElement->GetAttribute("href")->Get<Rocket::Core::String>().CString();
	DKINFO("DKWidget::Hyperlink: "+value+"\n");
	DKUtil::Run(value, "");
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKRocketToRML::IndexToRml(const DKString& html, DKString& rml)
{
	DKDEBUGFUNC(html, rml);
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
		DKERROR("No body tag\n");
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
	//xml.SetAttributes("//head","id","head");
	xml.SetAttributes("//html","id","html");

	xml.SaveDocumentToString(rml);

	HtmlToRml(rml, rml);
	return true;
}

///////////////////////////////////////////////////////////////
bool DKRocketToRML::PostProcess(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	processed;
	if(!element){
		DKWARN("DKRocketToRML::PostProcess(): element invalid\n");
		return false;
	}

	// Create cef contexts for iFrames
	Rocket::Core::ElementList iframes;
	Rocket::Core::ElementUtilities::GetElementsByTagName(iframes, element, "iframe");
	for(unsigned int i=0; i<iframes.size(); ++i){
		if(iframes[i]->HasChildNodes()){ continue; }
		DKString id = iframes[i]->GetId().CString();
		if(has(processed, id)){ continue; }
		DKString iTop = toString(iframes[i]->GetAbsoluteTop());
		DKString iLeft = toString(iframes[i]->GetAbsoluteLeft());
		DKString iWidth = toString(iframes[i]->GetClientWidth());
		DKString iHeight = toString(iframes[i]->GetClientHeight());

		DKString url;
		if(!iframes[i]->GetAttribute("src")){ 
			 DKINFO("DKRocketToRML::PostProcess(): iframe has no source tag\n");
			 return false;
		}
		else{
			url = iframes[i]->GetAttribute("src")->Get<Rocket::Core::String>().CString();
		}
		
		DKClass::DKCreate("DKCef");
		//DKEvent::AddEvent(id, "resize", &DKRocketToRML::ResizeIframe, this);
		//DKEvent::AddEvent(id, "mouseover", &DKRocketToRML::MouseOverIframe, this);
		//DKEvent::AddEvent(id, "click", &DKRocketToRML::ClickIframe, this);

		Rocket::Core::Element* cef_texture = element->GetOwnerDocument()->CreateElement("img");
		DKString cef_id = "iframe_"+id;
		cef_texture->SetAttribute("id", cef_id.c_str());

		//This is what RocketSDL2Renderer::LoadTexture and RocketSDL2Renderer::RenderGeometry
		//use to detect if the texture is a cef image. If will contain a iframe_ in the src.
		cef_texture->SetAttribute("src", cef_id.c_str());
		cef_texture->SetProperty("width", "100%");
		cef_texture->SetProperty("height", "100%");
		iframes[i]->AppendChild(cef_texture);
		DKString data = id+","+iTop+","+iLeft+","+iWidth+","+iHeight+","+url;
		DKClass::CallFunc("DKCef::NewBrowser", &data, NULL);
		//DKClass::CallFunc("DKSDLCef::OnResize", &data, NULL); //call OnResize in DKCef window handler
		processed += id+",";
	}

	// <a> tags with href attribute
	Rocket::Core::ElementList aElements;
	Rocket::Core::ElementUtilities::GetElementsByTagName(aElements, element, "a");
	for(unsigned int i=0; i<aElements.size(); ++i){
		if(aElements[i]->HasAttribute("href")){
			aElements[i]->SetProperty("color", "rgb(0,0,255)");
			aElements[i]->SetProperty("text-decoration", "underline");
			DKString id = aElements[i]->GetId().CString();
			//DKEvent::AddEvent(id, "click", &DKRocketToRML::Hyperlink, this);
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

	// <script> tags
	//get the path from the url
	DKString path = DKRocket::Get()->_url+"/";

	Rocket::Core::ElementList scripts;
	Rocket::Core::ElementUtilities::GetElementsByTagName(scripts, element, "script");
	for(unsigned int i=0; i<scripts.size(); i++){
		DKString src;
		if(scripts[i]->HasAttribute("src")){
			src = scripts[i]->GetAttribute("src")->Get<Rocket::Core::String>().CString();
		}
		if(has(processed, src)){ continue; }
		DKString inner = scripts[i]->GetInnerRML().CString();

		if(!src.empty()){
			if(has(path, "http://")){
				DKString js;
				DKClass::DKCreate("DKCurl");
				DKDEBUGVARS(path, src);
					if(!DKCurl::Get()->HttpToString(path+src, js)){
						DKERROR("HttpToString failed on "+path+src+"\n");
						continue;
					}
					processed += src+",";
					DKDuktape::Get()->LoadJSString(path+src, js);
					//DKDuktape::Get()->QueueUrl(path+src, js);
			}
			else{
				processed += src+",";
				DKString app = DKFile::local_assets+src;
				//DKDuktape::Get()->QueueFile(app);
				DKDuktape::LoadFile(app);
			}
		}
		else{
			if(inner.empty()){ continue; }
			//DKDEBUGVARS(inner);
			//DKDuktape::Get()->LoadJSString("testId", inner);
		}
	}

	return true;
}

////////////////////////////////////////////////
bool DKRocketToRML::ResizeIframe(DKEvent* event)
{
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	DKRocket* dkRocket = DKRocket::Get();
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	Rocket::Core::Element* iframe = doc->GetElementById(id.c_str());
	DKString iTop = toString(iframe->GetAbsoluteTop());
	DKString iLeft = toString(iframe->GetAbsoluteLeft());
	DKString iWidth = toString(iframe->GetClientWidth());
	DKString iHeight = toString(iframe->GetClientHeight());
	DKString data = id+","+iTop+","+iLeft+","+iWidth+","+iHeight;
	DKClass::CallFunc("DKSDLCef::OnResize", &data, NULL); //call OnResize in DKCef window handler
	return true;
}

///////////////////////////////////////////////
bool DKRocketToRML::ClickIframe(DKEvent* event)
{
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	DKRocket* dkRocket = DKRocket::Get("");
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	Rocket::Core::Element* iframe = doc->GetElementById(id.c_str());
	DKString iTop = toString(iframe->GetAbsoluteTop());
	DKString iLeft = toString(iframe->GetAbsoluteLeft());
	DKString iWidth = toString(iframe->GetClientWidth());
	DKString iHeight = toString(iframe->GetClientHeight());
	DKString data = id+","+iTop+","+iLeft+","+iWidth+","+iHeight;
	DKClass::CallFunc("DKSDLCef::OnClick", &data, NULL); //call OnResize in DKCef window handler
	return true;
}

///////////////////////////////////////////////////
bool DKRocketToRML::MouseOverIframe(DKEvent* event)
{
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	DKRocket* dkRocket = DKRocket::Get("");
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	Rocket::Core::Element* iframe = doc->GetElementById(id.c_str());
	DKString iTop = toString(iframe->GetAbsoluteTop());
	DKString iLeft = toString(iframe->GetAbsoluteLeft());
	DKString iWidth = toString(iframe->GetClientWidth());
	DKString iHeight = toString(iframe->GetClientHeight());
	DKString data = id+","+iTop+","+iLeft+","+iWidth+","+iHeight;
	DKClass::CallFunc("DKSDLCef::OnMouseOver", &data, NULL); //call OnResize in DKCef window handler
	return true;
}