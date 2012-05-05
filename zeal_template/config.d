
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
module config;

/**
 * Primary binding address.
 * Default is "127.0.0.1".
 */
// enum address = ;

/**
 * Custom inflections.
 * Each entry should be a pair of elements in the order "singular","plural".  For example:
 * ---
 * enum inflections = [
 *   "cactus", "cacti",
 *   "child", "children",
 *   "formula", "formulae"
 * ]
 * ---
 */
// enum inflections = [  ];

/**
 * HTTP listener port.
 * The default is 8080.
 */
//enum port = ;

/**
 * Automatically routed resources.
 * Each element should be the canonical (lowercase and plural) resource name.  For example:
 * ---
 * enum resources = [ "users", "posts" ];
 * ---
 */
//enum resources = [  ];
