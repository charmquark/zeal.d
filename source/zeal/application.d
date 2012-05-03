module zeal.application;

import vibe.d;

import zeal.http.router;

final class ZealApplication {

	enum ushort DEFAULT_PORT = 8080;

	this () {
	}
	
	this ( string addr, ushort prt = DEFAULT_PORT ) {
		addresses ~= addr;
		port = prt;
	}
	
	this ( string[] addrs, ushort prt = DEFAULT_PORT ) {
		addresses = addrs.dup;
		port = prt;
	}
	
	string[] addresses;
	ushort   port      = DEFAULT_PORT;
	
	@property ZealRouter router () {
		if ( m_router is null ) {
			m_router = ZealRouter();
		}
		return m_router;
	}
	
	void start () {
		if ( !m_started ) {
			m_serverSettings = new HttpServerSettings;
			m_serverSettings.bindAddresses ~= addresses;
			m_serverSettings.port = port;
			listenHttp( m_serverSettings, m_router );
			m_started = true;
		}
	}
	
private:
	
	ZealRouter			m_router;
	HttpServerSettings	m_serverSettings;
	bool 				m_started;

}