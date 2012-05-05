
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

module zeal.base.controller;

import vibe.vibe;

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

/+

	THE FOLLOWING IS AN IMAGINARY CONCEPT FOR A "DIET" LIKE CONTROLLER WRITING SYSTEM.
	THIS MAY OR MAY NOT EVER SEE THE LIGHT OF DAY.

---------- SOURCE FILE controllers/users.zeal

users
	new
	create
		if ( user.save() ) {
			flash.notice = "Created user.";
			#->(user)
		}
		else {
			#new
		}

	index
	show
	edit
	update
		user.update( :user );
		if ( user.save() ) {
			flash.notice = "Updated user.";
			#->(user)
		}
		else {
			#edit
		}

	destroy
		user.destroy();
		flash.notice = "Destroyed user.";
		#->back

---------- GENERATED FILE controllers/users.d

final class UserController : ApplicationController {
	mixin Standard;
	
private:

	void doNew ( Request req, Resposne res ) {
		auto user = new User();
		res.render!( "users/new.dt", req, user )();
	}
	
	void doCreate ( Request req, Resposne res ) {
		auto user = new User( res.params[ "user" ] );
		if ( user.save() ) {
			flash.notice = "Created user.";
			redirect( user );
		}
		else {
			render!( "users/new.dt", req, user );
		}
	}
	
	void doIndex ( Request req, Resposne res ) {
		auto users = User.all;
		res.render!( "users/index.dt", req, users );
	}
	
	void doShow ( Request req, Resposne res ) {
		auto user = User.find( res.params[ "id" ] );
		res.render!( "users/show.dt", req, user );
	}
	
	void doEdit ( Request req, Resposne res ) {
		auto user = User.find( res.params[ "id" ] );
		res.render!( "users/edit.dt", req, user );
	}
	
	void doUpdate ( Request req, Resposne res ) {
		auto user = User.find( res.params[ "id" ] );
		user.update( res.params[ "user" ] );
		if ( user.save() ) {
			flash.notice = "Updated user.";
			redirect( user );
		}
		else {
			res.render!( "users/edit.dt", req, user );
		}
	}
	
	void doDestroy ( Request req, Resposne res ) {
		auto user = User.find( res.params[ "id" ] );
		user.destroy();
		flash.notice = "Destroyed user.";
		redirectBack();
	}
}

+/