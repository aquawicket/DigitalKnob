#include <emscripten/bind.h>

using namespace emscripten;

////////////////////////////////////////////
bool test(std::string& in, std::string& out)
{
	out = in;
    return true;
}

////////////////////////////////////
std::string em_test(std::string& in)
{
	std::string out;
	if(!test(in, out)){ return false; }
	return out;
}

EMSCRIPTEN_BINDINGS(my_module){
    function("em_test", &em_test);
}