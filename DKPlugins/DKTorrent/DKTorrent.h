#pragma once
#ifndef DKTorrent_H
#define DKTorrent_H
#include "DK/DK.h"

#include <iostream>
#include <thread>
#include <chrono>
#include <fstream>

#include <libtorrent/session.hpp>
#include <libtorrent/add_torrent_params.hpp>
#include <libtorrent/torrent_handle.hpp>
#include <libtorrent/alert_types.hpp>
#include <libtorrent/bencode.hpp>
#include <libtorrent/torrent_status.hpp>

namespace lt = libtorrent;
using clk = std::chrono::steady_clock;

/////////////////////////////////////////////
class DKTorrent : public DKObjectT<DKTorrent>
{
public:
	bool Init();
	bool End();
	void Loop();
	void AddTorrent(const DKString& url);

	lt::session* ses;
	clk::time_point last_save_resume;
	lt::torrent_handle h;
};


REGISTER_OBJECT(DKTorrent, true);

#endif //DKTorrent_H

