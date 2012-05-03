module zeal.inflector;

import std.algorithm;
import std.array;
import std.ascii;
import std.conv;
import std.range;
import std.string;

import zeal.utils.singleton;

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

string childize ( string src ) {
	auto offset = src.retro().countUntil( '.' );
	return src[ $ - offset .. $ ];
}

string classify ( string src ) {
	return camelize( singularize( src ) );
}

string dasherize ( string src ) {
	return src.replace( "_", "-" );
}

string foreignKey ( string src, string sep = "_" ) {
	return singularize( modulize( src ).toLower() ) ~ sep ~ "id";
}

string humanize ( string src ) {
	auto atoms = src.split( "_" );
	if ( atoms[ $ - 1 ] == "id" ) {
		atoms.length -= 1;
	}
	atoms[ 0 ] = atoms[ 0 ].capitalize();
	return atoms.join( " " );
}

string modulize ( string src ) {
	auto offset = src.retro().countUntil( '/' );
	return src[ $ - offset .. $ ];
}

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

string packagize ( string src ) {
	auto offset = 1 + src.retro().countUntil( '/' );
	return src[ 0 .. $ - offset ];
}

string parentize ( string src ) {
	auto offset = 1 + src.retro().countUntil( '.' );
	return src[ 0 .. $ - offset ];
}

string singularize ( string src ) {
	return src;
}
