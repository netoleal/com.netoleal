package com.netoleal.common
{
	public class ClickHotspot extends HotSpot
	{
		
		public function ClickHotspot( width:Number, height:Number )
		{
			super( );
						
			this.graphics.beginFill( 0x00FF00, 1 );
			this.graphics.drawRect( 0, 0, width, height );
			this.graphics.endFill( );
		}
		
	}
}