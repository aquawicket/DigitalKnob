#pragma once
#ifndef DKSFMLWindow_H
#define DKSFMLWindow_H

#include <SFML/Window.hpp>
#include "DK/DK.h"

///////////////////////////////////////////////////
class DKSFMLWindow : public DKObjectT<DKSFMLWindow>
{
public:
	bool Init();
	bool End();

	bool handle(sf::Event& e);
	void Process();

	sf::Window window;

	static std::vector<boost::function<bool(sf::Event& e)> > event_funcs;
	static std::vector<boost::function<void()> > draw_funcs;

	template<class T>
	/////////////////////////////////////////////////////////////////////
	static void AddEventFunc(bool (T::*func)(sf::Event& e), T* _this)
	{
		event_funcs.push_back(boost::bind(func, _this, _1));
	}

	template<class T>
	////////////////////////////////////////////////////
	static void AddDrawFunc(void (T::*func)(), T* _this)
	{
		draw_funcs.push_back(boost::bind(func, _this));
	}

	template<class T>
	/////////////////////////////////////////////////////////
	static void AddDrawFuncFirst(void (T::*func)(), T* _this)
	{
		draw_funcs.insert(draw_funcs.begin(), boost::bind(func, _this));
	}
};

REGISTER_OBJECT(DKSFMLWindow, true)

#endif //DKSFMLWindow_H
