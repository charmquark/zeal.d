
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

module zeal.utils.keyword;

bool isKeyword ( string s ) {
	switch ( s ) {
		case `abstract`:
		case `alias`:
		case `align`:
		case `asm`:
		case `assert`:
		case `auto`:
		case `body`:
		case `bool`:
		case `break`:
		case `byte`:
		case `case`:
		case `cast`:
		case `catch`:
		case `cdouble`:
		case `cent`:
		case `cfloat`:
		case `char`:
		case `class`:
		case `const`:
		case `continue`:
		case `creal`:
		case `dchar`:
		case `debug`:
		case `default`:
		case `delegate`:
		case `delete`:
		case `deprecated`:
		case `do`:
		case `double`:
		case `else`:
		case `enum`:
		case `export`:
		case `extern`:
		case `false`:
		case `final`:
		case `finally`:
		case `float`:
		case `for`:
		case `foreach`:
		case `foreach_reverse`:
		case `function`:
		case `goto`:
		case `idouble`:
		case `if`:
		case `ifloat`:
		case `immutable`:
		case `import`:
		case `in`:
		case `inout`:
		case `int`:
		case `interface`:
		case `invariant`:
		case `ireal`:
		case `is`:
		case `lazy`:
		case `long`:
		case `macro`:
		case `mixin`:
		case `module`:
		case `new`:
		case `nothrow`:
		case `null`:
		case `out`:
		case `override`:
		case `package`:
		case `pragma`:
		case `private`:
		case `protected`:
		case `public`:
		case `pure`:
		case `real`:
		case `ref`:
		case `return`:
		case `scope`:
		case `shared`:
		case `short`:
		case `static`:
		case `struct`:
		case `super`:
		case `switch`:
		case `synchronized`:
		case `template`:
		case `this`:
		case `throw`:
		case `true`:
		case `try`:
		case `typedef`:
		case `typeid`:
		case `typeof`:
		case `ubyte`:
		case `ucent`:
		case `uint`:
		case `ulong`:
		case `union`:
		case `unittest`:
		case `ushort`:
		case `version`:
		case `void`:
		case `volatile`:
		case `wchar`:
		case `while`:
		case `with`:
			return true;
	
		default:
			return false;
	}
}