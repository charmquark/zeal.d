/**
 *
 */
module zeal.http.router;

import std.metastrings;
import std.string;

import vibe.d;

import zeal.inflector;

import zeal.base.controller;

import zeal.utils.singleton;

/**
 *
 */
class ZealRouter : UrlRouter {
	mixin Singleton;
	
	private this () {}

	alias void delegate ( HttpServerRequest, HttpServerResponse ) action;
	
	/**
	 *
	 */
	final @property void match ( string _Path, string _C_A, string _Via_ = "get" ) () 
	if ( _Via_ == "delete" || _Via_ == "delete_" || _Via_ == "get" || _Via_ == "post" || _Via_ == "put" ) {
		enum _Module		= _C_A.parentize();
		enum _Controller	= _Module.capitalize();
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
	}
	
	/**
	 *
	 */
	final @property void resource ( _C : Controller ) ( _C c ) {
		enum _Base	= "/" ~ _C.stringof[ 0 .. $ - 10 ];
		enum _New	= _Base ~ "/new";
		enum _ID 	= _Base ~ "/:id";
		enum _Edit	= _ID ~ "/edit";
		
		if ( auto a = c.newAction		) get( _New, a );
		if ( auto a = c.createAction	) post( _Base, a );
		if ( auto a = c.indexAction		) get( _Base, a );
		if ( auto a = c.showAction		) get( _ID, a );
		if ( auto a = c.editAction		) get( _Edit, a );
		if ( auto a = c.updateAction	) put( _ID, a );
		if ( auto a = c.destroyAction	) delete_( _ID, a );
		
		static if ( is( typeof( c.route( this ) ) ) ) {
			c.route( this );
		}
	}

	///ditto
	final @property void resource ( string _R ) () {
		enum _Module		= _R;
		enum _Controller	= _Module.capitalize();
		
		mixin(Format!(
			q{
				import controllers.%s;
				resource = %sController();
			},
			_Module,
			_Controller
		));
	}
	
	/**
	 *
	 */
	final @property void root () ( action cb ) {
		get( "/", cb );
	}

	///ditto
	final @property void root ( string _R_A ) () {
		root!( "get", _R_A );
	}
	
	///ditto
	final @property void root ( string _Via, string _C_A ) () {
		match!( "/", _C_A, "get" );
	}
	
} // end class ZealRouter
