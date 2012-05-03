module app;

import vibe.d;

import zeal.d;

static this () {
	auto app = new ZealApplication( "127.0.0.1" );
	
	with ( app.router ) {
		match!( `/home`, `pages.home` );
		
		root!`pages.home`;
	}
	
	app.start();
}

