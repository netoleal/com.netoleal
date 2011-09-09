package com.netoleal.display
{
	import flash.geom.ColorTransform;
	
	public class ColoredSprite extends SpriteExtended
	{
		
		private var _color:uint;
		
		public function ColoredSprite( )
		{
			super();
		}
		
		public function set color( value:uint ):void
		{
			var ct:ColorTransform = new ColorTransform( );
			
			ct.color = value;
			_color = value;
			
			this.transform.colorTransform = ct;
		}
		
		public function get color( ):uint
		{
			return ( this.transform.colorTransform != null ) ? this.transform.colorTransform.color: _color;
		}
		
	}
	
}