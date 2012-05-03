module zeal.base.controller;

import vibe.d;

abstract class Controller {
	
	protected mixin template Standard ( bool _REST = true ) {
		mixin zeal.utils.singleton.Singleton;
		
		@property void delegate( Request, Response ) opDispatch ( string _SuffixedName ) () 
		if ( _SuffixedName[ $ - 6 .. $ ] == `Action` ) {
			enum _A = _SuffixedName[ 0 .. $ - 6 ].capitalize();
			
			static if ( is( typeof( mixin( `&do` ~ _A ) ) == delegate ) ) {
				// TODO restful wrapper
				mixin( `return &this.do` ~ _A ~ `;` );
			}
			else {
				return null;
			}
		}
	}

	protected alias HttpServerRequest Request;
	protected alias HttpServerResponse Response;
	
}