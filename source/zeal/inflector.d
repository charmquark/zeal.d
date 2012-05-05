
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
module zeal.inflector;

import std.algorithm;
import std.array;
import std.ascii;
import std.conv;
import std.range;
import std.string;

import zeal.config;

/**
 *
 */
string camelize ( string src, bool upperFirst = true ) {
	auto app = appender!string();
	bool beginning = upperFirst;
	foreach ( char c; src ) {
		if ( c == '_' ) {
			beginning = true;
			continue;
		}
		
		if ( c == '/' ) {
			app.put( c );
			beginning = upperFirst;
		}
		else {
			app.put( cast( char ) ( beginning ? toUpper( c ) : toLower( c ) ) );
			beginning = false;
		}
	}
	return app.data;
}
unittest {
	assert( "foo".camelize()            == "Foo"     );
	assert( "foo_bar".camelize()        == "FooBar"  );
	assert( "foo_bar".camelize( false ) == "fooBar"  );
	assert( "foo/bar".camelize()        == "Foo/Bar" );
	assert( "foo/bar".camelize( false ) == "foo/bar" );
}

/**
 *
 */
string childize ( string src ) {
	auto offset = src.retro().countUntil( '.' );
	return src[ $ - offset .. $ ];
}
unittest {
	assert( "foo".childize()     == "foo" );
	assert( "foo.bar".childize() == "bar" );
	assert( "a.b.foo".childize() == "foo" );
}

/**
 *
 */
string classify ( string src ) {
	return src.singularize().camelize();
}

/**
 *
 */
string controllerize ( string src ) {
	return src.camelize().pluralize() ~ "Controller";
}

/**
 *
 */
string dasherize ( string src ) {
	return src.replace( "_", "-" );
}
unittest {
	assert( "foo".dasherize()     == "foo"     );
	assert( "foo_bar".dasherize() == "foo-bar" );
}

/**
 *
 */
string decamelize ( string src ) {
	auto app = appender!string();
	size_t pos;
	foreach ( i, char c; src ) {
		if ( isUpper( c ) && i > 0 ) {
			app.put( src[ pos .. i ].toLower() );
			app.put( "_" );
			pos = i;
		}
	}
	app.put( src[ pos .. $ ].toLower() );
	return app.data;
}
unittest {
	assert( "Foo".decamelize()     == "foo"     );
	assert( "FooBar".decamelize()  == "foo_bar" );
	assert( "fooBar".decamelize()  == "foo_bar" );
	assert( "Foo/Bar".decamelize() == "foo/bar" );
	assert( "foo/bar".decamelize() == "foo/bar" );
}

/**
 *
 */
string foreignKey ( string src, string sep = "_" ) {
	return src.modulize().toLower().singularize() ~ sep ~ "id";
}

/**
 *
 */
string humanize ( string src ) {
	auto atoms = src.split( "_" );
	if ( atoms[ $ - 1 ] == "id" ) {
		atoms.length -= 1;
	}
	atoms[ 0 ] = atoms[ 0 ].capitalize();
	return atoms.join( " " );
}
unittest {
	assert( "foo".humanize()        == "Foo"     );
	assert( "foo_bar".humanize()    == "Foo bar" );
	assert( "foo_bar_id".humanize() == "Foo bar" );
}

/**
 *
 */
string modulize ( string src ) {
	auto offset = src.retro().countUntil( '/' );
	return src[ $ - offset .. $ ];
}
unittest {
	assert( "foo".modulize()     == "foo" );
	assert( "foo/bar".modulize() == "bar" );
}

/**
 *
 */
string ordinalize ( long n ) {
	immutable SUFF = [ "th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th" ];
	
	auto result = to!string( n );
	result ~= SUFF[ result[ $ - 1 ] - '0' ];
	return result;
}
unittest {
	assert( 0.ordinalize()   == "0th"   );
	assert( 1.ordinalize()   == "1st"   );
	assert( 2.ordinalize()   == "2nd"   );
	assert( 3.ordinalize()   == "3rd"   );
	assert( 4.ordinalize()   == "4th"   );
	assert( 5.ordinalize()   == "5th"   );
	assert( 10.ordinalize()  == "10th"  );
	assert( 21.ordinalize()  == "21st"  );
	assert( 22.ordinalize()  == "22nd"  );
	assert( 23.ordinalize()  == "23rd"  );
	assert( 25.ordinalize()  == "25th"  );
	assert( 30.ordinalize()  == "30th"  );
	assert( 31.ordinalize()  == "31st"  );
	assert( 32.ordinalize()  == "32nd"  );
	assert( 33.ordinalize()  == "33rd"  );
	assert( 66.ordinalize()  == "66th"  );
	assert( 100.ordinalize() == "100th" );
	assert( 101.ordinalize() == "101st" );
	assert( 102.ordinalize() == "102nd" );
	assert( 103.ordinalize() == "103rd" );
	assert( 104.ordinalize() == "104th" );
}

/**
 *
 */
string packagize ( string src ) {
	auto offset = 1 + src.retro().countUntil( '/' );
	return src[ 0 .. $ - offset ];
}
unittest {
	assert( "foo".packagize()     == "foo" );
	assert( "foo/bar".packagize() == "foo" );
}

/**
 *
 */
string parentize ( string src ) {
	auto offset = 1 + src.retro().countUntil( '.' );
	return src[ 0 .. $ - offset ];
}
unittest {
	assert( "foo".parentize()     == "foo" );
	assert( "foo.bar".parentize() == "foo" );
	assert( "foo.a.b".parentize() == "foo" );
}


/**
 *
 */
string pluralize ( string src ) {
	// first check custom inflections
	alias ZealConfig!"inflections" custom;
	for (
		size_t s = 0, p = 1;
		p < custom.length;
		s += 2, p += 2
	) {
		if ( src == custom[ s ] ) {
			return custom[ p ];
		}
	}
	
	// second check basic inflections
	for (
		size_t s = 0, p = 1;
		p < BASIC_INFLECTIONS.length;
		s += 2, p += 2
	) {
		if ( src.endsWith( BASIC_INFLECTIONS[ s ] ) ) {
			string result = src[ 0 .. $ - BASIC_INFLECTIONS[ s ].length ];
			result ~= BASIC_INFLECTIONS[ p ];
			return result;
		}
	}
	
	// if all else fails, just apply "s"
	return src ~ "s";
}
unittest {
	assert( "foo".pluralize()   == "foos"    );
	assert( "glass".pluralize() == "glasses" );
	assert( "dash".pluralize()  == "dashes"  );
	assert( "base".pluralize()  == "bases"   );
	assert( "box".pluralize()   == "boxes"   );
	assert( "zero".pluralize()  == "zeroes"  );
	assert( "woman".pluralize() == "women"   );
	assert( "image".pluralize() == "images"  );
}

/**
 *
 */
string singularize ( string src ) {
	// first check custom inflections
	alias ZealConfig!"inflections" custom;
	for (
		size_t s = 0, p = 1;
		p < custom.length;
		s += 2, p += 2
	) {
		if ( src == custom[ p ] ) {
			return custom[ s ];
		}
	}
	
	// second check basic inflections
	for (
		size_t s = 0, p = 1;
		p < BASIC_INFLECTIONS.length;
		s += 2, p += 2
	) {
		if ( src.endsWith( BASIC_INFLECTIONS[ p ] ) ) {
			string result = src[ 0 .. $ - BASIC_INFLECTIONS[ p ].length ];
			result ~= BASIC_INFLECTIONS[ s ];
			return result;
		}
	}
	
	// if all else fails, just remove "s" if present
	if ( src[ $ - 1 ] == 's' ) {
		return src[ 0 .. $ - 1 ];
	}
	return src;
}
unittest {
	assert( "foos".singularize()    == "foo"   );
	assert( "glasses".singularize() == "glass" );
	assert( "dashes".singularize()  == "dash"  );
	assert( "bases".singularize()   == "base"  );
	assert( "boxes".singularize()   == "box"   );
	assert( "zeroes".singularize()  == "zero"  );
	assert( "women".singularize()   == "woman" );
	assert( "images".singularize()  == "image" );
}

////////////////////////////////////////////////////////////////////////////////////////////////////
private:
////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 *
 */
enum BASIC_INFLECTIONS = [
	"ss",  "sses",
	"sh",  "shes",
	"se",  "ses",
	"ox",  "oxes",
	"o",   "oes",
	"man", "men"
];
