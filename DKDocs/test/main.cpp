#include <algorithm>
#include <iostream>
#include <string>
#include <tuple>
#include <vector>

void findItem(std::string a, const std::vector< std::tuple< std::string, std::string, std::string, std::string> >& v){
    
    std::cout << "Looking for " << a << "       ";
    auto it = std::find_if(v.begin(), v.end(), 
        [&a](const std::tuple<std::string, std::string, std::string, std::string>& e) {
            return  std::get<0>(e) == a || 
                    std::get<1>(e) == a || 
                    std::get<2>(e) == a || 
                    std::get<3>(e) == a;
        });
    
    if (it != v.end())
        std::cout << 
            std::get<0>(*it) << ", " << 
            std::get<1>(*it) << ", " << 
            std::get<2>(*it) << ", " << 
            std::get<3>(*it) << "\n";
    else
        std::cout << "Not Found \n";
}

void findPair(std::string a, std::string b, const std::vector< std::tuple< std::string, std::string, std::string, std::string> >& v){
    
    std::cout << "Looking for " << a << " & " << b << "       ";

    auto it = std::find_if(v.begin(), v.end(), 
        [&a](const std::tuple<std::string, std::string, std::string, std::string>& e) {
            return  std::get<0>(e) == a || 
                    std::get<1>(e) == a || 
                    std::get<2>(e) == a || 
                    std::get<3>(e) == a;
        });
    
	/*
    //get the position of A
    int a_index = -1;
    for(unsigned int i = 0; i < 4; ++i){
        if(i=0 && std::get<0>(*it) == a)
            a_index = 0;
        if(i=1 && std::get<1>(*it) == a)
            a_index = 1;
        if(i=2 && std::get<2>(*it) == a)
            a_index = 2;
        if(i=3 && std::get<3>(*it) == a)
            a_index = 3;
    }
    std::cout << "a_index:" << a_index << " ";
    */
	
    if (it != v.end() &&
        std::get<0>(*it) == b ||
        std::get<1>(*it) == b || 
        std::get<2>(*it) == b || 
        std::get<3>(*it) == b)
        std::cout << 
            std::get<0>(*it) << ", " << 
            std::get<1>(*it) << ", " << 
            std::get<2>(*it) << ", " << 
            std::get<3>(*it) << "\n";
    else
        std::cout << "Not Found \n";
}

int main(int, char**){
	
	std::cout << "Tuple search test \n\n";
	
    std::vector< std::tuple< std::string, std::string, std::string, std::string > > v;
    
    v.emplace_back("a","b","c","d");
    v.emplace_back("A","B","C","D");
    v.emplace_back("1","2","3","4");
    v.emplace_back("I","II","III","IV");

    findItem("A", v);
    findItem("II", v);
    findItem("z", v);
    findItem("c", v);
    
    findPair("A", "B", v);
    findPair("II", "I", v);
    findPair("z", "2", v);
    findPair("c", "b", v);
    findPair("1", "II", v);
    findPair("1", "b", v);
    findPair("IV", "II", v);
    findPair("A", "A", v);

    return 0;
};
