/+
Copyright (c) 2012 Christopher Nicholson-Sauls

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
associated documentation files (the "Software"), to deal in the Software without restriction, 
including without limitation the rights to use, copy, modify, merge, publish, distribute, 
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+/
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
			beginning = true;
		}
		else {
			app.put( cast( char ) ( beginning ? toUpper( c ) : toLower( c ) ) );
			beginning = false;
		}
	}
	return app.data;
}

/**
 *
 */
string childize ( string src ) {
	auto offset = src.retro().countUntil( '.' );
	return src[ $ - offset .. $ ];
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

/**
 *
 */
string modulize ( string src ) {
	auto offset = src.retro().countUntil( '/' );
	return src[ $ - offset .. $ ];
}

/**
 *
 */
string ordinalize ( long n ) {
	immutable SUFF = [ "th", "st", "nd", "rd" ];
	auto result = to!string( n );
	
	if ( n < 4 || n > 20 ) {
		result ~= SUFF[ ( n < 0 ? -n : n ) % 4 ];
	}
	else {
		result ~= SUFF[ 0 ];
	}
	return result;
}

/**
 *
 */
string packagize ( string src ) {
	auto offset = 1 + src.retro().countUntil( '/' );
	return src[ 0 .. $ - offset ];
}

/**
 *
 */
string parentize ( string src ) {
	auto offset = 1 + src.retro().countUntil( '.' );
	return src[ 0 .. $ - offset ];
}

/**
 *
 */
string pluralize ( string src ) {
	//TODO
	return src;
}

/**
 *
 */
string singularize ( string src ) {
	//TODO
	return src;
}
