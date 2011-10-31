package com.netoleal.display
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	public class StateKeeper
	{
		private static var dict:Dictionary;
		private static var props:Object = { x: 0, y: 0, rotation: 0, scaleX: 1, scaleY: 1, alpha: 1, visible: true };
		
		public static function keepProperties( target:DisplayObject ):void
		{
			if( !dict ) dict = new Dictionary( );
			var p:Object = new Object( );
			var k:String;
			
			for( k in props )
			{
				p[ k ] = target[ k ];
			}
			
			dict[ target ] = p;
		}
		
		public static function restoreProperties( target:DisplayObject, remove:Boolean = true ):void
		{
			if( !dict ) return;
			
			var p:Object = dict[ target ];
			var k:String;
			
			if( p )
			{
				for( k in p )
				{
					target[ k ] = p[ k ];
				}
				if( remove )
				{
					dict[ target ] = null;
					delete dict[ target ];
				}
			}
		}
	}
}