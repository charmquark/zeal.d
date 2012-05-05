
    ////////////////////////////////////////////////////////////////////////////////////////////
    //  Copyright (c) 2012 Christopher Nicholson-Sauls                                        //
    //                                                                                        //
    //  Permission is hereby granted, free of charge, to any person obtaining a copy of this  //
    //  software and associated documentation files (the "Software"), to deal in the          //
    //  Software without restriction, including without limitation the rights to use, copy,   //
    //  modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,   //
    //  and to permit persons to whom the Software is furnished to do so, subject to the      //
    //  following conditions:                                                                 //
    //                                                                                        //
    //  The above copyright notice and this permission notice shall be included in all        //
    //  copies or substantial portions of the Software.                                       //
    //                                                                                        //
    //  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,   //
    //  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A         //
    //  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT    //
    //  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF  //
    //  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE  //
    //  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                                         //
    ////////////////////////////////////////////////////////////////////////////////////////////

/**
 *
 */
module zeal.http.router;

import std.metastrings;
import std.string;

import vibe.core.log;

import vibe.http.router;
import vibe.http.server;

import zeal.config;
import zeal.inflector;

import zeal.base.controller;

import zeal.utils.singleton;

mixin ConfigImports!( ZealConfig!`resources` );


/**
 *
 */
class ZealRouter : UrlRouter {
	mixin Singleton;
	
	private this () {
		mixin( ConfigRoutes!( ZealConfig!`resources` ) );
	}

	alias void delegate ( HttpServerRequest, HttpServerResponse ) action;
	
	/**
	 *
	 */
	final @property typeof( this ) match ( string _Path, string _C_A, string _Via_ = "any" ) () 
	if ( _Via_ == "delete" || _Via_ == "delete_" || _Via_ == "get" || _Via_ == "post" || _Via_ == "put" || _Via_ == "any" ) {
		enum _Module		= _C_A.parentize();
		enum _Controller	= _Module.camelize();
		enum _Action		= _C_A.childize();
		enum _Via			= _Via_ ~ ( _Via_ == "delete" ? "_" : "" );
		
		mixin(Format!(
			q{
				import controllers.%s;
				auto cb = %sController().%sAction;
				if ( cb == null ) {
					throw new Exception( "Attempted to add route to nonexistant action: %s -> %s" );
				}
				%s( "%s", cb );
			},
			_Module,
			_Controller, _Action,
			_Path, _C_A,
			_Via, _Path
		));
		return this;
	}
	
	/**
	 *
	 */
	final @property typeof( this ) resource ( _C : Controller ) ( _C c ) {
		enum _Base	= "/" ~ _C.stringof[ 0 .. $ - 10 ].decamelize();
		enum _New	= _Base ~ "/new";
		enum _ID 	= _Base ~ "/:id";
		enum _Edit	= _ID ~ "/edit";
		
		if ( auto a = c.newAction     ) get( _New, a );
		if ( auto a = c.createAction  ) post( _Base, a );
		if ( auto a = c.indexAction   ) get( _Base, a );
		if ( auto a = c.showAction    ) get( _ID, a );
		if ( auto a = c.editAction    ) get( _Edit, a );
		if ( auto a = c.updateAction  ) put( _ID, a );
		if ( auto a = c.destroyAction ) delete_( _ID, a );
		
		static if ( is( typeof( c.route( this ) ) ) ) {
			c.route( this );
		}
		
		logInfo( "ZealRouter added resource: %s.", _Base[ 1 .. $ ] );
		return this;
	}

	///ditto
	final @property typeof( this ) resource ( string _R ) () {
		enum _Module		= "controllers." ~ _R;
		enum _Controller	= _R.controllerize();
		
		mixin(Format!(
			q{
				import %s;
				resource!%s = %s();
			},
			_Module,
			_Controller, _Controller
		));
		return this;
	}
	
	/**
	 *
	 */
	final @property typeof( this ) root ( string _Via = "any", _Dummy = void ) ( action cb ) {
		mixin(Format!(
			q{
				%s( "/", cb );
			},
			_Via
		));
		return this;
	}

	///ditto
	final @property typeof( this ) root ( string _C_A, string _Via = "any" ) () {
		match!( "/", _C_A, _Via );
		return this;
	}
	
} // end class ZealRouter


/**
 *
 */
private template ConfigRoutes ( alias _List ) {
	static if ( _List.length > 0 ) {
		pragma( msg, " ** ConfigRoutes( List ) -- routing '" ~ _List[ 0 ] ~ "'" );
		enum ConfigRoutes = 
			Format!( `resource!"%s";`, _List[ 0 ] )
			~ ConfigRoutes!( _List[ 1 .. $ ] )
		;
	}
	else {
		enum ConfigRoutes = "";
	}
}


/**
 *
 */
private mixin template ConfigImports ( alias _List ) {
	static if ( _List.length > 0 ) {
		pragma( msg, " ** ConfigImports( List ) -- importing '" ~ _List[ 0 ] ~ "'" );
		mixin(Format!(
			`import controllers.%s;`,
			_List[ 0 ]
		));
		mixin ConfigImports!( _List[ 1 .. $ ] );
	}
}

