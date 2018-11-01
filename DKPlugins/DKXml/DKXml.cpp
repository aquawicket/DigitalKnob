#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKXml/DKXml.h"

#define HEADER_ACCEPT "Accept:text/html,application/xhtml+xml,application/xml"
#define HEADER_USER_AGENT "User-Agent:Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.70 Safari/537.17"

//////////////////
bool DKXml::Init()
{
	DKDEBUGFUNC();
	test_libxml();
	return true;
}

/////////////////
bool DKXml::End()
{
	DKDEBUGFUNC();
	return true;
}

//////////////////////////////////////////////
bool DKXml::LoadDocument(const DKString& file)
{
	DKDEBUGFUNC(file);	
	DKString path = file;
	if(!DKFile::VerifyPath(path)){ return false; } 

	DKString filedata;
	DKFile::FileToString(path,filedata);

	pugi::xml_parse_result result = doc.load(filedata.c_str(), pugi::parse_cdata | pugi::parse_wconv_attribute | pugi::parse_eol);
	if(!result){
		DKString description = result.description();
		DKString offset = toString((int)result.offset);
		DKERROR("DKXml::LoadDocument("+file+"): "+description+" @ character: "+offset+"\n");
		DKFile::StringToFile(filedata, DKFile::local_assets+"XMLlog.txt");
		DKINFO("Saved string to XMLlog.txt\n");
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////
bool DKXml::LoadDocumentFromString(const DKString& string)
{
	DKDEBUGFUNC(string);	
	DKString temp = string;
	Trim(temp);
	replace(temp, "\n", "");
	replace(temp, "\r", "");
	replace(temp, "(\"", "(");
	replace(temp, "\")", ")");

	pugi::xml_parse_result result = doc.load(temp.c_str());
	if(!result){
		std::cout << "XML parsed with errors, attr value: [" << doc.child("node").attribute("attr").value() << "]\n";
		std::cout << "Error description: " << result.description() << "\n";
		std::cout << "Error offset: " << result.offset << " (error at [..." << (temp.c_str() + result.offset) << "]\n\n";
		DKFile::StringToFile(temp, DKFile::local_assets+"XMLlog.txt");
		DKINFO("Saved string to XMLlog.txt\n");
		return false;
	}
	return true;
}

////////////////////////////////////////
bool DKXml::SaveDocument(DKString& file)
{
	DKDEBUGFUNC(file);	
	if(!doc.save_file(file.c_str(), "\t", pugi::format_default | pugi::format_no_declaration | pugi::format_no_escapes)){
		DKERROR("Could not save xml\n");
		return false;
	}
	return true;
}

//////////////////////////////////////////////////
bool DKXml::SaveDocumentToString(DKString& string)
{
	DKDEBUGFUNC(string);	
	std::ostringstream ss; 
	doc.save(ss, "\t", pugi::format_default | pugi::format_no_declaration | pugi::format_no_escapes); 
	string = ss.str();
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKXml::SaveNodes(const DKString& xpath, const DKString& path)
{
	DKDEBUGFUNC(xpath, path);
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}
	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;

		//TODO - removed nested .html nodes
		std::ostringstream nodess;
		node.node().print(nodess);
		DKString str = nodess.str();
		
		DKXml sub;
		sub.LoadDocumentFromString(str.c_str());
		sub.RemoveNodes("//*/*[contains(@id,'.html')]"); //remove inner nodes with id's containing ".html"
		DKString file = node.node().attribute("id").value();
		
		//FIXME - these should not be hard coded.  
		//if(same(file,"DKDev.html")){ continue; }
		//if(same(file,"DKEditor.html")){ continue; }
		//if(same(file,"DKMenuRight.html")){ continue; }
		//if(same(file,"DKMenuRightApp.html")){ continue; }
		//if(same(file,"DKMenuRightEdit.html")){ continue; }
		//if(same(file,"DKMenuRightTree.html")){ continue; }
		//if(same(file,"DKMenuRightWeb.html")){ continue; }
		//if(same(file,"DKAutomate.html")){ continue; }
		//if(same(file,"DKAutomate2.html")){ continue; }

		DKString filepath = path+"/"+file;
		sub.SaveDocument(filepath);

		DKINFO("Saved "+path+"/"+file+"\n");
    }
	return true;
}


///////////////////////////////////////////
bool DKXml::FindNode(const DKString& xpath)
{
	DKDEBUGFUNC(xpath);	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////
bool DKXml::GetNode(const DKString& xpath, DKXmlNode& node)
{
	DKDEBUGFUNC(xpath, node);
	node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////////
bool DKXml::GetNodes(const DKString& xpath, DKXmlNodes& nodes)
{
	DKDEBUGFUNC(xpath, "DKXmlNodes&");	
	nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKXml::GetNodeNames(const DKString& xpath, DKStringArray& arry)
{
	DKDEBUGFUNC(xpath, "DKStringArray&");	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		arry.push_back(node.node().name());
    }
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::GetAttributeValues(const DKString& xpath, const DKString& attrib, DKStringArray& arry)
{
	DKDEBUGFUNC(xpath, attrib, "DKStringArray&");	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		arry.push_back(node.node().attribute(attrib.c_str()).value());
    }
	return true;
}

////////////////////////////////////////////////////////////////
bool DKXml::GetFullNode(const DKString& xpath, DKString& string)
{
	DKDEBUGFUNC(xpath, string);	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	std::ostringstream oss;
	node.print(oss);
	string = oss.str();
	//Trim(string);
	//replace(string, "\n", " ");
	//replace(string, "\r", " ");
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKXml::GetNodeValue(const DKString& xpath, DKString& string)
{
	DKDEBUGFUNC(xpath, string);	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	string = node.child_value();
	Trim(string);
	replace(string, "\n", " ");
	replace(string, "\r", " ");
	return true;
}

///////////////////////////////////////////////////////////////////////////////
bool DKXml::GetChildNodeValue(const DKString& xpath, int num, DKString& string)
{
	DKDEBUGFUNC(xpath, num, string);	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	node = node.first_child();
	int i = 0;
	while(i < num){
		node = node.next_sibling();
		++i;
	}

	string = node.child_value();
	Trim(string);
	replace(string, "\n", " ");
	replace(string, "\r", " ");
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::GetChildAttribute(const DKString& xpath, int num, const DKString& attrib, DKString& string)
{
	DKDEBUGFUNC(xpath, num, attrib, string);	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	node = node.first_child();
	int i = 0;
	while(i < num){
		node = node.next_sibling();
		++i;
	}

	string = node.attribute(attrib.c_str()).value();
	Trim(string);
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::GetAttribute(const DKXmlNode& node, const DKString& attrib, DKString& string)
{
	DKDEBUGFUNC(node, attrib, string);	
	string = node.attribute(attrib.c_str()).value();
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::GetAttribute(const DKString& xpath, const DKString& attrib, DKString& string)
{
	DKDEBUGFUNC(xpath, attrib, string);	
	DKXmlNode node = doc.select_single_node(xpath.c_str()).node();
	if(node.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	string = node.attribute(attrib.c_str()).value();
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::SetAttribute(DKXmlNode& node, const DKString& attrib, const DKString& value)
{
	DKDEBUGFUNC(node, attrib, value);	
	if(!node.attribute(attrib.c_str()).as_bool()){
		node.append_attribute(attrib.c_str());
	}
	node.attribute(attrib.c_str()).set_value(value.c_str());
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////
bool DKXml::SetAttributes(const DKString& xpath, const DKString& attrib, const DKString& value)
{
	DKDEBUGFUNC(xpath, attrib, value);	
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		if(!node.node().attribute(attrib.c_str()).as_bool()){
			node.node().append_attribute(attrib.c_str());
		}
		node.node().attribute(attrib.c_str()).set_value(value.c_str());
    }
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKXml::AppendNode(const DKString& xpath, const DKString& type)
{
	DKDEBUGFUNC(xpath, type);	
	DKXmlNode parent = doc.select_single_node(xpath.c_str()).node();
	parent.append_child(type.c_str());
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKXml::PrependNode(const DKString& xpath, const DKString& type)
{
	DKDEBUGFUNC(xpath, type);
	DKXmlNode parent = doc.select_single_node(xpath.c_str()).node();
	if(parent.first_child().empty()){
		parent.append_child(type.c_str());
	}
	else{
		parent.insert_child_before(type.c_str(), parent.first_child());
	}
	return true;
}

//////////////////////////////////////////////
bool DKXml::RemoveNodes(const DKString& xpath)
{
	DKDEBUGFUNC(xpath);
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}
	while(nodes.size()){
		DKXmlNodes::const_iterator it = nodes.begin();
		pugi::xpath_node node = *it;
		node.node().parent().remove_child(node.node());
		nodes = doc.select_nodes(xpath.c_str());
	}
	return true;
}

///////////////////////////////////////////////////////////////////////////
bool DKXml::RemoveAttributes(const DKString& xpath, const DKString& attrib)
{
	DKDEBUGFUNC(xpath, attrib);
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	for(DKXmlNodes::const_iterator it = nodes.begin(); it != nodes.end(); ++it){
        pugi::xpath_node node = *it;
		node.node().remove_attribute(attrib.c_str());
    }
	return true;
}

///////////////////////////////////////////////
bool DKXml::RemoveInners(const DKString& xpath)
{
	DKDEBUGFUNC(xpath);
	DKXmlNodes nodes = doc.select_nodes(xpath.c_str());
	if(nodes.empty()){
		DKWARN("Could not find xpath: "+xpath+"\n");
		return false;
	}

	//TODO
	return false;

	while(nodes.size()){
		DKXmlNodes::const_iterator it = nodes.begin();
		pugi::xpath_node node = *it;
		//node.node().remove_child(???);
		nodes = doc.select_nodes(xpath.c_str());
	}
	return true;
}


//Test libxml2
bool DKXml::traverse_dom_trees(xmlNode* a_node)
{
	xmlNode *cur_node = NULL;

	if(a_node == NULL){
		//DKERROR("Invalid argument\n");
		return false;
	}

	for(cur_node = a_node; cur_node; cur_node = cur_node->next){
		if(!cur_node){ continue; }
		if(cur_node->name){
			DKINFO("Tag: "+toString((char*)cur_node->name)+"\n");
		}
		if(cur_node->properties){
			if(cur_node->properties->atype){
				DKINFO("  Properties: "+toString((char*)cur_node->properties->atype)+"\n");
			}
		}
		if(cur_node->content){
			DKINFO("    Content: "+toString((char*)cur_node->content)+"\n");
			//DKINFO("Length: "+toString(strlen((char*)cur_node->content))+"\n");
		}

		/*
		if (cur_node->type == XML_ELEMENT_NODE) {
			DKINFO("Node type: Text, name: "+toString((char*)cur_node->name)+"\n");
		}
		else if(cur_node->type == XML_TEXT_NODE){
			DKINFO("node type: Text, node content: "+toString((char*)cur_node->content)+",  content length "+toString(strlen((char*)cur_node->content))+"\n");
		}
		*/
		traverse_dom_trees(cur_node->children);
	}
	return true;
}

bool DKXml::test_libxml()
{
	htmlDocPtr doc;
	xmlNode *roo_element = NULL;

	/* Macro to check API for match with the DLL we are using */
	//LIBXML_TEST_VERSION    
	DKString file = DKFile::local_assets+"test.html";
	
	doc = htmlReadDoc((xmlChar*)file.c_str(), NULL, NULL, HTML_PARSE_RECOVER | HTML_PARSE_NONET);
	//doc = htmlReadFile(file.c_str(), NULL, HTML_PARSE_RECOVER | HTML_PARSE_NONET);
	if(doc == NULL) {
		DKERROR("Document did not parse successfully\n");
		return false;
	}

	roo_element = xmlDocGetRootElement(doc);

	if(roo_element == NULL) {
		DKERROR("empty document\n");
		xmlFreeDoc(doc);
		return 0;
	}

	DKINFO("Root Node is "+toString((char*)roo_element->name)+"\n");
	traverse_dom_trees(roo_element);


	xmlFreeDoc(doc);       // free document
	xmlCleanupParser();    // Free globals
	return true;
}