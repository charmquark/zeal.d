zeal.d
======

Zeal attempts to create a more rich web development as an MVC framework layer over Vibe. The primary
goal is to provide features typical to other powerful and successful frameworks such as Rails or
Cake.

Installation
------------

 - Install the Sass Ruby gem, required for _sass-vibe_ on which Zeal depends:
   - `gem install sass`
 - Add to your _package.json_ file under "dependencies":
   - "zeal": ">=0.1.9"
 - Run _vibe_ once to install Zeal and its dependencies.
 - Copy the files from _modules/zeal/template_ to your application. Examine them and modify as 
   desired.

Usage
-----

Zeal follows its own conventions, including a flavor of the Model-View-Controller pattern.

### Models

*TO BE WRITTEN*

### Views

At this time, Zeal simply uses the "Diet" template system provided by Vibe, without any modification
or extension. However, there are future plans to enhance this system slightly.

### Controllers

Similar to other MVC frameworks, you will define controller objects which manage all requests.
Supposing you wanted to manage a resource called _thing_, you would create the file
_source/controllers/things.d_ and edit it similar to the following (each action is optional):

	module controllers.things;
	
	import controllers.application;
	
	final class ThingsController : ApplicationController {
		mixin Standard;
		
		void new_ ( Request req, Response res ) { /*...*/ }
		
		void create ( Request req, Response res ) { /*...*/ }
		
		void index ( Request req, Response res ) { /*...*/ }
		
		void show ( Request req, Response res ) { /*...*/ }
		
		void edit ( Request req, Response res ) { /*...*/ }
		
		void update ( Request req, Response res ) { /*...*/ }
		
		void destroy ( Request req, Response res ) { /*...*/ }
	}

Then to route this resource, you would edit your _app.d_ module:

	module app;
	
	import zeal.d;
	
	static this () {
		auto app = ZealApplication();
		
		with ( app.router ) {
			resource!"things";
		}
	}

Or you could instead specify it in the _config_ module (provided by the Zeal template):

	enum resources = [ "things" ];

And that's it!  Your _ThingsController_ will be automatically instantiated and the actions it
defines are routed in the appropriate RESTful manner.  For example, a request like _GET /things_
would be routed to _ThingsController().index()_.

Stylesheets
-----------

Zeal pulls in the _sass-vibe_ module, and as such lets you define stylesheets as
[Sass](http://sass-lang.com/) scripts. The template includes the file
_assets/styles/application.scss_.

Future Directions
-----------------

The following are definitely on the agenda.

 - Implementing Models as a database abstraction, with validations, named scopes, and other useful 
   features.
 - Responding with different formats based on request URL (similar to the _respond___to_ call in 
   Rails). Could be done either via delegation or via a more elaborate naming convention (a la using
   _showForJson_, for example, to respond to the request _GET /things/123.json_.)

The following are just possibilities for now.

 - Adding support for Coffee scripts, possibly as a separate module (similar to how Sass was
   implemented).
 - Extending controllers and views to semi-automate the passing of variables from the controller
   into the view template.
 - A "Diet" like DSL for writing controllers.
