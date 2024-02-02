/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"

WARNING_DISABLE
#ifdef HAVE_rmlui_debugger
#	include <RmlUi/Debugger.h>
#endif
#include <RmlUi/Core/StreamMemory.h>
#include <Core/PluginRegistry.h>
#include <Core/XMLNodeHandlerDefault.h>
#include <Core/XMLNodeHandlerBody.h>
WARNING_ENABLE

#include "DKRmlInterface/DKRmlInterface.h"
#include "DKWindow/DKWindow.h"
#include "DKSdlRmlDocument/DKSdlRmlDocument.h" // FIXME
#if HAVE_DKDuktape
	#include "DKDuktape/DKDuktape.h"
#endif
#include "DKXml/DKXml.h"
#include "DKRmlInterface/DKRmlHeadInstancer.h"
#ifdef HAVE_DKCurl
#	include "DKCurl/DKCurl.h"
#endif

#include "DKRmlInterface/DKRmlConverter.h"

#define DRAG_FIX 1


DKString 	DKRmlInterface::workingPath;
bool		DKRmlInterface::rml_initialized = false;
bool		DKRmlInterface::rml_debugger_initialized = false;
bool		DKRmlInterface::rml_properties_registered = false;


Rml::ElementInstancer* DKRmlInterface::original_html_instancer = nullptr;
Rml::ElementInstancer* DKRmlInterface::original_head_instancer = nullptr;
Rml::ElementInstancer* DKRmlInterface::original_body_instancer = nullptr;


DKRmlInterface::DKRmlInterface(DKWindow* window) : DKInterface() {
	DKDEBUGFUNC();
	interfaceName = "RmlInterface";
	address[interfaceName] = pointerToAddress(this);
	DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	
	if(!window)
		DKERROR("window invalid! \n");
	
	if (!dkRmlFile) {
		dkRmlFile = new DKRmlFile();
		Rml::SetFileInterface(dkRmlFile);
	}

	//DKINFO("DKRmlInterface(" + window->interfaceName + ") \n");
	if (same(window->interfaceName, "SdlWindow")) {
		DKSdlRmlDocument* dkSdlRmlDocument = new DKSdlRmlDocument(dynamic_cast<DKSDLWindow*>(window), this);
	}
	else {
		DKERROR("No registered window found \n");
		return;
	}

	if (!rml_initialized) {
		if (!Rml::Initialise()) {
			DKERROR("Rml::Initialise(): failed \n");
			return;
		}
		rml_initialized = true;
	}
		
	int w = window->outerWidth();
	int h = window->outerHeight();
	
	//////////////////////////////////////////////////////////////////////
	// Store the html element instancer
	if(!original_html_instancer)
		original_html_instancer = Rml::Factory::GetElementInstancer("html");
	if(!original_html_instancer)
		DKERROR("original_html_instancer invalid! \n");
	Rml::Factory::RegisterElementInstancer("html", original_html_instancer);
	
	// Store the head element instancer
	if(!original_head_instancer)
		original_head_instancer = Rml::Factory::GetElementInstancer("head");
	if(!original_head_instancer)
		DKERROR("original_head_instancer invalid! \n");
	Rml::Factory::RegisterElementInstancer("head", original_head_instancer);
	
	// Store the body element instancer
	if(!original_body_instancer)
		original_body_instancer = Rml::Factory::GetElementInstancer("body");
	if(!original_body_instancer)
		DKERROR("original_body_instancer invalid! \n");
	Rml::Factory::RegisterElementInstancer("body", original_body_instancer);
	///////////////////////////////////////////////////////////////////
	
	context = Rml::CreateContext(interfaceAddress, Rml::Vector2i(w, h));
	if (!context) {
		DKERROR("context is invalid! \n");
		return;
	}
		
#ifdef HAVE_rmlui_debugger
	if (!rml_debugger_initialized) {
		if (!Rml::Debugger::Initialise(context)) {
			DKERROR("Rml::Debugger::Initialise(): failed\n");
			return;
		}
		rml_debugger_initialized = true;
	}
#endif
	
	if (!rml_properties_registered) {
		//Add missing stylesheet properties to silence warnings
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/background-repeat
		Rml::StyleSheetSpecification::RegisterProperty("background-repeat", "repeat", false)
			.AddParser("keyword", "repeat, space, round, no-repeat")
			.AddParser("string")
			.GetId();
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/border-style
		Rml::StyleSheetSpecification::RegisterProperty("border-style", "none", false)
			.AddParser("keyword", "none, hidden")
			.AddParser("string")
			.GetId();
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/list-style-type
		Rml::StyleSheetSpecification::RegisterProperty("list-style-type", "none", false)
			.AddParser("keyword", "none")
			.AddParser("string")
			.GetId();
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/user-select
		Rml::StyleSheetSpecification::RegisterProperty("-webkit-user-select", "none", false)
			.AddParser("keyword", "none")
			.AddParser("string")
			.GetId();
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/user-select
		Rml::StyleSheetSpecification::RegisterProperty("-moz-user-select", "none", false)
			.AddParser("keyword", "none")
			.AddParser("string")
			.GetId();
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/user-select
		Rml::StyleSheetSpecification::RegisterProperty("-ms-user-select", "none", false)
			.AddParser("keyword", "none")
			.AddParser("string")
			.GetId();
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/user-select
		Rml::StyleSheetSpecification::RegisterProperty("user-select", "none", false)
			.AddParser("keyword", "none")
			.AddParser("string")
			.GetId();
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/content
		Rml::StyleSheetSpecification::RegisterProperty("content", "none", false)
			.AddParser("keyword", "none")
			.AddParser("string")
			.GetId();
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/transform
		Rml::StyleSheetSpecification::RegisterProperty("-webkit-transform", "none", false)
			.AddParser("keyword", "none")
			.AddParser("string")
			.GetId();
		//TODO - https://developer.mozilla.org/en-US/docs/Web/CSS/transform
		Rml::StyleSheetSpecification::RegisterProperty("-ms-transform", "none", false)
			.AddParser("keyword", "none")
			.AddParser("string")
			.GetId();

		rml_properties_registered = true;
	}
	
	context->SetDocumentsBaseTag("html");
	DKString rmlFonts = DKFile::local_assets+"DKRmlInterface";
	LoadFonts(rmlFonts);
	LoadFonts(DKFile::local_assets);
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	Rml::Factory::RegisterElementInstancer("html", new Rml::ElementInstancerGeneric<Rml::ElementDocument>);
	Rml::XMLParser::RegisterNodeHandler("html", std::make_shared<Rml::XMLNodeHandlerBody>());
	Rml::XMLParser::RegisterNodeHandler("head", std::make_shared<HeadInstancer>());
	Rml::Factory::RegisterElementInstancer("body", new Rml::ElementInstancerElement);	// NOTE: this instancer must be restored to original before creating new contexts
	Rml::XMLParser::RegisterNodeHandler("body", std::make_shared<Rml::XMLNodeHandlerDefault>());
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	//auto custom_instancer = std::make_unique< Rml::ElementInstancerGeneric< CustomElement > >();
	//Rml::Factory::RegisterElementInstancer("custom", custom_instancer.get());

	DKString html;
	workingPath = DKFile::local_assets;
	DKFile::FileToString(workingPath +"DKRmlInterface/blank.html", html);
	DKFile::ChDir(workingPath);
	DKINFO("DKRmlInterface.workingPath = "+workingPath+"\n");
	LoadHtml(html);
	
	//Rml::Debugger::SetVisible(true);
}

DKRmlInterface::~DKRmlInterface() {
	DKDEBUGFUNC();
	if(context){
		Rml::ReleaseTextures();
		Rml::Shutdown();
		delete Rml::GetRenderInterface();
		delete Rml::GetSystemInterface();
		delete Rml::GetFileInterface();
	}
}

bool DKRmlInterface::LoadFont(const DKString& file){
	DKDEBUGFUNC(file);
	if(!Rml::LoadFontFace(file.c_str()))
		return DKERROR("Could not load "+file+"\n");
	return true;
}

bool DKRmlInterface::LoadFonts(DKString& directory){
	DKDEBUGFUNC(directory);
	
	char ch = directory.back();
	if(ch != '/')
		directory += '/'; //make sure directory has a trailing /

	DKStringArray files;
	DKFile::GetDirectoryContents(directory, files);
	for(unsigned int i=0; i<files.size(); ++i){
		if(DKFile::IsDirectory(directory+files[i]))
			continue;
		DKString extension;
		DKFile::GetExtention(files[i],extension);
		if(same(extension,".otf") || same(extension,".ttf")){
			LoadFont(directory+files[i]);
		}
	}
	return true;
}

bool DKRmlInterface::LoadHtml(const DKString& html){
	DKDEBUGFUNC(html);
	
	// Prepair the html document for RmlUi
	DKString rml;
	DKRmlConverter::HtmlToRml(html, rml);

	//// Clear any document and load the rml into the document
	if (document) {
		document->Close();
		if(context)
			Rml::Factory::ClearStyleSheetCache();
	}
	
	auto stream = std::make_unique<Rml::StreamMemory>((Rml::byte*)rml.c_str(), rml.size());
	stream->SetSourceURL("[document from memory]");
	Rml::PluginRegistry::NotifyDocumentOpen(context, stream->GetSourceURL().GetURL());
	document = context->CreateDocument("html");
	
	Rml::Element* ele = document;
	Rml::XMLParser parser(ele);
	parser.Parse(stream.get());
	//Make sure we have <head> and <body> tags
	Rml::ElementList heads;
	Rml::ElementList bodys;
	Rml::Element* head = NULL;
	Rml::Element* body = NULL;
	document->GetOwnerDocument()->GetElementsByTagName(heads, "head");
	if (!heads.empty())
		head = heads[0];
	document->GetOwnerDocument()->GetElementsByTagName(bodys, "body");
	if (!bodys.empty()) 
		body = bodys[0];
	if (!head && !body) {
		document->GetOwnerDocument()->AppendChild(document->CreateElement("head"), true);
		document->GetOwnerDocument()->AppendChild(document->CreateElement("body"), true);
	}
	else if (head && !body)
		document->GetOwnerDocument()->AppendChild(document->CreateElement("body"), true);
	else if (!head && body)
		document->GetOwnerDocument()->InsertBefore(document->CreateElement("head"), body);
	
	//Load user agent style sheet
	DKString file = DKFile::local_assets + "DKRmlInterface/DKRml.css";
	const Rml::StyleSheetContainer* doc_sheet = document->GetOwnerDocument()->GetStyleSheetContainer();
	Rml::SharedPtr<Rml::StyleSheetContainer> file_sheet = Rml::Factory::InstanceStyleSheetFile(file.c_str());
	if(doc_sheet) { 
		//Combine the file_sheet and the doc_sheet into a new_sheet and load it back to the document
		Rml::SharedPtr<Rml::StyleSheetContainer> new_sheet = doc_sheet->CombineStyleSheetContainer(*file_sheet);
		document->GetOwnerDocument()->SetStyleSheetContainer(std::move(new_sheet));
	}
	else  //no current sheet, just load the file sheet
		document->GetOwnerDocument()->SetStyleSheetContainer(std::move(file_sheet));
		
	//Finish loading the document
	Rml::PluginRegistry::NotifyDocumentLoad(document);
	document->DispatchEvent(Rml::EventId::Load, Rml::Dictionary());
	document->UpdateDocument();
	if(!document){
		document = context->LoadDocumentFromMemory("");
		return DKERROR("document invalid\n");
	}
	Rml::ElementList elements;
	document->GetElementsByTagName(elements, "body");
	if(!elements[0])
		return DKERROR("body element invalid\n");
	DKRmlConverter::PostProcess(this, elements[0]);
	document->Show();

	return true;
}

bool DKRmlInterface::LoadUrl(const DKString& url){
	DKDEBUGFUNC(url);
	DKINFO("DKRmlInterface::LoadUrl("+url+")\n");
	DKString _url = url;
	
	// FIXME: url as full path only works on Windows due to C:/  vs  /users
	if(has(_url,":/")) //could be http:// , https://, file:/// or C:/
		href_ = _url; //absolute path including protocol
	else if(has(_url,"//")){ //could be //www.site.com/style.css or //site.com/style.css
		return DKERROR("no protocol specified\n"); //absolute path without protocol
	}
	else
		_url = workingPath + _url;
	
	//Get the working path;
	std::string::size_type found = _url.find_last_of("/");
	workingPath = _url.substr(0, found + 1);
	DKINFO("DKRmlInterface::LoadUrl(): workingPath: " + workingPath + "\n");
	DKINFO("DKRmlInterface::LoadUrl(): href_: " + href_ + "\n");
	//get the protocol
	std::string::size_type n = _url.find(":");
	protocol = _url.substr(0,n);
	DKINFO("DKRmlInterface::LoadUrl(): protocol: "+protocol+"\n");
	found = _url.rfind("/");
	_path = _url.substr(0,found+1);
	//DKWARN("DKRmlInterface::LoadUrl(): last / at "+toString(found)+"\n");
	DKINFO("DKRmlInterface::LoadUrl(): _path = "+_path+"\n");
	
	DKString html;
#ifdef HAVE_DKCurl
	if(has(_url, "http://") || has(_url, "https://")){
		DKClass::DKCreate("DKCurl");
		if(!DKCurl::Get()->HttpFileExists(_url))
			return DKERROR("Could not locate "+_url+"\n");
		if(!DKCurl::Get()->HttpToString(_url, html))
			return DKERROR("Could not get html from url "+_url+"\n");
	}
#endif
	if (!has(_url, "http://") && !has(_url, "https://")) {
		if(!DKFile::FileToString(_url, html))
			return DKERROR("failed on "+_url+"\n");
	}
	LoadHtml(html);
	
	return true;
}

