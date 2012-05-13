
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

module controllers.application;

import zeal.zeal;

abstract class ApplicationController : Controller {

	protected this () {
	}
	
}

/+
	New Controllers are written by subclassing your ApplicationController, each in their own
	module.  For example, given a Thing resource you might write a RESTful controller like so:
	
		module controllers.things;
		
		import models.thing; // this implementation is not yet part of Zeal
		
		final class ThingsController : ApplicationController {
			mixin Standard;
			
			final void new_ ( Request req, Resposne res ) {
				//...
			}
		
			final void create ( Request req, Resposne res ) {
				//...
			}
		
			final void index ( Request req, Resposne res ) {
				//...
			}
		
			final void show ( Request req, Resposne res ) {
				//...
			}
		
			final void edit ( Request req, Resposne res ) {
				//...
			}
		
			final void update ( Request req, Resposne res ) {
				//...
			}
		
			final void destroy ( Request req, Resposne res ) {
				//...
			}
		
		}
	
	To route this resource you might either edit your config module like this:
		
		enum resources = [ "things" ];
	
	Or you can route it from your app module:
	
		static this () {
			auto app = ZealApplication();
			
			with ( app.router ) {
				resource!"things";
			}
		}

}
+/
