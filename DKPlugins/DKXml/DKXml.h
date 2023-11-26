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
#pragma once
#ifndef DKXml_H
#define DKXml_H
#include "DK/DKClass.h"

//WARNING_DISABLE
#ifdef USE_libxml2
	#include "libxml/HTMLparser.h"
#endif
#include "pugixml.hpp"
//WARNING_ENABLE


typedef pugi::xml_node DKXmlNode;
typedef pugi::xpath_node_set DKXmlNodes;

class DKXml : public DKObjectT<DKXml>
{
public:
	bool Init();
	bool End();
	bool AppendNode(const DKString& xpath, const DKString& type);
	bool FindNode(const DKString& xpath);
	bool GetAttribute(const DKString& xpath, const DKString& attrib, DKString& string);
	bool GetAttribute(const DKXmlNode& node, const DKString& attrib, DKString& string);
	bool GetAttributeValues(const DKString& xpath, const DKString& attrib, DKStringArray& arry);
	bool GetChildAttribute(const DKString& xpath, int num, const DKString& attrib, DKString& string);
	bool GetChildNodeValue(const DKString& xpath, int num, DKString& string);
	bool GetFullNode(const DKString& xpath, DKString& string);
	bool GetNode(const DKString& xpath, DKXmlNode& node);
	bool GetNodeNames(const DKString& xpath, DKStringArray& arry);
	bool GetNodeValue(const DKString& xpath, DKString& string);
	bool GetNodes(const DKString& xpath, DKXmlNodes& nodes);
	bool LoadDocument(const DKString& file);
	bool LoadDocumentFromString(const DKString& string);
	bool PrependNode(const DKString& xpath, const DKString& type);
	bool RemoveAttributes(const DKString& xpath, const DKString& attrib);
	bool RemoveInners(const DKString& xpath);
	bool RemoveNodes(const DKString& xpath);
	bool SaveDocument(DKString& file);
	bool SaveDocumentToString(DKString& string);
	bool SaveNodes(const DKString& xpath, const DKString& path);
	bool SetAttribute(DKXmlNode& node, const DKString& attrib, const DKString& value);
	bool SetAttributes(const DKString& xpath, const DKString& attrib, const DKString& value);
	
	pugi::xml_document doc;

	//Test libmxl2
#ifdef USE_libxml2
	bool traverse_dom_trees(xmlNode* a_node);
	bool test_libxml();
#endif
};
REGISTER_OBJECT(DKXml, true);


#endif //DKXml_H
