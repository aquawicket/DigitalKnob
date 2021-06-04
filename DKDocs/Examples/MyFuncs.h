#include <boost/function.hpp>
#include <boost/bind/bind.hpp>
#include <map>


class MyFuncs
{
public:

	//A list of function names linked to boost::functions.
	static std::map<std::string, boost::function<void (void*, void*)> > myfuncs;
	
	
	//Register a class function by name.       MyFuncs::RegisterFunc("MyClass::Test", &MyClass::Test, instance);
	template<class T>
	static void RegisterFunc(const std::string& name, void (T::*func) (void*, void*), T* instance)
	{
		myfuncs[name] = boost::bind(func, instance, _1, _2);
	}
	
	
	//Call functions by name, with input and output.       MyFunct::CallFunc("MyClass::Test", input, output);
	static void CallFunc(const std::string& name, void* input, void* output)
	{
		myfuncs[name](input, output);
	}
};

std::map<std::string, boost::function<void (void*, void*)> > MyFuncs::myfuncs;