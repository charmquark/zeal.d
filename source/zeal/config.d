
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

module zeal.config;

import std.metastrings;
import std.string;

import Custom = config;

struct Defaults { static:
	enum string   address     = "127.0.0.1";
	enum string[] inflections = [];
	enum ushort   port        = 8080;
	enum string[] resources   = [];
}

template ZealConfig ( string _ID ) {
	mixin(Format!(
		q{
			static if ( is( typeof( Custom.%s ) ) ) {
				alias Custom.%s ZealConfig;
			}
			else static if ( is( typeof( Defaults.%s ) ) ) {
				alias Defaults.%s ZealConfig;
			}
			else {
				static assert( false, "ZealConfig found no value for id '%s'." );
			}
		},
		_ID,
		_ID,
		_ID,
		_ID,
		_ID
	));
}

template ZealConfig ( string _ID, alias _Default ) {
	mixin(Format!(
		q{
			static if ( is( typeof( Custom.%s ) ) ) {
				alias Custom.%s ZealConfig;
			}
			else {
				alias _Default ZealConfig;
			}
		},
		_ID,
		_ID
	));
}
