package com.netoleal.utils
{
	public class StringUtils
	{
		public static function leftZero( num:Number, cCount:uint ):String {
			
			var str:String = String( num );
			var sign:String = ( str.charAt( 0 ) == "-" )? "-": "";
			str = str.substr( sign.length );
			
			if( str.length > cCount ) return sign + str;
			else return sign + ( Math.pow( 10, cCount ) + str ).substr( - cCount );
			
		}
		
		public static function replaceAll( theString:String, search:String, replace:String ):String
		{
			var res:String = theString;
			
			while( res.indexOf( search ) != -1 )
			{
				res = res.replace( search, replace );
			}
			
			return res;
		}
		
		public static function sprintf( pattern:String, ... replaces ):String
		{
			if( replaces.length > 0 && replaces[ 0 ] is Array ) replaces = replaces[ 0 ];
			
			var s:String = "%s";
			var ar:Array = pattern.split( s );
			var i:int;
			var r:String = "";
			
			if( ar.length == 1 || replaces.length == 0 ) return pattern;
			if( ar.length == 2 ) return ar.join( replaces[ 0 ] );
			
			while( ( i = pattern.indexOf( s ) ) != -1 )
			{
				r = replaces.shift( ) || "";
				pattern = pattern.substr( 0, i ) + String( r ) + pattern.substr( i + 2 );
			}
			
			return pattern;
		}
	}
}