#include "DK/stdafx.h"
#include "DKTorrent.h"

// return the name of a torrent status enum
char const* state(lt::torrent_status::state_t s)
{
	switch (s) {
	case lt::torrent_status::checking_files: return "checking";
	case lt::torrent_status::downloading_metadata: return "dl metadata";
	case lt::torrent_status::downloading: return "downloading";
	case lt::torrent_status::finished: return "finished";
	case lt::torrent_status::seeding: return "seeding";
	case lt::torrent_status::allocating: return "allocating";
	case lt::torrent_status::checking_resume_data: return "checking resume";
	default: return "<>";
	}
}

//////////////////////
bool DKTorrent::Init()
{
	DKApp::AppendLoopFunc(&DKTorrent::Loop, this);

	AddTorrent("magnet:?xt=urn:btih:b2a0b542ee6a1c0b693a92908502345e6c079f2c&dn=test+video&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969&tr=udp%3A%2F%2Fzer0day.ch%3A1337&tr=udp%3A%2F%2Fopen.demonii.com%3A1337&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Fexodus.desync.com%3A6969"); //Test
	return true;
}

/////////////////////
bool DKTorrent::End()
{
	return true;
}

//////////////////////
void DKTorrent::Loop()
{
	std::vector<lt::alert*> alerts;
	ses->pop_alerts(&alerts);

	for (lt::alert const* a : alerts) {
		if (auto at = lt::alert_cast<lt::add_torrent_alert>(a)) {
			h = at->handle;
		}
		// if we receive the finished alert or an error, we're done
		if (lt::alert_cast<lt::torrent_finished_alert>(a)) {
			h.save_resume_data();
			//goto done;
		}
		if (lt::alert_cast<lt::torrent_error_alert>(a)) {
			std::cout << a->message() << std::endl;
			//goto done;
		}

		// when resume data is ready, save it
		if (auto rd = lt::alert_cast<lt::save_resume_data_alert>(a)) {
			std::ofstream of(".resume_file", std::ios_base::binary);
			of.unsetf(std::ios_base::skipws);
			lt::bencode(std::ostream_iterator<char>(of)
				, *rd->resume_data);
		}

		if (auto st = lt::alert_cast<lt::state_update_alert>(a)) {
			if (st->status.empty()) continue;

			// we only have a single torrent, so we know which one
			// the status is for
			lt::torrent_status const& s = st->status[0];
			std::cout << "\r" << state(s.state) << " "
				<< (s.download_payload_rate / 1000) << " kB/s "
				<< (s.total_done / 1000) << " kB ("
				<< (s.progress_ppm / 10000) << "%) downloaded\x1b[K";
			std::cout.flush();
		}
	}
	std::this_thread::sleep_for(std::chrono::milliseconds(200));

	// ask the session to post a state_update_alert, to update our
	// state output for the torrent
	ses->post_torrent_updates();

	// save resume data once every 30 seconds
	if (clk::now() - last_save_resume > std::chrono::seconds(30)) {
		h.save_resume_data();
		last_save_resume = clk::now();
	}
}

///////////////////////////////////////////////
void DKTorrent::AddTorrent(const DKString& url)
{
	lt::settings_pack pack;

	pack.set_int(lt::settings_pack::alert_mask
		, lt::alert::error_notification
		| lt::alert::storage_notification
		| lt::alert::status_notification);
	
	ses = new lt::session(pack);
	lt::add_torrent_params atp;
	last_save_resume = clk::now();


	// load resume data from disk and pass it in as we add the magnet link
	std::ifstream ifs(".resume_file", std::ios_base::binary);
	ifs.unsetf(std::ios_base::skipws);
	atp.resume_data.assign(std::istream_iterator<char>(ifs)
		, std::istream_iterator<char>());
	atp.url = url;
	atp.save_path = "."; // save in current dir
	ses->async_add_torrent(atp);

	// this is the handle we'll set once we get the notification of it being
	// added
	//lt::torrent_handle h;
}