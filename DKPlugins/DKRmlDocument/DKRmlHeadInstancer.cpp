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
#include "DKRmlDocument/DKRmlHeadInstancer.h"

WARNING_DISABLE
#include <RmlUi/Core/StringUtilities.h>
#include <RmlUi/Core/XMLParser.h>
#include <RmlUi/Core/SystemInterface.h>
#include <Core/DocumentHeader.h>
#include <RmlUi/Core/Core.h>
#include <RmlUi/Core/Element.h>
#include <RmlUi/Core/ElementDocument.h>
#include <RmlUi/Core/URL.h>
#include <RmlUi/Core/Factory.h>
WARNING_ENABLE


static Rml::String Absolutepath(const Rml::String& source, const Rml::String& base){
	Rml::String joined_path;
	::Rml::GetSystemInterface()->JoinPath(joined_path, Rml::StringUtilities::Replace(base, '|', ':'), Rml::StringUtilities::Replace(source, '|', ':'));
	return Rml::StringUtilities::Replace(joined_path, ':', '|');
}

static Rml::DocumentHeader::Resource MakeInlineResource(Rml::XMLParser* parser, const Rml::String& data){
	Rml::DocumentHeader::Resource resource;
	resource.is_inline = true;
	resource.content = data;
	resource.path = parser->GetSourceURL().GetURL();
	resource.line = parser->GetLineNumberOpenTag();
	return resource;
}

static Rml::DocumentHeader::Resource MakeExternalResource(Rml::XMLParser* parser, const Rml::String& path){
	Rml::DocumentHeader::Resource resource;
	resource.is_inline = false;
	resource.path = Absolutepath(path, parser->GetSourceURL().GetURL());
	return resource;
}

HeadInstancer::HeadInstancer(){
}

HeadInstancer::~HeadInstancer(){
}

Rml::Element* HeadInstancer::ElementStart(Rml::XMLParser* parser, const Rml::String& name, const Rml::XMLAttributes& attributes){
	if (name == "head"){
		// Process the head attribute
		parser->GetDocumentHeader()->source = parser->GetSourceURL().GetURL();
	}

	// Is it a link tag?
	else if (name == "link"){
		// Lookup the type and href
		Rml::String type = Rml::StringUtilities::ToLower(Rml::Get<Rml::String>(attributes, "type", ""));
		Rml::String href = Rml::Get<Rml::String>(attributes, "href", "");

		if (/*!type.empty() && */!href.empty()){
			// If its RCSS (... or CSS!), add to the RCSS fields.
			if (type == "text/rcss" || type == "text/css")
				parser->GetDocumentHeader()->rcss.push_back(MakeExternalResource(parser, href));
				// FIXME
				//parser->GetDocumentHeader()->rcss_external.push_back(href);
				//parser->GetDocumentHeader()->rcss[0].path = href;

			// If its an template, add to the template fields
			else if(type == "text/template")
				parser->GetDocumentHeader()->template_resources.push_back(href);
			/*
			else
				Log::ParseError(parser->GetSourceURL().GetURL(), parser->GetLineNumber(), "Invalid link type '%s'", type.c_str());
			*/
		}
		else
			Rml::Log::ParseError(parser->GetSourceURL().GetURL(), parser->GetLineNumber(), "Link tag requires href attributes");
	}

	// Process script tags
	else if (name == "script"){
		// Check if its an external string
		Rml::String src = Rml::Get<Rml::String>(attributes, "src", "");
		if (src.size() > 0)
			parser->GetDocumentHeader()->scripts.push_back(MakeExternalResource(parser, src));
			// FIXME
			//parser->GetDocumentHeader()->scripts_external.push_back(src);
			//parser->GetDocumentHeader()->scripts[0].path = src;
	}

	// Determine the parent
	Rml::Element* parent = parser->GetParseFrame()->element;
	if(!parent){
		Rml::Log::Message(Rml::Log::LT_ERROR, "Failed to find parent for element instancer returned nullptr.");
		return nullptr;
	}

	// Attempt to instance the element with the instancer
	Rml::ElementPtr element = Rml::Factory::InstanceElement(parent, name, name, attributes);
	if (!element){
		Rml::Log::Message(Rml::Log::LT_ERROR, "Failed to create element for tag %s, instancer returned nullptr.", name.c_str());
		return nullptr;
	}

	// Move and append the element to the parent
	Rml::Element* result = parent->AppendChild(std::move(element));
	
	return result;
	// No elements constructed
	//return nullptr;
}

bool HeadInstancer::ElementEnd(Rml::XMLParser* parser, const Rml::String& name){
	// When the head tag closes, inject the header into the active document
	if (name == "head"){
		Rml::Element* element = parser->GetParseFrame()->element;
		if (!element)
			return true;
		Rml::ElementDocument* document = element->GetOwnerDocument();
		if (document)
			document->ProcessHeader(parser->GetDocumentHeader());
	}
	return true;
}

bool HeadInstancer::ElementData(Rml::XMLParser* parser, const Rml::String& data, Rml::XMLDataType type){
	//RMLUI_UNUSED(type);
	const Rml::String& tag = parser->GetParseFrame()->tag;

	// Store the title
	if (tag == "title"){
		Rml::SystemInterface* system_interface = Rml::GetSystemInterface();
		if (system_interface != nullptr)
			system_interface->TranslateString(parser->GetDocumentHeader()->title, data);
	}

	// Store an inline script
	if (tag == "script" && data.size() > 0)
		parser->GetDocumentHeader()->scripts.push_back(MakeInlineResource(parser, data));

		// FIXME
		//parser->GetDocumentHeader()->scripts[0].path = data;
		//parser->GetDocumentHeader()->scripts_inline.push_back(data);

	// Store an inline style
	if (tag == "style" && data.size() > 0)
		parser->GetDocumentHeader()->rcss.push_back(MakeInlineResource(parser, data));

		// FIXME
		//parser->GetDocumentHeader()->rcss_inline.push_back(data);
		//parser->GetDocumentHeader()->rcss[0].path = data;
		//parser->GetDocumentHeader()->rcss_inline_line_numbers.push_back(parser->GetLineNumberOpenTag());
		//parser->GetDocumentHeader()->rcss[0].path = parser->GetLineNumberOpenTag();

	return true;
}
