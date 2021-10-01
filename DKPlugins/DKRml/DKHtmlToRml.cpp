#include "DKHtmlToRml.h"
#include "DK/DKLog.h"
#include "DKDuktape/DKDuktape.h"
#include "DKXml/DKXml.h"
#include "DKCurl/DKCurl.h"
#include "DKRml/DKRml.h"
#include "tidy.h"
#include "tidybuffio.h"

bool DKHtmlToRml::HtmlToRml(const DKString& html, DKString& rml){
	DKDEBUGFUNC(html, rml);
	
	rml = html;
	
	/*
	// :rgba(r,g,b,a)  <- convert a to 0-255
	size_t end = 0;
	while(has(rml,":rgba(")){
		size_t temp = rml.find(":rgba(",end);
        if(temp == std::string::npos)
			return true;
		size_t start = rml.find(",",temp);
		start = rml.find(",",start+1);
		start = rml.find(",",start+1);
		end = rml.find(")",start);
		if(end == std::string::npos)
			end = rml.size();
		DKString out = rml.substr(start+1, end-start-1);
		float var = toFloat(out);
		if(var){
			int final = (int)(var * 255);
			rml.replace(start+1,end-start-1,toString(final));   
			//return true;
			continue;
		}
		return DKERROR("Error: in HtmlToRml()\n");
	}
	*/
	
	/*
	////////////////////////////////////////////////////////
	DKXml xml;
	if(!xml.LoadDocumentFromString(rml))
		return false;
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
			//AddEvent(id, "click", &DKWidget::Hyperlink, this); //TODO - this needs to exist in the DOM, so post process it after it's added.
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

bool DKHtmlToRml::Hyperlink(DKEvents* event){
	DKDEBUGFUNC(event);
	DKString elementAddress = event->GetId();
	DKRml* dkRml = DKRml::Get("");
	Rml::ElementDocument* doc = dkRml->document;
	Rml::Element* aElement = DKRml::addressToElement(elementAddress);
	DKString value = aElement->GetAttribute("href")->Get<Rml::String>();
	DKINFO("DKWidget::Hyperlink: "+value+"\n");
	//DKUtil::Run(value, "");
	dkRml->LoadUrl(value);
	return true;
}

bool DKHtmlToRml::IndexToRml(const DKString& html, DKString& rml){
	DKDEBUGFUNC(html, rml);
	rml = html;
	TidyFile(rml, rml); //Tidy up the file (XHTML)
	replace(rml, "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"", "");
	replace(rml, "    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">", "");
	replace(rml, "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"", "");
	replace(rml, "    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">", "");
	replace(rml,"<meta name=\"generator\" content=", "");
	replace(rml,"\"HTML Tidy for HTML5 for Windows version 5.0.0\" />", "");
	rml = "<rml>\n"+rml+"</rml>";
	replace(rml, "<!DOCTYPE html>", ""); //Rml doesn't like <!DOCTYPE html> tags
	DKString rml_css = DKFile::local_assets+"DKRml/DKRml.css"; //add DKRml.css to the head tag
	replace(rml, "<head />", "<head></head>");
	replace(rml, "<head>", "<head><link id=\"DKRml/DKRml.css\" type=\"text/css\" href=\""+rml_css+"\"></link>");
	//replace quotes with apostrophes, pugixml will remove quotes inside nodes.
	//FIXME: code like jSFunc('"+var_in_quotes+"') will NOT work. 
	//Other Examples: alert("It's \"game\" time."); or alert('It\'s "game" time.');
	//replace(rml,"\"","'");
	//Rml does not recognize favicons, TODO
	//replace(rml, "<link rel=\"shortcut icon\" id=\"favicon.ico\" href=\"favicon.ico\"></link>", "");
	//DKXml xml;
	//if(!xml.LoadDocumentFromString(rml))
	//	return false;
	/*
	if (!xml.FindNode("//body")) {
		DKERROR("No body tag\n");
		xml.PrependNode("//html", "body");
		//todo, we need to move the rest of the content into the body node.
	}
	*/
	/*
	//Add the base DKRml.css stylesheet
	xml.PrependNode("//head","link");
	xml.SetAttributes("//head/link[1]","rel","stylesheet");
	xml.SetAttributes("//head/link[1]","type","text/css");
	xml.SetAttributes("//head/link[1]","href","DKRml/DKRml.css");
	*/
	//Rml cannot read nodes outside of the body, so add a html node we can work with.
	//xml.PrependNode("//body", "html"); 
	//xml.SaveDocumentToString(rml);
	HtmlToRml(rml, rml);
	return true;
}

bool DKHtmlToRml::PostProcess(Rml::Element* element) {
	DKDEBUGFUNC(element);
	if(!element)
		return DKERROR("DKHtmlToRml::PostProcess(): element invalid\n");
	//we actually want the parent if it has one
	Rml::Element* doc = DKRml::Get()->document;
	if(element != doc && element->GetParentNode())
		element = element->GetParentNode();
	// Create cef contexts for iFrames
	Rml::ElementList iframes;
	Rml::ElementUtilities::GetElementsByTagName(iframes, element, "iframe");
	for(unsigned int i=0; i<iframes.size(); ++i){
		if(iframes[i]->HasChildNodes())
			continue;
		DKString id = iframes[i]->GetId();
		if(has(processed, id))
			continue;
		DKString iTop = toString(iframes[i]->GetAbsoluteTop());
		DKString iLeft = toString(iframes[i]->GetAbsoluteLeft());
		DKString iWidth = toString(iframes[i]->GetClientWidth());
		DKString iHeight = toString(iframes[i]->GetClientHeight());
		DKString url;
		if(!iframes[i]->GetAttribute("src"))
			 return DKERROR("iframe has no source tag\n");
		url = iframes[i]->GetAttribute("src")->Get<Rml::String>();
		DKClass::DKCreate("DKCef");
		//DKEvents::AddEvent(id, "resize", &DKHtmlToRml::ResizeIframe, this);
		//DKEvents::AddEvent(id, "mouseover", &DKHtmlToRml::MouseOverIframe, this);
		//DKEvents::AddEvent(id, "click", &DKHtmlToRml::ClickIframe, this);
		DKString tag = "img";
		Rml::Element* doc = DKRml::Get()->document;
		Rml::Element* cef_texture  = iframes[i]->AppendChild(DKRml::Get()->document->CreateElement(tag.c_str()), true);
		if(!element)
			return DKERROR("element invalid\n");
		DKString cef_id = "iframe_"+id;
		cef_texture->SetAttribute("id", cef_id.c_str());
		//This is what RmlSDL2Renderer::LoadTexture and RmlSDL2Renderer::RenderGeometry
		//use to detect if the texture is a cef image. If will contain a iframe_ in the src.
		cef_texture->SetAttribute("src", cef_id.c_str());
		cef_texture->SetProperty("width", "100%");
		cef_texture->SetProperty("height", "100%");
		DKString data = id+","+iTop+","+iLeft+","+iWidth+","+iHeight+","+url;
		DKClass::CallFunc("DKCef::NewBrowser", &data, NULL);
		//DKClass::CallFunc("DKSDLCef::OnResize", &data, NULL); //call OnResize in DKCef window handler
		processed += id+",";
	}
	// <a> tags with href attribute
	Rml::ElementList aElements;
	Rml::ElementUtilities::GetElementsByTagName(aElements, element, "a");
	for(unsigned int i=0; i<aElements.size(); ++i){
		if(aElements[i]->HasAttribute("href")){
			aElements[i]->SetProperty("color", "rgb(0,0,255)");
			aElements[i]->SetProperty("text-decoration", "underline");
			DKString id = aElements[i]->GetId();
			aElements[i]->AddEventListener("click", DKRml::Get(), false);
			DKString elementAddress = DKRml::elementToAddress(aElements[i]);
			DKEvents::AddEvent(elementAddress, "click", &DKHtmlToRml::Hyperlink, this);
		}
	}
	// <audio> tags
	Rml::ElementList audios;
	Rml::ElementUtilities::GetElementsByTagName(audios, element, "audio");
	for(unsigned int i=0; i<audios.size(); ++i){
		DKClass::DKCreate("DKRmlAudio/DKRmlAudio.js");
		Rml::ElementList sources;
		Rml::ElementUtilities::GetElementsByTagName(sources, audios[i], "source");
		for(unsigned int s=0; s<sources.size(); ++s){
			DKString file = sources[s]->GetAttribute("src")->Get<Rml::String>();
			DKString rval;
			DKDuktape::RunDuktape("DKRmlAudio_Open(\""+file+"\");", rval);
		}
	}
	// <link> tags
	Rml::ElementList links;
	Rml::ElementUtilities::GetElementsByTagName(links, element, "link");
	for(unsigned int i=0; i<links.size(); i++){
		if(!links[i]->HasAttribute("href"))
			continue;
		DKString href = links[i]->GetAttribute("href")->Get<Rml::String>();
		if(has(processed, href))
			continue;
		//replace(href, DKRml::Get()->_path, "");
		processed += href + ",";
		DKClass::DKCreate(href);
	}
	// <script> tags
	//get the path from the url
	DKString path = DKRml::Get()->href;
	std::size_t found = path.find_last_of("/");
	path = path.substr(0,found);
	path += "/";
	Rml::ElementList scripts;
	Rml::ElementUtilities::GetElementsByTagName(scripts, element, "script");
	for(unsigned int i=0; i<scripts.size(); i++){
		DKString src;
		if(scripts[i]->HasAttribute("src"))
			src = scripts[i]->GetAttribute("src")->Get<Rml::String>();
		DKString inner = scripts[i]->GetInnerRML();
		scripts[i]->SetProperty("display", "none");
		if(!src.empty()){
			if(has(processed, src))
				continue;
			if(has(path, "http://")){
				DKString js;
				DKClass::DKCreate("DKCurl");
					if(!DKCurl::Get()->HttpToString(path+src, js)){
						DKERROR("HttpToString failed on "+path+src+"\n");
						continue;
					}
					processed += src+",";
					DKDuktape::Get()->LoadJSString(path+src, js);
			}
			else{
				processed += src+",";
				//DKString app = DKRml::Get()->workingPath +src;
				//DKDuktape::LoadFile(app);
				DKClass::DKCreate(src);
			}
		}
		else{
			if(inner.empty()) 
				continue;
			//replace(inner,"'","\\'");
			//replace(inner,"\n","");
			//replace(inner,"\t","");
			DKDuktape::Get()->LoadJSString("inlineScript", inner);
		}
		
		//TODO: dispatch a script.onload event
		scripts[i]->DispatchEvent(Rml::EventId::Load, Rml::Dictionary());
		//DKEvents::SendEvent(DKRml::elementToAddress(scripts[i]), "load", "");
	}

//DEBUG - Lets see the code
#ifdef DKTODO
	DKRml* dkRml = DKRml::Get();
	Rml::ElementDocument* doc = dkRml->document;
	DKString code = doc->GetContext()->GetRootElement()->GetInnerRML();
	int n = code.rfind("<html");
	if(n < 0){
		DKERROR("DKHtmlToRml::PostProcess(): html tag not found\n");
		return true;
	}
	code = code.substr(n);
	replace(code, "<", "\n<");
	DKINFO("########## Post DKHtmlToRml::PostProcess CODE ##########\n");
	DKINFO(code+"\n");
	DKINFO("##########################################################\n");
#endif
	return true;
}

bool DKHtmlToRml::ResizeIframe(DKEvents* event){
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	DKRml* dkRml = DKRml::Get();
	Rml::ElementDocument* doc = dkRml->document;
	Rml::Element* iframe = doc->GetElementById(id.c_str());
	DKString iTop = toString(iframe->GetAbsoluteTop());
	DKString iLeft = toString(iframe->GetAbsoluteLeft());
	DKString iWidth = toString(iframe->GetClientWidth());
	DKString iHeight = toString(iframe->GetClientHeight());
	DKString data = id+","+iTop+","+iLeft+","+iWidth+","+iHeight;
	DKClass::CallFunc("DKSDLCef::OnResize", &data, NULL); //call OnResize in DKCef window handler
	return true;
}

bool DKHtmlToRml::ClickIframe(DKEvents* event){
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	DKRml* dkRml = DKRml::Get("");
	Rml::ElementDocument* doc = dkRml->document;
	Rml::Element* iframe = doc->GetElementById(id.c_str());
	DKString iTop = toString(iframe->GetAbsoluteTop());
	DKString iLeft = toString(iframe->GetAbsoluteLeft());
	DKString iWidth = toString(iframe->GetClientWidth());
	DKString iHeight = toString(iframe->GetClientHeight());
	DKString data = id+","+iTop+","+iLeft+","+iWidth+","+iHeight;
	DKClass::CallFunc("DKSDLCef::OnClick", &data, NULL); //call OnResize in DKCef window handler
	return true;
}

bool DKHtmlToRml::MouseOverIframe(DKEvents* event){
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	DKRml* dkRml = DKRml::Get("");
	Rml::ElementDocument* doc = dkRml->document;
	Rml::Element* iframe = doc->GetElementById(id.c_str());
	DKString iTop = toString(iframe->GetAbsoluteTop());
	DKString iLeft = toString(iframe->GetAbsoluteLeft());
	DKString iWidth = toString(iframe->GetClientWidth());
	DKString iHeight = toString(iframe->GetClientHeight());
	DKString data = id+","+iTop+","+iLeft+","+iWidth+","+iHeight;
	DKClass::CallFunc("DKSDLCef::OnMouseOver", &data, NULL); //call OnResize in DKCef window handler
	return true;
}

bool DKHtmlToRml::Encode(std::string& data){
	std::string buffer;
	buffer.reserve(data.size());
	for(size_t pos = 0; pos != data.size(); ++pos) {
		switch(data[pos]) {
			//case '&':  buffer.append("&amp;");      
				//break;
			case '\"': buffer.append("&quot;");      
				break;
			//case '\'': buffer.append("&apos;");      
				//break;
			//case '<':  buffer.append("&lt;");        
				//break;
			//case '>':  buffer.append("&gt;");        
				//break;
			default:   
				buffer.append(&data[pos], 1); 
				break;
		}
	}
	data.swap(buffer);
	return true;
}

bool DKHtmlToRml::TidyFile(const DKString& in, DKString& out){
	DKINFO("####### CODE GOING INTO TIDY ##########\n");
	DKINFO(in+"\n");
	DKINFO("#######################################\n");
	const char* input = in.c_str();
	TidyBuffer output = {0};
	TidyBuffer errbuf = {0};
	int rc = -1;
	Bool ok;
	TidyDoc tdoc = tidyCreate();                     // Initialize "document"
	//printf("Tidying:\t%s\n", input);
	ok = tidyOptSetBool(tdoc, TidyXhtmlOut, yes);  // Convert to XHTML
	if(ok)
		rc = tidySetErrorBuffer(tdoc, &errbuf);      // Capture diagnostics
	if(rc >= 0)
		rc = tidyParseString(tdoc, input);           // Parse the input
	if(rc >= 0)
		rc = tidyCleanAndRepair(tdoc);               // Tidy it up!
	if(rc >= 0)
		rc = tidyRunDiagnostics(tdoc);               // Kvetch
	if(rc > 1) // If error, force output.
		rc = (tidyOptSetBool(tdoc, TidyForceOutput, yes) ? rc : -1 );
	if(rc >= 0)
		rc = tidySaveBuffer(tdoc, &output);          // Pretty Print
	if(rc >= 0){
		if(rc > 0){
			//printf( "\nDiagnostics:\n\n%s", errbuf.bp );
			//printf( "\nAnd here is the result:\n\n%s", output.bp );
		}
	}
	else{
		DKERROR("Tidy Error\n"); //printf( "A severe error (%d) occurred.\n", rc );
	}
	out = toString(output.bp);
	tidyBufFree(&output);
	tidyBufFree(&errbuf);
	tidyRelease(tdoc);
	return rc;
	return true;
}

bool DKHtmlToRml::GetOuterHtml(Rml::Element* element, DKString& string){
	DKDEBUGFUNC(element, string);
	/*
	if (!element)
		return false;
	Rml::Element* parent = element->GetParentNode();
	DKString htmlstring;
	//GetInnerHtml(parent, htmlstring);
	htmlstring = parent->GetInnerRML();
	if (htmlstring.empty())
		return false;
	DKXml xml;
	if (!xml.LoadDocumentFromString(htmlstring))
		return false;
	xml.RemoveNodes("handle");
	DKString id = element->GetId();
	DKString style;
	DKWidget::BuildStyleString(id, style);  //FIXME
	xml.SetAttributes("//*[@id=\"" + id + "\"]", "style", style); //Update the style string
	style = "";
	DKStringArray ids;
	GetElements(id, ids); //FIXME
	for (unsigned int i = 0; i < ids.size(); ++i) {
		BuildStyleString(ids[i], style); //FIXME
		xml.SetAttributes("//*[@id=\"" + ids[i] + "\"]", "style", style); //Update the style string
		style = "";
		//TODO - rebuild options string for <select> elements
	}
	if (!xml.GetFullNode("//*[@id=\"" + id + "\"]", string))
		return false;
	return true;
	*/
	return false;
}
