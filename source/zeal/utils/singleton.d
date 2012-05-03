module zeal.utils.singleton;


mixin template Singleton () {
	mixin zeal.utils.singleton.SingletonBase;
}

mixin template Singleton ( alias Ctor ) {
	mixin zeal.utils.singleton.SingletonBase;
	
	protected this () {
		static if ( is( typeof( super() ) ) ) {
			super();
		}
		Ctor();
	}
}

mixin template Singleton ( string CtorImpl ) {
	mixin zeal.utils.singleton.SingletonBase;
	
	protected this () {
		static if ( is( typeof( super() ) ) ) {
			super();
		}
		mixin( CtorImpl );
	}
}

private mixin template SingletonBase () {

	static @property typeof( this ) instance () {
		static typeof( this ) self;
		
		if ( self is null ) {
			self = new typeof( this );
		}
		return self;
	}
	
	alias instance opCall;
	
}
