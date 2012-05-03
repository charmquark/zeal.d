/+
Copyright (c) 2012 Christopher Nicholson-Sauls

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
associated documentation files (the "Software"), to deal in the Software without restriction, 
including without limitation the rights to use, copy, modify, merge, publish, distribute, 
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+/
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