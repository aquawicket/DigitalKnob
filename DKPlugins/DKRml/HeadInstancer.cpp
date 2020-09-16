#include "HeadInstancer.h"
#include <RmlUi/Core/StringUtilities.h>
#include <RmlUi/Core/XMLParser.h>
#include <RmlUi/Core/SystemInterface.h>

#include "../../3rdParty/RmlUi-master/Source/Core/DocumentHeader.h"
//#include "TemplateCache.h"
#include <RmlUi/Core/Core.h>
#include <RmlUi/Core/Element.h>
#include <RmlUi/Core/ElementDocument.h>
#include <RmlUi/Core/URL.h>
#include <RmlUi/Core/Factory.h>

HeadInstancer::HeadInstancer()
{
}

HeadInstancer::~HeadInstancer()
{
}

Rml::Element* HeadInstancer::ElementStart(Rml::XMLParser* parser, const Rml::String& name, const Rml::XMLAttributes& attributes)
{
	if (name == "head")
	{
		// Process the head attribute
		parser->GetDocumentHeader()->source = parser->GetSourceURL().GetURL();
	}

	// Is it a link tag?
	else if (name == "link")
	{
		// Lookup the type and href
		Rml::String type = Rml::StringUtilities::ToLower(Rml::Get<Rml::String>(attributes, "type", ""));
		Rml::String href = Rml::Get<Rml::String>(attributes, "href", "");

		if (/*!type.empty() && */!href.empty())
		{
			// If its RCSS (... or CSS!), add to the RCSS fields.
			if (type == "text/rcss" ||
				 type == "text/css")
			{
				parser->GetDocumentHeader()->rcss_external.push_back(href);
			}

			// If its an template, add to the template fields
			else (type == "text/template")
			{
				parser->GetDocumentHeader()->template_resources.push_back(href);
			}
			/*
			else
			{
				Rml::Log::ParseError(parser->GetSourceURL().GetURL(), parser->GetLineNumber(), "Invalid link type '%s'", type.c_str());
			}
			*/
		}
		else
		{
			Rml::Log::ParseError(parser->GetSourceURL().GetURL(), parser->GetLineNumber(), "Link tag requires href attributes");
		}
	}

	// Process script tags
	else if (name == "script")
	{
		// Check if its an external string
		Rml::String src = Rml::Get<Rml::String>(attributes, "src", "");
		if (src.size() > 0)
		{
			parser->GetDocumentHeader()->scripts_external.push_back(src);
		}
	}

	// Determine the parent
	Rml::Element* parent = parser->GetParseFrame()->element;

	// Attempt to instance the element with the instancer
	Rml::ElementPtr element = Rml::Factory::InstanceElement(parent, name, name, attributes);
	if (!element)
	{
		Rml::Log::Message(Rml::Log::LT_ERROR, "Failed to create element for tag %s, instancer returned nullptr.", name.c_str());
		return nullptr;
	}

	// Move and append the element to the parent
	Rml::Element* result = parent->AppendChild(std::move(element));

	return nullptr;
}

bool HeadInstancer::ElementEnd(Rml::XMLParser* parser, const Rml::String& name)
{	
	// When the head tag closes, inject the header into the active document
	if (name == "head")
	{
		Rml::Element* element = parser->GetParseFrame()->element;
		if (!element)
			return true;

		Rml::ElementDocument* document = element->GetOwnerDocument();
		if (document)
			document->ProcessHeader(parser->GetDocumentHeader());
	}
	return true;
}

bool HeadInstancer::ElementData(Rml::XMLParser* parser, const Rml::String& data, Rml::XMLDataType RMLUI_UNUSED_PARAMETER(type))
{
	RMLUI_UNUSED(type);
	const Rml::String& tag = parser->GetParseFrame()->tag;

	// Store the title
	if (tag == "title")
	{
		Rml::SystemInterface* system_interface = Rml::GetSystemInterface();
		if (system_interface != nullptr)
			system_interface->TranslateString(parser->GetDocumentHeader()->title, data);
	}

	// Store an inline script
	if (tag == "script" && data.size() > 0)
		parser->GetDocumentHeader()->scripts_inline.push_back(data);

	// Store an inline style
	if (tag == "style" && data.size() > 0)
	{
		parser->GetDocumentHeader()->rcss_inline.push_back(data);
		parser->GetDocumentHeader()->rcss_inline_line_numbers.push_back(parser->GetLineNumberOpenTag());
	}

	return true;
}