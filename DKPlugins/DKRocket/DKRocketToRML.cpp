#include "DKRocketToRML.h"
#include "DK/DKLog.h"
#include "DKDuktape/DKDuktape.h"
#include "DKXml/DKXml.h"
#include "DKCurl/DKCurl.h"
#include "DKRocket/DKRocket.h"
#include "tidy.h"
#include "tidybuffio.h"

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

//////////////////////////////////////////////
bool DKRocketToRML::Hyperlink(DKEvents* event)
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
	TidyFile(rml, rml); //Tidy up the file (XHTML)
	replace(rml, "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"", "");
	replace(rml, "    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">", "");
	replace(rml, "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"", "");
	replace(rml, "    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">", "");
	replace(rml,"<meta name=\"generator\" content=", "");
	replace(rml,"\"HTML Tidy for HTML5 for Windows version 5.0.0\" />", "");
	rml = "<rml>\n"+rml+"</rml>";
	replace(rml, "<!DOCTYPE html>", ""); //Rocket doesn't like <!DOCTYPE html> tags

	//add DKRocket.css to the head tag
	DKString rocket_css = DKFile::local_assets+"DKRocket/DKRocket.css";
	replace(rml, "<head>", "<head><link id=\"DKRocket/DKRocket.css\" type=\"text/css\" href=\""+rocket_css+"\"></link>");


	//replace quotes with apostrophes, pugixml will remove quotes inside nodes.
	//FIXME: code like jSFunc('"+var_in_quotes+"') will NOT work. 
	//Other Examples: alert("It's \"game\" time."); or alert('It\'s "game" time.');
	//replace(rml,"\"","'");
	
	//Rocket does not recognize favicons, TODO
	//replace(rml, "<link rel=\"shortcut icon\" id=\"favicon.ico\" href=\"favicon.ico\"></link>", "");

	//DKXml xml;
	//if(!xml.LoadDocumentFromString(rml)){ return false; }

	/*
	if (!xml.FindNode("//body")) {
		DKERROR("No body tag\n");
		xml.PrependNode("//html", "body");
		//todo, we need to move the rest of the content into the body node.
	}
	*/

	/*
	//Add the base DKRocket.css stylesheet
	xml.PrependNode("//head","link");
	xml.SetAttributes("//head/link[1]","rel","stylesheet");
	xml.SetAttributes("//head/link[1]","type","text/css");
	xml.SetAttributes("//head/link[1]","href","DKRocket/DKRocket.css");
	*/

	//Rocket cannot read nodes outside of the body, so add a html node we can work with.
	//xml.PrependNode("//body", "html"); 

	//xml.SaveDocumentToString(rml);

	HtmlToRml(rml, rml);
	return true;
}

///////////////////////////////////////////////////////////////
bool DKRocketToRML::PostProcess(Rocket::Core::Element* element)
{
	DKDEBUGFUNC(element);
	processed; //debug peek
	if(!element){
		DKWARN("DKRocketToRML::PostProcess(): element invalid\n");
		return false;
	}

	//we actually want the parent if it has one
	if(element->GetParentNode()){
		element = element->GetParentNode();
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

	// <link> tags
	Rocket::Core::ElementList links;
	Rocket::Core::ElementUtilities::GetElementsByTagName(links, element, "link");
	for(unsigned int i=0; i<links.size(); i++){
		if(!links[i]->HasAttribute("href")){ continue; }
		//load the stylesheet in rocket
		DKString href = links[i]->GetAttribute("href")->Get<Rocket::Core::String>().CString();
		//replace(href, DKRocket::Get()->_path, "");
		DKClass::DKCreate(href);
	}

	// <script> tags
	//get the path from the url
	DKString path = DKRocket::Get()->href;
	std::size_t found = path.find_last_of("/");
	path = path.substr(0,found);
	path += "/";

	Rocket::Core::ElementList scripts;
	Rocket::Core::ElementUtilities::GetElementsByTagName(scripts, element, "script");
	for(unsigned int i=0; i<scripts.size(); i++){
		DKString src;
		if(scripts[i]->HasAttribute("src")){
			src = scripts[i]->GetAttribute("src")->Get<Rocket::Core::String>().CString();
		}
		
		DKString inner = scripts[i]->GetInnerRML().CString();
		scripts[i]->SetProperty("display", "none");

		if(!src.empty()){
			if(has(processed, src)){ continue; }
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
				DKString app = DKFile::local_assets+src;
				DKDuktape::LoadFile(app);
			}
		}
		else{
			if(inner.empty()){ continue; }
			
			//replace(inner,"'","\\'");
			replace(inner,"\n","");
			replace(inner,"\t","");

			DKDuktape::Get()->LoadJSString("testId", inner);
		}
	}


	//DEBUG - Lets see the code
	DKRocket* dkRocket = DKRocket::Get();
	Rocket::Core::ElementDocument* doc = dkRocket->document;
	DKString code = doc->GetContext()->GetRootElement()->GetInnerRML().CString();
	int n = code.rfind("<html");
	code = code.substr(n);
	replace(code, "<", "\n<");
	DKINFO("########## Post DKRocketToRML::PostProcess CODE ##########\n");
	DKINFO(code+"\n");
	DKINFO("##########################################################\n");
	return true;

	return true;
}

/////////////////////////////////////////////////
bool DKRocketToRML::ResizeIframe(DKEvents* event)
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

////////////////////////////////////////////////
bool DKRocketToRML::ClickIframe(DKEvents* event)
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

////////////////////////////////////////////////////
bool DKRocketToRML::MouseOverIframe(DKEvents* event)
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

/////////////////////////////////////////////
bool DKRocketToRML::Encode(std::string& data)
{
	std::string buffer;
	buffer.reserve(data.size());
	for(size_t pos = 0; pos != data.size(); ++pos) {
		switch(data[pos]) {
		//case '&':  buffer.append("&amp;");       break;
		case '\"': buffer.append("&quot;");      break;
		//case '\'': buffer.append("&apos;");      break;
		//case '<':  buffer.append("&lt;");        break;
		//case '>':  buffer.append("&gt;");        break;
		default:   buffer.append(&data[pos], 1); break;
		}
	}
	data.swap(buffer);
	return true;
}


///////////////////////////////////////////////////////////////
bool DKRocketToRML::TidyFile(const DKString& in, DKString& out)
{
	const char* input = in.c_str();
	TidyBuffer output = {0};
	TidyBuffer errbuf = {0};
	int rc = -1;
	Bool ok;

	TidyDoc tdoc = tidyCreate();                     // Initialize "document"
	printf("Tidying:\t%s\n", input);

	ok = tidyOptSetBool(tdoc, TidyXhtmlOut, yes);  // Convert to XHTML
	if(ok){
		rc = tidySetErrorBuffer(tdoc, &errbuf);      // Capture diagnostics
	}
	if(rc >= 0){
		rc = tidyParseString(tdoc, input);           // Parse the input
	}
	if(rc >= 0){
		rc = tidyCleanAndRepair(tdoc);               // Tidy it up!
	}
	if(rc >= 0){
		rc = tidyRunDiagnostics(tdoc);               // Kvetch
	}
	if(rc > 1){                                    // If error, force output.
		rc = (tidyOptSetBool(tdoc, TidyForceOutput, yes) ? rc : -1 );
	}
	if(rc >= 0){
		rc = tidySaveBuffer(tdoc, &output);          // Pretty Print
	}

	if(rc >= 0){
		if(rc > 0){
			DKERROR("Tidy Error\n");
			//printf( "\nDiagnostics:\n\n%s", errbuf.bp );
		//printf( "\nAnd here is the result:\n\n%s", output.bp );
		}
	}
	else{
		//printf( "A severe error (%d) occurred.\n", rc );
	}

	out = toString(output.bp);
	tidyBufFree(&output);
	tidyBufFree(&errbuf);
	tidyRelease(tdoc);
	return rc;
	return true;
}