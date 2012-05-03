module controllers.pages;

import zeal.d;

final class PagesController : ApplicationController {
	mixin Standard( false );
	
private:

	final void doHome ( Request req, Response res ) {
		res.render!( "pages/home.dt" )();
	}

}


/+

pages
	home()


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