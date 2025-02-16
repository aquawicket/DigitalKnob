#include <emscripten/bind.h>

using namespace emscripten;

//////////////////////////////////////////////////
bool test(const std::string& in, std::string& out)
{
	out = in;
    return true;
}

//////////////////////////////////////////
std::string em_test(const std::string& in)
{
	std::string out;
	if(!test(in, out)){ return NULL; }
	return out;
}


EMSCRIPTEN_BINDINGS(my_module){
    function("DK_Test", &em_test);
}